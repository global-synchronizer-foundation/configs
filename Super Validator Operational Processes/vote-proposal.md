## How to Create a Vote Proposal Process

### Purpose

This process defines how an SV operator may create and submit a vote proposal for consideration by other SV operators.

### Status

This is a draft process based on current working practices and discussions in prior meetings. No fully formal process yet exists.

### Process

#### 1. Draft your proposal

- All Vote proposals should follow the [CIP guidelines](https://github.com/global-synchronizer-foundation/cips/blob/main/cip-0000/cip-0000.md) first.

- For operational votes that rely on an existing CIP, or a decision by the Tokenomics committee (e.g. weight updates, featured app status):
  - Prepare a clear proposal text (Slack or Google Doc is fine), including:
    - The exact action to be taken
    - Networks impacted (DevNet, TestNet, MainNet)
    - Proposed timing and effectivity
    - Links to any supporting materials or references

#### 2. Initiate on-ledger vote

- Use the SV UI or corresponding SV app API to create the on-ledger vote.
- Include a clear and consistent vote description matching the proposal.
- Immediately upon opening the vote, send a notification email to:
  - `supervalidator-announce@lists.sync.global`

  This email must include:
  - A summary of the proposal
  - The contract ID to the on-ledger vote
  - Any relevant context or supporting links
- [Optional] Announce the vote in `#supervalidator-ops` on Slack.

#### 3. Coordinate follow-up actions

- For CIPs or operational votes requiring a GitHub PR (e.g., weights, IPs):
  - Prepare the corresponding PR(s) once the vote passes.
  - Announce PR status and request review/merge in `#supervalidator-ops`.

### Notes

- Only one email announcement is required per vote. It should be sent to `supervalidator-announce@lists.sync.global` when the vote goes live.
- Effective-at-threshold votes should only be used in emergencies.
- Standard proposal expiration is 7 days, with effectivity at least 1 day after expiration.
- GSF and SV operators should continue to document and improve best practices for different vote types.
