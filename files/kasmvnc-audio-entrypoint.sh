#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

set -e

echo "Starting KasmVNC audio service..."

# Internal ports are fixed (not affected by UID)
KASMVNC_PORT=${SELKIES_PORT:-8081}
KASMAUDIO_PORT=4900
KASMAUDIO_STREAM_PORT=4901  # Port for receiving MPEG-TS stream from ffmpeg

echo "Audio configuration: UID=$(id -u), KasmVNC Port=${KASMVNC_PORT}, Audio Port=${KASMAUDIO_PORT}, Stream Port=${KASMAUDIO_STREAM_PORT}"

# Wait for XDG_RUNTIME_DIR and PipeWire-Pulse
until [ -d "${XDG_RUNTIME_DIR}" ]; do sleep 0.5; done
until [ -S "${XDG_RUNTIME_DIR}/pulse/native" ]; do sleep 0.5; done

echo "PulseAudio socket found at ${XDG_RUNTIME_DIR}/pulse/native"

# Create virtual audio sink for KasmVNC audio output
USER_UID=$(id -u)
VIRTUAL_SINK="VirtualSpeaker-${USER_UID}"

echo "Creating virtual audio sink: ${VIRTUAL_SINK}"
pactl load-module module-null-sink \
    sink_name="${VIRTUAL_SINK}" \
    sink_properties="device.description='Virtual_Speaker_${USER_UID}'" \
    rate=44100 \
    channels=2 || echo "Virtual sink already exists"

# Set as default sink
pactl set-default-sink "${VIRTUAL_SINK}"
echo "Default audio sink set to ${VIRTUAL_SINK}"

# Wait for KasmVNC to be ready
until curl -k -s https://localhost:${KASMVNC_PORT} > /dev/null 2>&1 || curl -s http://localhost:${KASMVNC_PORT} > /dev/null 2>&1; do 
    echo "Waiting for KasmVNC on port ${KASMVNC_PORT}..."
    sleep 1
done

# Set audio environment variables
export PULSE_SERVER="unix:${XDG_RUNTIME_DIR}/pulse/native"
export PULSE_RUNTIME_PATH="${XDG_RUNTIME_DIR}/pulse"

# Create user-specific audio directories
mkdir -p "${XDG_RUNTIME_DIR}/audio-${USER_UID}"

echo "Starting kasmbins audio relay on port ${KASMAUDIO_PORT}..."
# Start kasmbins audio relay following LinuxServer format
# kasmbins will listen on stream-port for MPEG-TS and websocket-port for browser connections
# KasmVNC will proxy /kasmaudio to these ports
/kasmbins/kasm_websocket_relay/kasm_audio_out-linux \
  kasmaudio \
  ${KASMAUDIO_STREAM_PORT} \
  ${KASMAUDIO_PORT} \
  /etc/ssl/certs/ssl-cert-snakeoil.pem \
  /etc/ssl/private/ssl-cert-snakeoil.key \
  "${SELKIES_BASIC_AUTH_USER:-${USER}}:${SELKIES_BASIC_AUTH_PASSWORD:-${PASSWD}}" \
  > "/tmp/kasmaudio-${USER_UID}.log" 2>&1 &

# Wait for kasmbins to start
sleep 2

echo "Starting PulseAudio capture with ffmpeg..."
# Capture audio from virtual sink monitor following LinuxServer format
HOME=/var/run/pulse no_proxy=127.0.0.1 ffmpeg \
  -v verbose \
  -f pulse \
  -fragment_size ${PULSEAUDIO_FRAGMENT_SIZE:-2000} \
  -ar 44100 \
  -i "${VIRTUAL_SINK}.monitor" \
  -f mpegts \
  -correct_ts_overflow 0 \
  -codec:a mp2 \
  -b:a 128k \
  -ac 1 \
  -muxdelay 0.001 \
  http://127.0.0.1:${KASMAUDIO_STREAM_PORT}/kasmaudio

