## How to Ask for a New Whitelisted IP Process

### Purpose

This process defines how to request the addition of a new IP address to the `<network>/allowed-ip-ranges.json` in file  [configs-private](https://github.com/global-synchronizer-foundation/configs-private), which is used to whitelist IPs for access to Canton network nodes, tools, or monitoring interfaces.

### Status

This is a proposed process based on working patterns used for similar PRs (weights, Scan UI access), as no formal process has been documented yet.

### Process (proposed based on current practice)

#### 1. Prepare your IP request

When requesting a new whitelisted IP, prepare the following:

- Exact IP address to be whitelisted
- Purpose of the IP (e.g. node operation, Validator operation, monitoring, Scan UI access)
- Which network(s) this applies to (DevNet, TestNet, MainNet)
- Sponsoring SV name (if applicable)

#### 2. Submit the request

- Submit a pull request (PR) to the GitHub repo:
  - Repo: [global-synchronizer-foundation/configs](https://github.com/global-synchronizer-foundation/configs)
  - File: `allowed-ip-ranges-external.json`

- Announce the PR in the `#global-synchronizer-ops` Slack channel to request review.

#### 3. Review and merge

- It is recommended that two reviewers approve PRs affecting IP whitelisting.
- After approval, a maintainer merges the PR.

#### 4. Notes

- This  process reflects practices used for other network configurations (weights, Scan UI VPN access) but has not yet been formally voted and adopted.
- SV operators are encouraged to document their current practices during review of this draft.
