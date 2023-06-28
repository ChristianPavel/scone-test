#!/usr/bin/env bash

declare -a on_exit_items

function on_exit()
{
    for i in "${on_exit_items[@]}"
    do
        echo "on_exit: $i"
        eval $i
    done
}

function add_on_exit()
{
    local n=${#on_exit_items[*]}
    on_exit_items[$n]="$*"
    if [[ $n -eq 0 ]]; then
        echo "Setting trap"
        trap on_exit EXIT INT TERM
    fi
}

err_report() {
    echo "errexit on line $(caller)" >&2
}

trap 'err_report $LINENO' ERR

function determine_sgx_device {
    export SGXDEVICE="/dev/sgx/enclave"
    export MOUNT_SGXDEVICE="--device=/dev/sgx/enclave"
    if [[ ! -e "$SGXDEVICE" ]] ; then
        export SGXDEVICE="/dev/sgx_enclave"
        export MOUNT_SGXDEVICE="--device=/dev/sgx_enclave"
        if [[ ! -e "$SGXDEVICE" ]] ; then
            export SGXDEVICE="/dev/sgx"
            export MOUNT_SGXDEVICE="--device=/dev/sgx"
            if [[ ! -e "$SGXDEVICE" ]] ; then
                export SGXDEVICE="/dev/isgx"
                export MOUNT_SGXDEVICE="--device=/dev/isgx"
                if [[ ! -c "$SGXDEVICE" ]] ; then
                    echo "Warning: No SGX device found! Will run in SIM mode." > /dev/stderr
                    export MOUNT_SGXDEVICE=""
                    export SGXDEVICE=""
                fi
            fi
        fi
    fi
}

docker login registry.scontain.com -u "$SCONE_REGISTRY_USERNAME" -p "$SCONE_REGISTRY_TOKEN"

determine_sgx_device
echo "$SGXDEVICE"