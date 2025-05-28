#!/usr/bin/env bash

# get-missing-voters.sh

set -euo pipefail

CURL_TIMEOUT=15
CURL_CMD=(curl -fsS -m "$CURL_TIMEOUT")

ENVS_AND_URLS=(
  DevNet  https://docs.dev.global.canton.network.sync.global/{dso,voterequests}
  TestNet https://docs.test.global.canton.network.sync.global/{dso,voterequests}
  MainNet https://docs.global.canton.network.sync.global/{dso,voterequests}
)

usage() {
  echo "Usage: $(basename "$0") [DAYS_BEFORE_EXPIRY]"
  echo "Fetches vote requests and checks for missing voters."
  echo
  echo "Optional arguments:"
  echo "  DAYS_BEFORE_EXPIRY    Filter vote requests that are expiring within this number of days."
  echo
  echo "Example: $(basename "$0") 2.5"
}

jq_functions='
  def intersection:
    reduce .[1:][] as $x (.[0]; . - (. - $x))
  ;
'

get_missing_voters() {
  local days_before_expiry="${1-}"

  local envs_and_urls=("${ENVS_AND_URLS[@]}")
  local missing_voters='[]'

  for ((i = 0; i < ${#envs_and_urls[@]}; i += 3)); do
    local env=${envs_and_urls[i]}
    local dso_url=${envs_and_urls[i + 1]}
    local voterequests_url=${envs_and_urls[i + 2]}

    echo "INFO: Fetching DSO and Vote Requests for $env..." >&2
    local dso; dso=$("${CURL_CMD[@]}" "$dso_url")
    local voterequests; voterequests=$("${CURL_CMD[@]}" "$voterequests_url")

    # jq -r "$jq_functions"'.dso_rules_vote_requests[] |= select(.payload.voteBefore == "2025-05-31T11:00:03.735397Z")'
    # note that voteBefore can be null, so we need to handle that case
    local voterequests_expiring; voterequests_expiring=$(
      if [[ -n $days_before_expiry ]]; then
        echo "$voterequests" |
        jq -e --arg days_before_expiry "$days_before_expiry" '
          .dso_rules_vote_requests[] |=
          select(
            (.payload.voteBefore == null) or
            (.payload.voteBefore | .[0:19] + "Z" | fromdate < (now + ($days_before_expiry | tonumber * 86400)))
          )
        '
      else
        echo "$voterequests"
      fi
    )

    local svs_from_dso; svs_from_dso=$(
      echo "$dso" |
      jq -e '.dso_rules.contract.payload.svs | map(.[1].name)'
    )

    local voterequests_expiring_is_not_empty; voterequests_expiring_is_not_empty=$(
      echo "$voterequests_expiring" | jq -er '.dso_rules_vote_requests | length > 0 | tostring'
    )

    local svs_voted_on_all_requests; svs_voted_on_all_requests=$(
      echo "$voterequests_expiring" |
      jq -e "$jq_functions"'[.dso_rules_vote_requests[].payload.votes | map(.[0])] | intersection'
    )

    local svs_missing; svs_missing=$(
      if [[ $voterequests_expiring_is_not_empty == true ]]; then
        echo "$svs_from_dso" "$svs_voted_on_all_requests" |
        jq -es '.[0] - .[1]'
      else
        echo "[]"
      fi
    )

    local svs_missing_count; svs_missing_count=$(
      echo "$svs_missing" |
      jq -er '. | length'
    )

    if [[ $svs_missing_count -gt 0 ]]; then
      missing_voters=$(
        echo "$missing_voters" |
        jq --arg env "$env" --argjson svs_missing "$svs_missing" '
          . + ["- " + $env + ": " + ($svs_missing | join(", "))]
        '
      )
    fi
  done

  echo "$missing_voters"
}

main() {
  local days_before_expiry=""

  case ${1-} in
    -h|--help)
      usage
      exit 0
      ;;
    "")
      ;;
    *)
      days_before_expiry="$1"
      ;;
  esac

  local missing_voters; missing_voters=$(get_missing_voters "$days_before_expiry")
  local missing_voters_found; missing_voters_found=$(echo "$missing_voters" | jq -er 'length > 0 | tostring')

  if [[ $missing_voters_found == true ]]; then
    echo "There are vote requests requiring attention, votes are needed from:"
    echo "$missing_voters" | jq -r '.[]'
    exit 1
  else
    echo "INFO: No missing voters found."
  fi
}

main "$@"
