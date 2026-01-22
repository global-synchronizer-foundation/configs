## IP Whitelisting for Validators

### Purpose

This process defines the requirements and steps for whitelisting IP addresses for validator nodes and clusters in the Canton Network.

### Status

This is a draft process based on current working practices and prior agreements among SV operators.

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

- **One IP per cluster** is allowed. Exceptions will be considered on a case-by-case basis for large institutions and exchanges. 
- Validator nodes and clusters **must use different IP addresses** for different networks (e.g., MainNet, DevNet, TestNet).

#### 3. GitHub Whitelisting Files

- Maintain **separate IP whitelisting files** in GitHub for each network.
- All changes must follow the standard PR review process and include confirmation from the SV sponsor.

#### 4. Request and Approval Flow

- Submit IP whitelisting requests via the agreed GitHub workflow.
- Include:
  - Node or cluster identifier
  - Network name
  - Assigned IP address
  - SV sponsor or Node as a Service provider information

### Notes

- Sponsors are accountable for the nodes/clusters they whitelist.
- Exceptions to sponsorship rules must be explicitly documented in the IP whitelisting record.
- Operators must ensure IP allocations comply with all network-level requirements before deployment.
