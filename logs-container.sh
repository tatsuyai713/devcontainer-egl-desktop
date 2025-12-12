#!/bin/bash
# View container logs

CONTAINER_NAME="${CONTAINER_NAME:-devcontainer-egl-desktop-$(whoami)}"
FOLLOW="${FOLLOW:-false}"

if [ "${FOLLOW}" = "true" ]; then
    echo "Following logs for container: ${CONTAINER_NAME}"
    echo "Press Ctrl+C to stop"
    docker logs -f "${CONTAINER_NAME}"
else
    echo "Showing logs for container: ${CONTAINER_NAME}"
    docker logs --tail 100 "${CONTAINER_NAME}"
    echo ""
    echo "To follow logs in real-time: FOLLOW=true ./logs-container.sh"
fi
