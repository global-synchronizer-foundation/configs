## How to Create a Vote Proposal Process

### Purpose

This process defines how an SV operator may create and submit a vote proposal for consideration by other SV operators.

### Status

This is a draft process based on current working practices and discussions in prior meetings. No fully formal process yet exists.

### Process

#### 1. Draft your proposal

- For new CIPs:
  - Draft a CIP per CIP guidelines.
  - Submit as PR to [CIP repo](https://github.com/global-synchronizer-foundation/cips).

- For operational votes not requiring a CIP (e.g. weights, featured app markers):
  - Prepare a clear proposal text in Slack or Google Docs, including:
    - Exact action to be taken
    - Networks impacted (DevNet, TestNet, MainNet)
    - Proposed timing / effectivity
    - Link to supporting materials (if any)

#### 2. Announce your intent to vote

- Announce intent to create a vote in `#global-synchronizer-ops`.
- Allow time (usually 1-2 days) for discussion and any objections.

#### 3. Initiate on-ledger vote

- Use the voting tools to create the on-ledger vote.
- Include a clear and consistent vote description.
- Announce in `#global-synchronizer-ops` when the vote goes live.

#### 4. Coordinate follow-up actions

- For CIPs or operational votes requiring a GitHub PR (weights, IPs, etc), prepare corresponding PR after vote passes.
- Communicate status of post-vote actions in `#global-synchronizer-ops`.

### Notes

- Effective-at-threshold votes should only be used in emergencies.
- Standard proposal expiration is 5 business days, with effectivity at least 1 day after expiration.
- GSF and SV operators should continue documenting best practices around vote types.
