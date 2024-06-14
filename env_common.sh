#!/usr/bin/env bash

set -euo pipefail

RESULTS_DIR=${RESULTS_DIR:-${PWD}/results}
[ -d "$RESULTS_DIR" ] || mkdir -p "$RESULTS_DIR"

export CONTAINER_MOUNTS="$PWD/container_scripts/:/container_scripts,${RESULTS_DIR}:/results"

export UCX_PROTO_INFO=${UCX_PROTO_INFO:=y}
export UCX_LOG_LEVEL=${UCX_LOG_LEVEL:=info}
export UCX_CUDA_COPY_DMABUF=no
#export UCX_RNDV_FRAG_MEM_TYPE=cuda
