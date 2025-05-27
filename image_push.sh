#!/usr/bin/env bash

BASE_DIR=$(cd $(dirname $0); pwd)/..
echo  $BINDIR
version="$1"
registry="$2"

IMG=${registry}/ascentstream/asp-playgroud-sample:${version} make docker-buildx



