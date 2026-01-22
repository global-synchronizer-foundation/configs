## How to Ask for a New Whitelisted IP Process

### Purpose

This process defines how to request the addition of a new IP address to the `<network>/allowed-ip-ranges.json` in file  [configs-private](https://github.com/global-synchronizer-foundation/configs-private), which is used to whitelist IPs for access to Canton network nodes, tools, or monitoring interfaces.

### Status

This is a proposed process based on working patterns as no formal process has been documented yet.

### Process

### 1. Sponsorship and Accountability

#### 1a. Sponsor Involvement for Self-Hosted Validators

- For validators operating their **own infrastructure**, an **SV sponsor is required** for all IP whitelisting requests.
- The SV sponsor should normally be the **onboarding SV**, but another SV may act as sponsor if they explicitly agree to take responsibility.
- The SV sponsor must be **explicitly recorded** in the IP whitelisting entry.
- The SV sponsor is accountable for the validator node or cluster they sponsor.

#### 1b. Operator Involvement for Node-as-a-Service Operated Nodes

- For validators operated by a **Node as a Service (NaaS) provider**, the **NaaS provider is the responsible operator** for the validator node or cluster.
- The **Node as a Service provider must be explicitly recorded** in all IP whitelisting requests and in the whitelisting record.
- The NaaS provider is accountable for day-to-day infrastructure operation, security posture, and compliance with network-level requirements.
- Any exceptions to this structure must be **explicitly documented** in the IP whitelisting record or PR description.

#### 2. IP Address Allocation Rules

- As a general rule, **one IP address should be whitelisted per validator node or cluster**.
- Exceptions (for example, large institutions, exchanges, or temporary node migrations) may be considered on a case-by-case basis and must be clearly explained in the PR description.
- Validator nodes and clusters **must use different IP addresses for different networks** (for example, DevNet, TestNet, and MainNet).
- Operators must ensure that validator infrastructure uses a single egress gateway so that outbound traffic originates from the approved IP.

#### 3. Prepare the Change and Submit a Pull Request

Submit a pull request (PR) to the GitHub repository: [global-synchronizer-foundation/configs-private](https://github.com/global-synchronizer-foundation/configs-private). If you are not a maintainer, create it via a GitHub fork.

When preparing the PR, consider the following:
  - Make changes in the file `configs/<network>/allowed-ip-ranges.json` where `<network>` is the network you wish to add the IP for (DevNet, TestNet or MainNet)
  - Identify the correct section for the IP entry:
    - `svs`
    - `validators`
    - `vpns`
    - `read-only clients`
- Entries under `validators` or `read-only clients` must include (Separate the two using `" / "`):
  - The name of the validator or organization requesting access, and
  - The name of the operator running the node on their behalf   
- If the validator operates its own node, include the **SV sponsor** instead.
- As a general rule, only one IP should be whitelisted per validator. Make sure that validators nodes use a single egress gateway so that they have a single egress IP. If more than one IP is required per validator, e.g. to temporarily run a second node while migrating between nodes, please explain that in the PR description.

- Ensure that:
  - All entries are **sorted alphabetically**, and IP addresses for each entry are **sorted numerically**.  
  - CI checks will fail if sorting requirements are not met

#### 5. Additional Requirements for TestNet and MainNet

If adding an IP for a validator on **TestNet** or **MainNet**, the PR description must include **one of the following**:

- A link to an announcement confirming that the validator has been approved by the Tokenomics Committee, or
- A link naming the approved operator (from the list of operators authorized by the Tech and Ops Committee) under whose discretion the validator is being onboarded.

#### 6. Get the PR reviewed and merged

- The PR must be reviewed and approved by a maintainer from a **different organization** than the submitter.
- If the submitter is a maintainer, the PR may be merged only after approval from another maintainer from a different organization.

#### 7. Tooling

- The script [new-whitelist.sh](https://github.com/global-synchronizer-foundation/configs-private/blob/main/scripts/new-whitelist.sh) may be used to automate most of the steps above, including PR creation.
- Use of the script does not remove the requirement for proper documentation, justification, and review.

### Notes

- Sponsors remain responsible for the nodes and clusters they sponsor after whitelisting.
- Exceptions to IP allocation or sponsorship rules must be explicitly documented.
- Operators must ensure IP allocations comply with all network-level requirements before deployment.
- SV operators are encouraged to document and share evolving best practices during PR review.
