#!/bin/bash
# Access container shell

CONTAINER_NAME="${CONTAINER_NAME:-devcontainer-egl-desktop-$(whoami)}"
AS_ROOT="${AS_ROOT:-false}"

if [ "${AS_ROOT}" = "true" ]; then
    echo "Opening shell as root in container: ${CONTAINER_NAME}"
    docker exec -u root -it "${CONTAINER_NAME}" bash
else
    echo "Opening shell in container: ${CONTAINER_NAME}"
    docker exec -it "${CONTAINER_NAME}" bash
fi
