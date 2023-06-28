#!/usr/bin/env bash

set -o errexit
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/../docker_login_scone_registry.sh"
source "$SCRIPT_DIR/../helper.sh"

readonly DOCKER_CONTAINER_NAME="scone-helloworld"

# SCONE Docs link for this example: https://sconedocs.github.io/dockerfileexample/

docker build --pull -t "$DOCKER_CONTAINER_NAME" .

add_on_exit docker image rm "$DOCKER_CONTAINER_NAME"

echo "got here: $MOUNT_SGXDEVICE"

# non simulator mode
docker run $MOUNT_SGXDEVICE --rm "$DOCKER_CONTAINER_NAME"

# simulator mode
# docker run --rm "$DOCKER_CONTAINER_NAME"