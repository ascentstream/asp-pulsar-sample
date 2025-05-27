#!/usr/bin/env bash
BASE_DIR=$(cd $(dirname $0); pwd)
echo  $BINDIR
version="$1"
# aasp-pulsar-sample
docker image rm ascentstream/asp-pulsar-sample:${version}
docker buildx  build --platform linux/arm64 -f ${BASE_DIR}/Dockerfile --load -t ascentstream/asp-pulsar-sample:${version} ${BASE_DIR}/target

