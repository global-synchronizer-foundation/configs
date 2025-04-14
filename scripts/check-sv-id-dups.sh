#!/usr/bin/env bash

# check-sv-id-dups.sh
# This script checks approved-sv-id-values.yaml files for duplicate SV IDs

set -euo pipefail

SCRIPTS_DIR=$(dirname "$0")

sv_ids_exclude=(${SV_IDS_EXCLUDE:-})

sv_ids_exclude_json=$(
  printf '%s\n' "${sv_ids_exclude[@]}" |
  jq -nR '[inputs]'
)

approved_sv_ids_files=(
  "$SCRIPTS_DIR"/../configs/*/approved-sv-id-values.yaml
)

approved_sv_ids=$(for f in "${approved_sv_ids_files[@]}"; do cat "$f" | yq -o json; done)

jq_functions='
  # input: array
  # output: arrays with unique elements
  def select_dups:
    group_by(.) | map(select(length>1) | .[0])
  ;
'

sv_id_dups=$(
  echo "$approved_sv_ids" |
  jq -nr --argjson sv_ids_exclude "$sv_ids_exclude_json" "$jq_functions"'
    [inputs]
    | map(.approvedSvIdentities[].publicKey)
    | . - $sv_ids_exclude
    | select_dups[] | "- " + .
  '
)

exit_code=0

if [[ -n "$sv_id_dups" ]]; then
  echo "ERROR: The following duplicate SV IDs were found:"
  echo "$sv_id_dups"
  exit_code=1
fi

if [[ $exit_code -ne 0 ]]; then
  exit "$exit_code"
else
  echo "INFO: No duplicate SV IDs found."
fi
