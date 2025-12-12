#!/bin/bash
# Stop the running container

CONTAINER_NAME="${CONTAINER_NAME:-devcontainer-egl-desktop-$(whoami)}"

echo "Stopping container: ${CONTAINER_NAME}"
docker stop "${CONTAINER_NAME}" || echo "Container '${CONTAINER_NAME}' not found or already stopped"
