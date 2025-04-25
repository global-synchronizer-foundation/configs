#!/usr/bin/env bash

set -euo pipefail

CURL_TIMEOUT=5
CURL_CMD=(curl -fsS -m "$CURL_TIMEOUT")

ENVS_AND_DSO_URLS=(
  DevNet  https://docs.dev.global.canton.network.sync.global/dso
  TestNet https://docs.test.global.canton.network.sync.global/dso
  MainNet https://docs.global.canton.network.sync.global/dso
)

SCRIPTS_DIR=$(dirname "$0")
CONFIGS_DIR="$SCRIPTS_DIR/../configs"

IS_LINUX=$([[ "$(uname -s)" == "Linux" ]] && echo true || echo false)


fetch_dso_data() {
  local dso_response; dso_response=$(
    # "${CURL_CMD[@]}" -w '%{header_json}' "$dso_url"  # NOTE: header_json is supported by curl >= 7.83.0, below is a workaround for older versions
    local response; response=$("${CURL_CMD[@]}" -i "$dso_url") || exit 1
    local response_body; response_body=$(echo "$response" | sed '1,/^\r*$/d')
    local response_header; response_header=$(echo "$response" | sed '/^\r*$/,$d')
    local header_last_modified; header_last_modified=$(echo "$response_header" | grep '^last-modified:' | sed 's/^last-modified: //' | jq -nR '{"last-modified": [inputs | rtrimstr("\r")]}')
    echo "$response_body$header_last_modified"
  ) || { echo "ERROR: Unable to fetch DSO from $dso_url" >&2; return 1; }

  [[ $(echo "$dso_response" | jq -s length) -eq 2 ]] ||
    { echo "ERROR: Unable to parse the response from $dso_url" >&2; return 1; }

  echo "$dso_response"
}

fetch_dso_configs() {
  local env=$1
  local dso_url=$2

  local dso_rules_file="$CONFIGS_DIR/$env/dso-rules.json"
  local amulet_rules_file="$CONFIGS_DIR/$env/amulet-rules.json"

  local dso_response; dso_response=$(fetch_dso_data "$dso_url") || return 1

  local dso_data; dso_data=$(echo "$dso_response" | jq -s '.[0]')
  local header_json; header_json=$(echo "$dso_response" | jq -s '.[1]')
  local last_modified; last_modified=$(echo "$header_json" | jq -r '."last-modified" // empty | .[]')

  if [[ -n $last_modified ]]; then
    local last_modified_seconds modified_seconds_ago

    "$IS_LINUX" &&
      last_modified_seconds=$(date -d "$last_modified" +%s) ||
      last_modified_seconds=$(date -j -f "%a, %d %b %Y %T %Z" "$last_modified" +%s)

    modified_seconds_ago=$(( $(date +%s) - last_modified_seconds ))
  fi

  echo "INFO: DSO data for $env fetched successfully. Last modified: $last_modified ($modified_seconds_ago seconds ago)"

  echo "$dso_data" | jq -S '.dso_rules' > "$dso_rules_file"
  echo "$dso_data" | jq -S '.amulet_rules' > "$amulet_rules_file"
}

main() {
  for ((i = 0; i < ${#ENVS_AND_DSO_URLS[@]}; i += 2)); do
    env=${ENVS_AND_DSO_URLS[i]}
    dso_url=${ENVS_AND_DSO_URLS[i + 1]}
    fetch_dso_configs "$env" "$dso_url"
  done
}

main "$@"
