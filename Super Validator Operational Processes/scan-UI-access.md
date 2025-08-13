## Scan UI Access via Read-Only IPs and VPNs

### Purpose

This process outlines how Super Validator (SV) operators handle requests for granting read-only access to Scan UIs via organization VPNs or specific IPs, ensuring both accessibility and security.

### Status

This is a draft process reflecting recent discussions and an upcoming decision on permanent policy.

### Process

#### 1. Request Submission

- Requests to whitelist **VPNs** or **read-only IP addresses** for Scan UI access must:
  - Identify the requesting organization.
  - Specify whether access is via a VPN or a static IP.
  - Confirm that the VPN or IP is **read-only** and cannot perform any write or administrative actions.

#### 2. Review and Approval

- Operators will discuss the request during an SV Ops meeting or through the agreed asynchronous vote process.
- Considerations include:
  - The requester’s legitimate need to view Scan UI without tunneling through their cluster.
  - Whether existing tools, such as the **Proof Group’s block explorer** ([https://cantonscan.com](https://cantonscan.com)), already meet the requester’s needs.

#### 3. Voting

- A vote will determine whether to:
  - Continue adding organization VPNs for read-only Scan UI access.
  - Rely instead on existing public tools for read-only access.

#### 4. Implementation

- If approved:
  - The requesting organization’s VPN or IP will be added to the whitelist for the relevant Scan UI.
  - The whitelist record will include:
    - Organization name
    - VPN/IP details
    - Date added
    - Responsible SV sponsor (if applicable)

#### 5. Ongoing Policy

- Policy will be revisited as needed to ensure:
  - Security of network Scan UI endpoints.
  - Alignment with available public-facing tools.
  - Avoidance of unnecessary whitelisting when alternatives are available.

### Notes

- **Proof Group’s block explorer** ([https://cantonscan.com](https://cantonscan.com)) is intended to fulfill most basic Scan UI viewing requirements.
- This policy may become permanent as early as the day following approval.
- The intent is to minimize operational complexity while preserving needed transparency.