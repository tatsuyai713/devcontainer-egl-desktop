#!/bin/bash
# Restart the container

CONTAINER_NAME="${CONTAINER_NAME:-devcontainer-egl-desktop-$(whoami)}"

echo "Restarting container: ${CONTAINER_NAME}"
docker restart "${CONTAINER_NAME}" || echo "Container '${CONTAINER_NAME}' not found"
