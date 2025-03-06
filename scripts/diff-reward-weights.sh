#!/usr/bin/env bash

# diff-reward-weights.sh
#
# Compare the reward weights in the approved-sv-id-values.yaml file with the weights from the DSO API

set -euo pipefail

CURL_TIMEOUT=5
CURL_CMD=(curl -fsS -m "$CURL_TIMEOUT")

ENVS_AND_SCAN_URLS=(
  DevNet  https://scan.sv-1.dev.global.canton.network.sync.global
  TestNet https://scan.sv-1.test.global.canton.network.sync.global
  MainNet https://scan.sv-1.global.canton.network.sync.global
)

SCRIPTS_DIR=$(dirname "$0")

[[ -t 1 ]] && OUTPUT_IS_TERMINAL=true || OUTPUT_IS_TERMINAL=false

usage() {
  echo "Usage: $(basename "$0") [-q]"
  echo
  echo "Options:"
  echo "  -q  Quiet mode. Don't show the diff."
}

config_diff() {
  local config_file=$1
  local scan_url=$2

  local configs_dir="$SCRIPTS_DIR/../configs"
  local dso_url="$scan_url/api/scan/v0/dso"

  echo "$config_file -> $dso_url"

  diff_errors=()

  local dso_data; dso_data=$(
    "${CURL_CMD[@]}" "$dso_url"
  ) || diff_errors+=("ERROR: Unable to fetch DSO from $dso_url")

  local weights_from_file; weights_from_file=$(
    yq -eo json . "$configs_dir/$config_file" | jq -eS '[.approvedSvIdentities[] | {(.name): .rewardWeightBps}] | add'
  ) || diff_errors+=("ERROR: Unable to read and parse weights from $config_file")

  local weights_from_url; weights_from_url=$(
    "${CURL_CMD[@]}" "$dso_url" | jq -eS '[.dso_rules.contract.payload.svs[][1] | {(.name): .svRewardWeight | tonumber}] | add'
  ) || diff_errors+=("ERROR: Unable to fetch and parse weights from $dso_url")

  if [[ ${#diff_errors[@]} -eq 0 ]]; then
    local diff_options=()

    if [[ $OUTPUT_IS_TERMINAL == true ]]; then
      diff_options+=("--color=always")
    fi

    if [[ ${QUIET-} == true ]]; then
      diff_options+=("--brief")
    fi

    local return_code
    diff_result=$(diff -su "${diff_options[@]}" --label "$config_file" --label "$dso_url" <(echo "$weights_from_file") <(echo "$weights_from_url")) && return_code=$? || return_code=$?
    echo "$diff_result"

    return "$return_code"
  else
    for error in "${diff_errors[@]}"; do
      echo "$error" >&2
    done

    return 1
  fi
}

compare() {
  local envs_and_scan_urls=("${ENVS_AND_SCAN_URLS[@]}")
  local return_code=0

  for ((i = 0; i < ${#envs_and_scan_urls[@]}; i += 2)); do
    local env=${envs_and_scan_urls[i]}
    local scan_url=${envs_and_scan_urls[i + 1]}

    local exit_code
    config_diff "$env/approved-sv-id-values.yaml" "$scan_url" && exit_code=$? || exit_code=$?
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

  local result exit_code
  result=$(compare) && exit_code=$? || exit_code=$?
  echo "$result" | less --quit-if-one-screen --no-init --RAW-CONTROL-CHARS
  exit "$exit_code"
}

main "$@"
