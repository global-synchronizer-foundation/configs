## How to Change Weights of an SV Process

### Purpose

This process defines how to propose and implement changes to the minting weight of a Super Validator (SV) on the Global Synchronizer.

### Status

This is a draft process based on current practice and the final operator vote adopting separate PRs per network (Option 2). It formalizes the process now in use.

### Process

#### 1. Prepare GitHub PRs

- Prepare **one pull request per network**:
  - Repo: [global-synchronizer-foundation/configs](https://github.com/global-synchronizer-foundation/configs)
  - File: `approved-sv-id-values.yaml` in the appropriate folder per network.

- Each PR must contain only the weight changes for that specific network.
- If no weight change is proposed for a network, no PR is needed for that network.

#### 2. Submit vote request

- Submit a vote request in each network that includes:
  - A link to each prepared PR
  - A clear description of the proposed changes, and the reasoning for them
  - The intended effective date


#### 3. After vote passes and becomes effective

- For each network where the vote passed:
  - Announce in `#global-synchronizer-ops` that the vote has passed and the corresponding PR is ready.
  - **Ask a maintainer to merge the PR** for that network.


#### 4. Post-merge checks

- Automated tools will compare GitHub configuration with the on-ledger state after vote execution.
- If a mismatch is detected:
  - The GitHub config **must be updated** to match the ledger, OR
  - A new vote request must be initiated to correct the ledger.
- There is no "voting down" after a vote passes — discrepancies must be resolved through correction.

### Notes

- This process was adopted as **Option 3a** by formal SV operator vote.
- The goal is to maintain consistent weights across networks and the GitHub config.
