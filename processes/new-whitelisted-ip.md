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


## How to Request Read-Only Access for Your IP Address

### Purpose

This process allows an IP address to reach the **scan endpoint** of the **SV** (Synchronizer-Validator). It will not be able to access other components such as the **sequencer** or **CometBFT**. The primary purpose is to serve read-only applications such as **chain analytics** or **explorers**.

### Process

Similar to the "`How to Ask for a New Whitelisted IP Process`" section above, you will need to submit a **PR** (Pull Request) to the same repository and file.

For each network, locate the `read-only clients` section in the `config/<(DevNet|Testnet|Mainnet)>/allowed-ip-ranges.json` file and add a new element in this format:

```
"<org-name> / <operator-name-or-sponsor-name>" : [
  "ip1/32",
  "ip2/32"
]
```

When the organization runs the node themselves, list the sponsor in the second part after the hyphen (-).

The key needs to be sorted. You can perform a sort with a one-line script:

```
jq '."read-only clients" |= (to_entries | sort_by(.key | ascii_downcase) | from_entries)' configs/<(DevNet|Testnet|Mainnet)>/allowed-ip-ranges.json > tmp.json && mv tmp.json configs/MainNet/allowed-ip-ranges.json
```

Alternatively, you can use the script [new-whitelist.sh](https://github.com/global-synchronizer-foundation/configs-private/blob/main/scripts/new-whitelist.sh), which automates most of the steps above, including PR creation.

Currently, only individual IPs are allowed, so you will need to explicitly write out multiple `/32` entries if you have a range. There isn't an official limit on how many IPs are allowed, but keep it fewer than three.

Unlike validator IPs, read-only access IP addresses can be reused across all network environments (**Dev**, **Test**, and **Main**).

When submitting the PR, briefly provide information about:

* The application and the organization

* The access pattern your app will generate

* Your plan to ensure a reasonable request rate to the scan application, especially spreading the load across SV scans to avoid overloading an individual scan. Overloading may result in your IP being rate-limited and blocked by certain SVs.
