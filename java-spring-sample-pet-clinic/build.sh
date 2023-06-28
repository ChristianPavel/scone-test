#!/usr/bin/env bash

set -o errexit
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/../docker_login_scone_registry.sh"
source "$SCRIPT_DIR/../helper.sh"

readonly DOCKER_CONTAINER_NAME="scone-java-spring-pet-clinic"

# SCONE Docs link for this example: https://sconedocs.github.io/multistagebuild/

# docker run $MOUNT_SGXDEVICE -it --memory="7g" --memory-swap="10g" registry.scontain.com/sconecuratedimages/apps:8-jdk-alpine bash
# docker run $MOUNT_SGXDEVICE -it --memory="7g" --memory-swap="10g" registry.scontain.com/sconecuratedimages/apps:11-jdk-alpine bash
# docker run $MOUNT_SGXDEVICE -it --memory="7g" --memory-swap="10g" registry.scontain.com/sconecuratedimages/apps:15-jdk-alpine bash
# docker run $MOUNT_SGXDEVICE -it --memory="7g" --memory-swap="10g" registry.scontain.com/sconecuratedimages/apps:17-ea-jdk-alpine bash
# exit

docker build --pull -t "$DOCKER_CONTAINER_NAME" .

add_on_exit docker image rm "$DOCKER_CONTAINER_NAME"

# non simulator mode
docker run $MOUNT_SGXDEVICE --rm --memory="7g" --memory-swap="10g" -p 127.0.0.1:8080:8080 "$DOCKER_CONTAINER_NAME" 

# simulator mode
# docker run --rm "$DOCKER_CONTAINER_NAME"