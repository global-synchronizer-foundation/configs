## TestNet Reset Schedule

### Purpose

This process defines the schedule and procedure for performing TestNet resets to ensure a consistent and predictable environment for testing and development.

### Status

This is a draft process based on the decision made on **June 24, 2025** to reset the TestNet every six months.

### Process

#### 1. Reset Frequency

- **Every 6 months** from the last reset date.

#### 2. Pre-Reset Preparation

- At least **two weeks before the scheduled reset**:
  - Announce the planned reset in `#supervalidator-operations`, `validator-operations`, and `validator-operations-onboarding` on Slack.
  - Send an email to `supervalidator-announce@lists.sync.global` and `validator-announce@lists.sync.global` with:
    - The planned reset date and time (in UTC)
    - Expected downtime, if any
    - Instructions for operators to back up any relevant data
  - Confirm with all SV operators that they are prepared for the reset.

#### 3. Execution

- Perform the reset according to agreed technical procedures, ensuring:
  - All nodes are stopped prior to reset
  - Any necessary snapshots or backups are taken
  - The network is restarted cleanly with updated configurations, if applicable
  - On TestNet, ensure that the network restarts at a round number as close as possible to the current MainNet minting round. 

#### 4. Post-Reset Actions

- Confirm all nodes are back online and in sync.
- Announce completion in `#supervalidator-ops` and via `supervalidator-announce@lists.sync.global`.
- Document any changes in configuration or topology resulting from the reset.

### Notes

- TestNet resets are intended to maintain a clean and consistent environment for development and testing purposes.
- Any deviation from the standard six-month schedule requires consensus among SV operators.
- Operators are responsible for ensuring any test data or configurations they wish to preserve are backed up before the reset.