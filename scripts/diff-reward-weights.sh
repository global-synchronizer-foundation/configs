#!/usr/bin/env bash

# diff-reward-weights.sh
#
# Compare the reward weights in the approved-sv-id-values.yaml file with the weights from the DSO API

set -euo pipefail

CURL_TIMEOUT=5
CURL_CMD=(curl -fsS -m "$CURL_TIMEOUT")

ENVS_AND_DSO_URLS=(
  DevNet  https://docs.dev.global.canton.network.sync.global/dso
  TestNet https://docs.test.global.canton.network.sync.global/dso
  MainNet https://docs.global.canton.network.sync.global/dso
)

SCRIPTS_DIR=$(dirname "$0")

[[ -t 1 ]] && OUTPUT_IS_TERMINAL=true || OUTPUT_IS_TERMINAL=false

IS_LINUX=$([[ "$(uname -s)" == "Linux" ]] && echo true || echo false)

usage() {
  echo "Usage: $(basename "$0") [-q]"
  echo
  echo "Options:"
  echo "  -q  Quiet mode. Don't show the diff."
}

config_diff() {
  local config_file=$1
  local dso_url=$2

  local configs_dir="$SCRIPTS_DIR/../configs"

  echo "$config_file -> $dso_url"

  diff_errors=()

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

  local dso_data; dso_data=$(echo "$dso_response" | jq -s '.[0]')
  local header_json; header_json=$(echo "$dso_response" | jq -s '.[1]')
  local last_modified; last_modified=$(echo "$header_json" | jq -r '."last-modified" // empty | .[]')

  if [[ -n $last_modified ]]; then
    local last_modified_seconds modified_seconds_ago

    "$IS_LINUX" &&
      last_modified_seconds=$(date -d "$last_modified" +%s) ||
      last_modified_seconds=$(LC_ALL=C date -j -f "%a, %d %b %Y %T %Z" "$last_modified" +%s)

    modified_seconds_ago=$(( $(date +%s) - last_modified_seconds ))
  fi

  local weights_from_file; weights_from_file=$(
    yq -eo json . "$configs_dir/$config_file" | jq -eS '[.approvedSvIdentities[] | {(.name): .rewardWeightBps}] | add'
  ) || { echo "ERROR: Unable to read and parse weights from $config_file" >&2; return 1; }

  local weights_from_url; weights_from_url=$(
    echo "$dso_data" | jq -eS '[.dso_rules.contract.payload.svs[][1] | {(.name): .svRewardWeight | tonumber}] | add'
  ) || { echo "ERROR: Unable to parse weights from $dso_url" >&2; return 1; }

  local diff_options=()
  [[ $OUTPUT_IS_TERMINAL == true ]] && diff_options+=("--color=always")
  [[ ${QUIET-} == true ]] && diff_options+=("--brief")

  local dso_url_label="$dso_url"

  [[ -n ${modified_seconds_ago-} ]] &&
    dso_url_label+=" (last modified $modified_seconds_ago seconds ago)"

  local diff_result return_code
  diff_result=$(diff -su "${diff_options[@]}" --label "$config_file" --label "$dso_url_label" <(echo "$weights_from_file") <(echo "$weights_from_url")) && return_code=$? || return_code=$?
  echo "$diff_result"

  return "$return_code"
}

compare() {
  local envs_and_dso_urls=("${ENVS_AND_DSO_URLS[@]}")
  local return_code=0

  for ((i = 0; i < ${#envs_and_dso_urls[@]}; i += 2)); do
    local env=${envs_and_dso_urls[i]}
    local dso_url=${envs_and_dso_urls[i + 1]}

    local exit_code
    config_diff "$env/approved-sv-id-values.yaml" "$dso_url" && exit_code=$? || exit_code=$?
    return_code=$((return_code | exit_code))
    echo
  done

  return "$return_code"
}

main() {
  case ${1-} in
    -q)
      QUIET=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    "")
      ;;
    *)
      echo "Unknown option: $1"
      echo
      usage
      exit 1
      ;;
  esac

  for cmd in jq yq curl; do
    command -v "$cmd" >/dev/null || { echo "ERROR: $cmd is required. Please install it" >&2; exit 1; }
  done

  local result exit_code
  result=$(compare) && exit_code=$? || exit_code=$?
  echo
  echo "$result" | less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS
  exit "$exit_code"
}

main "$@"
