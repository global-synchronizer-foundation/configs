#!/usr/bin/env bash

# check-sum-reward-weights-change.sh
# This script checks if the total sum of reward weights for all approved SV identities has changed

set -euo pipefail

SCRIPTS_DIR=$(dirname "$0")

usage() {
  echo "Usage: $0 base_commit new_commit"
  echo
  echo "Example: $0 main pr_branch"
}

check() {
  local base_commit=$1
  local new_commit=$2

  mark='[allow-total-reward-weight-change]'
  commit_message=$(git show -s --format="%B" "$new_commit")
  allow_total_reward_weight_change=$(echo "$commit_message" | grep -qF "$mark" && echo "true" || echo "false")
  exit_code=0

  for f in configs/*/approved-sv-id-values.yaml; do
    content_orig=$(git show "$base_commit:$f")
    content_new=$(git show "$new_commit:$f")

    total_weight_orig=$(echo "$content_orig" | yq '.approvedSvIdentities[].rewardWeightBps as $n ireduce(0; . + $n)')
    total_weight_new=$(echo "$content_new" | yq '.approvedSvIdentities[].rewardWeightBps as $n ireduce(0; . + $n)')

    total_weight_diff=$((total_weight_new - total_weight_orig))

    echo "INFO: Current total reward weight for $f is: $total_weight_orig."

    if [[ "$total_weight_diff" == "0" ]]; then
      echo "INFO: Total reward weight diff for $f is: $total_weight_diff."
    elif  [[ "$allow_total_reward_weight_change" == "true" ]]; then
      echo "INFO: Total reward weight diff for $f is: $total_weight_diff. The change is allowed."
      echo "INFO: New total reward weight for $f is: $total_weight_new."
    else
      echo "ERROR: Total reward weight diff for $f is: $total_weight_diff. The change is not allowed. Add $mark to the commit message to override." >&2
      exit_code=1
    fi

    echo
  done

  exit "$exit_code"
}

main() {
  [[ "$#" -eq 2 ]] || { usage; exit 1; }

  check "$1" "$2"
}

main "$@"
