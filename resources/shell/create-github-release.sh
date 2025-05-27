#!/usr/bin/env bash

# create_github_release VERSION "FILES"
function create_github_release() {
  readonly CURRENT_BRANCH=$(git branch --show-current)
  readonly RELEASE_VERSION=$1
  readonly FILE=$2
  TAG="$RELEASE_VERSION"
  gh_release_args=("$TAG")
  if [ -n "$FILE" ]; then
    gh_release_args=("${gh_release_args[@]}" $FILE)
  fi
  gh_release_args=("${gh_release_args[@]}" "--target" "$CURRENT_BRANCH")

  gh_release_notes_args=("--generate-notes")
  last_version=$(echo "$TAG" | awk -F '.' '{print $NF}')
  if [ "$last_version" -ne 0 ]; then
      major_version=$(echo "$RELEASE_VERSION" | awk -F '.' '{print $1"."$2"."$3}')
      previous_tag=$(git ls-remote --tags origin | awk -F '/' '{print $NF}' | sort | grep "$major_version" | tail -n 1)
      if [ -n "$previous_tag" ]; then
        commit_partial=$(cat <<EOF
* {{header}}

{{~!-- commit link --}}
{{~#if @root.linkReferences}} ([{{hash}}](
  {{~#if @root.repository}}
    {{~#if @root.host}}
      {{~@root.host}}/
    {{~/if}}
    {{~#if @root.owner}}
      {{~@root.owner}}/
    {{~/if}}
    {{~@root.repository}}
  {{~else}}
    {{~@root.repoUrl}}
  {{~/if}}/
  {{~@root.commit}}/{{hash}}))
{{~else if hash}} {{hash}}{{~/if}}\n
EOF
)
        echo "module.exports={writerOpts:{commitPartial:\`$commit_partial\`},gitRawCommitsOpts:{from:'$previous_tag'}};" > release-notes-config.js
        echo "{\"currentTag\": \"$TAG\", \"previousTag\": \"$previous_tag\", \"version\": \"$RELEASE_VERSION\"}" > release-notes-context.json
        notes=$(npm exec conventional-changelog-cli@3.0.0 -- --config ./release-notes-config.js --context ./release-notes-context.json)
        gh_release_notes_args=("--notes" "$notes")
      fi
  fi

  gh release create "${gh_release_args[@]}" "${gh_release_notes_args[@]}"
}
