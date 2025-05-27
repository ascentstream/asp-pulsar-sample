#!/usr/bin/env bash

set -e

readonly CURRENT_PATH=$(cd "$(dirname "$0")";pwd)
readonly PULSAR_VERSION=${PULSAR_VERSION#v}

ROOT_PATH=$(dirname "$CURRENT_PATH")
source "$ROOT_PATH/shell/create-github-release.sh"

function list_functions() {
  declare -F | awk '{print $NF}' | sort | grep -E '^ci_' | sed 's/^ci_//'
}

function ci_prepare_release() {
  pushd "$CONSOLE_REPO_PATH"
  RELEASE_VERSION="community-edition-$RELEASE_VERSION"
  echo "Release version: $RELEASE_VERSION"

  readonly BRANCH_NAME=release-branch-"$RELEASE_VERSION"
  git checkout -b "$BRANCH_NAME"
  git push origin "$BRANCH_NAME" -d || true
  git push origin "$BRANCH_NAME"
  popd
}

function ci_build_and_deploy() {
  pushd "$CONSOLE_REPO_PATH"
  RELEASE_VERSION="community-edition-$RELEASE_VERSION"
  mvn -Prelease-package -Dmaven.test.skip=true clean install -U

  mkdir dist
  cp /home/ubuntu/actions-runner/_work/asp-manager-console/asp-manager-console/target/*.gz dist/
  create_github_release "$RELEASE_VERSION" "dist/*"
  popd
}

if [ -z "$1" ]; then
  echo "usage: $0 [ci_tool_function_name]"
  echo "Available ci tool functions:"
  list_functions
  exit 1
fi

"ci_$1"
