#!/usr/bin/env bash

set -euo pipefail

print_run() {
    echo "Command: " "$*"
    "$@"
}

srun_common() {
    local container=$1
    shift 1

    if [ -n "${CONTAINER_MOUNTS:-}" ]; then
        set -- --container-mounts "$CONTAINER_MOUNTS" "$@"
    fi

    set -- srun --mpi=pmix --overlap --container-name "$container" "$@"
    print_run "$@"

}

# Run the command line in a given container on a given node
# with a given number of tasks on that node.
run_container_node() {
    local container=$1
    local node=$2
    local ntasks=$3
    shift 3

    set -- -N 1 --ntasks-per-node "$ntasks" -w "$node" "$@"
    srun_common "$container" "$@"
}
