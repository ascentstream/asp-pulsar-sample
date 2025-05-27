#!/usr/bin/env bash
BASE_DIR=$(cd $(dirname $0); pwd)
echo  $BINDIR
version="$1"
# asp-manager-console-server
docker image rm ascentstream/asp-playgroud-sample:${version}
docker buildx  build --platform linux/arm64 -f ${BASE_DIR}/Dockerfile --load -t ascentstream/asp-playgroud-sample:${version} ${BASE_DIR}/target

