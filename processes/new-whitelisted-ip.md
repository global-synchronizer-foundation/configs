## How to Ask for a New Whitelisted IP Process

### Purpose

This process defines how to request the addition of a new IP address to the `<network>/allowed-ip-ranges.json` in file  [configs-private](https://github.com/global-synchronizer-foundation/configs-private), which is used to whitelist IPs for access to Canton network nodes, tools, or monitoring interfaces.

### Status

This is a proposed process based on working patterns as no formal process has been documented yet.

### Process

#### 1. Prepare the Change and Submit a Pull Request

Submit a pull request (PR) to the GitHub repository: [global-synchronizer-foundation/configs-private](https://github.com/global-synchronizer-foundation/configs-private). If you are not a maintainer, create it via a GitHub fork.

When preparing the PR, consider the following:
  - Make changes in the file `configs/<network>/allowed-ip-ranges.json` where `<network>` is the network you wish to add the IP for (DevNet, TestNet or MainNet)
  - Identify the section where the IP should be added: `svs`, `validators`, `vpns` or `read-only clients`
  - Entries under `validators` or `read-only clients` must contain both the name of the validator (or organization requesting read-only access) and the name of the operator running the node on their behalf. If they operate their own node, include the sponsor SV instead. Separate the two with " / ".
  - Ensure that all entries and IP addresses are sorted alphabetically. The CI will fail your PR if they are not.
  - As a general rule, only one IP should be whitelisted per validator. Make sure that validators nodes use a single egress gateway so that they have a single egress IP. If more than one IP is required per validator, e.g. to temporarily run a second node while migrating between nodes, please explain that in the PR description.

If adding IP for a validator on **TestNet** or **MainNet**, the PR description must contain:
  - **Justification**: Provide a link to an announcement confirming that the validator has been approved by the tokenomics committee or a statement naming the operator (from the list of operators approved by the tokenomics committee to onboard validators at their discretion) under whose discretion the validator is added.

You can use the script [new-whitelist.sh](https://github.com/global-synchronizer-foundation/configs-private/blob/main/scripts/new-whitelist.sh), which automates most of the steps above, including PR creation.

#### 2. Get the PR reviewed and merged

- A maintainer from a different organization than the submitted should approve and merge the PR. If the submitter is a maintainer, they can merge the PR after receiving approval from another maintainer from a different organization.

#### 3. Notes

- SV operators are encouraged to document their current practices during review of this draft.
