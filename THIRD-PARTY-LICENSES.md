# Third-Party Software Licenses

このプロジェクトは以下のサードパーティソフトウェアを使用しています。各ソフトウェアのライセンスについては、それぞれのリポジトリをご確認ください。

This project uses the following third-party software. Please refer to each repository for their respective licenses.

## Display and Remote Desktop Software

### KasmVNC
- **Version**: 1.4.0
- **License**: Apache License 2.0
- **Repository**: https://github.com/kasmtech/KasmVNC
- **Description**: VNC server with advanced features including audio support

### Selkies GStreamer
- **Version**: 1.6.2
- **License**: Mozilla Public License 2.0
- **Repository**: https://github.com/selkies-project/selkies-gstreamer
- **Description**: WebRTC remote desktop streaming

### noVNC
- **Version**: 1.3.0
- **License**: MPL-2.0 / Apache-2.0
- **Repository**: https://github.com/novnc/noVNC
- **Description**: HTML5 VNC client (clipboard support fork: https://github.com/tatsuyai713/noVNC)

### x11vnc
- **License**: GPL-2.0
- **Repository**: https://github.com/LibVNC/x11vnc
- **Description**: VNC server for X displays

### Websockify
- **Version**: 0.10.0
- **License**: LGPL-3.0 / MPL-2.0
- **Repository**: https://github.com/novnc/websockify
- **Description**: WebSocket to TCP proxy

## Audio Software

### kclient
- **Version**: 0.4.1
- **License**: GPL-3.0-or-later
- **Repository**: https://github.com/linuxserver/kclient
- **Description**: Audio client for KasmVNC WebSocket-based bidirectional audio (speaker and microphone)
- **License Information**: https://github.com/linuxserver/kclient/blob/main/LICENSE

### kasmbins
- **Version**: 1.15.0
- **License**: Proprietary (Kasm Technologies)
- **Repository**: https://github.com/kasmtech/KasmVNC
- **Description**: Audio helper binaries for KasmVNC
- **Download**: https://kasm-ci.s3.amazonaws.com/kasmbins-amd64-{version}.tar.gz

### PipeWire
- **License**: MIT License
- **Repository**: https://gitlab.freedesktop.org/pipewire/pipewire
- **Description**: Multimedia processing framework

### PulseAudio
- **License**: LGPL-2.1-or-later
- **Repository**: https://gitlab.freedesktop.org/pulseaudio/pulseaudio
- **Description**: Sound server system

## GPU and Graphics Software

### VirtualGL
- **Version**: 3.1.4
- **License**: wxWindows Library Licence, Version 3.1
- **Repository**: https://github.com/VirtualGL/virtualgl
- **Description**: OpenGL acceleration for remote desktop

### NVIDIA VAAPI Driver
- **Version**: 0.0.14
- **License**: MIT License
- **Repository**: https://github.com/elFarto/nvidia-vaapi-driver
- **Description**: VA-API driver for NVIDIA GPUs

## System Software

### RustDesk
- **Version**: 1.4.4
- **License**: AGPL-3.0
- **Repository**: https://github.com/rustdesk/rustdesk
- **Description**: Remote desktop software

### coTURN
- **License**: BSD-3-Clause
- **Repository**: https://github.com/coturn/coturn
- **Description**: TURN and STUN server

### nginx
- **License**: BSD-2-Clause
- **Repository**: https://github.com/nginx/nginx
- **Description**: Web server and reverse proxy

### Supervisor
- **License**: BSD-like (Repoze Public License)
- **Repository**: https://github.com/Supervisor/supervisor
- **Description**: Process control system

## Runtime Dependencies

### Node.js
- **Version**: 20.x
- **License**: MIT License
- **Repository**: https://github.com/nodejs/node
- **Description**: JavaScript runtime (required for kclient)

### GStreamer
- **License**: LGPL-2.1-or-later
- **Repository**: https://gitlab.freedesktop.org/gstreamer/gstreamer
- **Description**: Multimedia framework (required for Selkies)

---

## License Distribution Notice

このプロジェクト自体は Mozilla Public License 2.0 (MPL-2.0) の下でライセンスされています。上記のサードパーティソフトウェアは、それぞれ独自のライセンス条項の下で配布されています。

This project itself is licensed under the Mozilla Public License 2.0 (MPL-2.0). The third-party software listed above are distributed under their respective license terms.

**重要な注意事項 / Important Notice:**
- kclient は GPL-3.0-or-later でライセンスされており、このプロジェクトではソースコードをダウンロードしてビルドして使用しています。ただし、kclientはコンテナイメージ内で独立したプロセスとして動作しており、このプロジェクトの他のコンポーネントとリンクされているわけではありません（単なる集約 - "mere aggregation"）。したがって、GPL FAQ (https://www.gnu.org/licenses/gpl-faq.html#MereAggregation) に基づき、このプロジェクト全体に GPL ライセンスが波及することはありません。
- kclient is licensed under GPL-3.0-or-later, and this project downloads its source code, builds it, and uses the resulting binary. However, kclient runs as an independent process within the container image and is not linked with other components of this project (mere aggregation). Therefore, based on the GPL FAQ (https://www.gnu.org/licenses/gpl-faq.html#MereAggregation), the GPL license does not propagate to this entire project.

各ソフトウェアのライセンスの詳細については、上記のリポジトリリンクをご参照ください。

For detailed license information of each software, please refer to the repository links above.
