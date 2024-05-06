#!/usr/bin/env bash

set -euo pipefail

print_run() {
    echo "Command: " "$*"
    "$@"
}

run_container_node() {
    local container=$1
    local node=$2
    shift 2
    if [ -n "${CONTAINER_MOUNTS:-}" ]; then
        set -- --container-mounts "$CONTAINER_MOUNTS" "$@"
    fi
    set -- srun --mpi=pmix -N 1 --ntasks-per-node 1 -w "$node" \
        --container-name "$container" --overlap "$@"
    print_run "$@"
}
