#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat << EOF
Usage: $(basename $0) <image_path> <container_name>
    image_path      Docker image to load the containers from.
    container_name  Container name to assign to the containers.
EOF
}

preload_image() {
    if [[ $# -ne 2 ]]; then
        usage >&2
        exit 1
    fi

    local image=$1
    local container=$2

    if [[ -z "${SLURM_JOB_NUM_NODES:-}" ]]; then
        echo "ERROR: no slurm session detected" >&2
        exit 1
    fi

    echo -n "Pre-loading the image on all nodes..."
    srun -N "$SLURM_JOB_NUM_NODES" --ntasks-per-node 1 \
         --container-image "$image" --container-name "$container" true
    echo "Done"

}

main() {
    preload_image "$@"
}

[[ "$0" == "$BASH_SOURCE" ]] && main "$@"
