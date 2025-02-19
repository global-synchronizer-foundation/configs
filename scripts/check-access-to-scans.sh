#!/usr/bin/env bash

set -euo pipefail

scan_url="https://scan.sv-2.global.canton.network.digitalasset.com" # DA SV-2 gets allow list applied daily

scans_info_url="$scan_url/api/scan/v0/scans"
dso_url="$scan_url/api/scan/v0/dso"

curl_timeout=5
curl_cmd=(curl -sS -m "$curl_timeout")

scan_info=$(
  echo "Getting data from $scans_info_url ..." >&2

  "${curl_cmd[@]}" "$scans_info_url"
)

dso=$(
  echo "Fetching current configuration from $dso_url ..." >&2

  "${curl_cmd[@]}" "$dso_url"
)


svs_all=$(echo "$dso" | jq '[.dso_rules.contract.payload.svs[][1].name]')
svs_count=$(jq <<< "$svs_all" length)
svs_from_scan=$(echo "$scan_info" | jq '[.scans[].scans[] | .svName]')
svs_missing=$(echo "$svs_all" "$svs_from_scan" | jq -s '.[0] - .[1]')

IFS=$'\n' read -r -d '' -a scan_svnames_and_urls < <(
  echo "$scan_info" |
    jq -r '[.scans[].scans[] | [.svName, .publicUrl + "/api/scan/version"]] | sort[] | join(" ")' && printf '\0'
)

echo

scan_data=$(
  for svname_and_url in "${scan_svnames_and_urls[@]}"; do
    read svname url <<< "$svname_and_url";

    echo "Trying to access $svname_and_url" >&2

    ("${curl_cmd[@]}" -f "$url" || echo '{"inaccessible": true}') |
      jq --arg svname "$svname" --arg url "$url" '
        .svname = $svname |
        .url = $url
      '
    echo
  done
)

echo

echo "$scan_data" |
  jq -sr '
    ["svName", "url", "version", "commit_ts"],
    (.[] | [.svname, .url, .version // -1, .commit_ts // -1])
    | @tsv
  ' | column -ts$'\t'

svs_inaccessible_count=$(jq -nr <<< "$scan_data" '[inputs | select(.inaccessible)] | length')

echo
echo "Registered: ${#scan_svnames_and_urls[@]} / Expected: $svs_count"
echo "Missing: $(jq -r <<< "$svs_missing" 'if length > 0 then join(", ") else "none" end')"
echo "Inaccessible: $svs_inaccessible_count of $svs_count"
