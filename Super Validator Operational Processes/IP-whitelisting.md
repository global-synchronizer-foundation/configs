## IP Whitelisting for Validators

### Purpose

This process defines the requirements and steps for whitelisting IP addresses for validator nodes and clusters in the Canton Network.

### Status

This is a draft process based on current working practices and prior agreements among SV operators.

### Process

#### 1. Sponsor Involvement

- The **SV sponsor** or **Node as a Service provider** must be included in all IP whitelisting requests.
- The **SV sponsor** or *Node as a Service provider** must also be included in the IP whitelisting record.
- The **SV sponsor** should normally be the **onboarding SV**, but exceptions are allowed if another SV is willing to take responsibility for the whitelisted node/cluster.

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