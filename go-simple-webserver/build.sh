#!/usr/bin/env bash

set -o errexit
set -o pipefail
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

readonly SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "$SCRIPT_DIR/../docker_login_scone_registry.sh"
source "$SCRIPT_DIR/../helper.sh"

# SCONE Docs link for this example: https://sconedocs.github.io/GO/

docker run --rm -it $MOUNT_SGXDEVICE \
    -p 8080:8080 \
    -v "$SCRIPT_DIR":/src/ \
    -e "SCONE_MODE=HW" \
    -e "SGX_PRERELEASE=1" \
    -e "SGX_DEBUG=0" \
    registry.scontain.com/sconecuratedimages/crosscompilers /bin/bash -c "\
    cd /src/; \
    SCONE_HEAP=1G scone-gccgo web-srv.go -O3 -o web-srv-go -g; \
    SCONE_VERSION=1 ./web-srv-go
"

# run those commands manually!
curl localhost:8080/SCONE;
curl localhost:8080/EXIT;