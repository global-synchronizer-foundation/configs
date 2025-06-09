## How to Change Weights of an SV Process

### Purpose

This process defines how to propose and implement changes to the minting weight of a Super Validator (SV) on the Global Synchronizer.  

### Status

This is a draft process based on current practice and the final operator vote adopting separate PRs per network (Option 2). It formalizes the process now in use.

### Process

#### 1. Propose a weight change via on-ledger vote

- Initiate on-ledger vote(s) for the intended weight changes on each network (DevNet, TestNet, MainNet as needed).
- Wait for the vote results to pass on-chain for each network individually.

#### 2. Prepare GitHub PRs

- Prepare **one pull request per network**:
  - Repo: [global-synchronizer-foundation/configs](https://github.com/global-synchronizer-foundation/configs)
  - File: `approved-sv-id-values.yaml` in the appropriate network branch or directory (per current repo structure).

- **No, we agreed on separate PRs. So if some votes did not pass, the corresponding PR should not be merged.**

#### 3. Submit vote request

- Submit a vote request for the proposed weight changes, clearly referencing the PR(s) in your vote request description.

#### 4. Post-vote: Merge PRs

- Once vote requests pass:
  - Announce in `#global-synchronizer-ops` that the vote passed and the corresponding PR(s) are ready to merge.
  - **Ask a maintainer to merge the corresponding PRs**.
  - Only PRs for networks where the vote passed should be merged.

#### 5. Post-merge checks

- Automated checks will compare on-ledger weights with GitHub after votes have passed.
- If a mismatch is detected after the vote:
  - The GitHub configuration **must be updated** to match the on-ledger state, OR
  - A new vote request must be initiated to correct the on-ledger state.
- There is no "voting down" after the vote has passed — the mismatch must be resolved.

### Notes

- This process was adopted as **Option 3a** by formal SV operator vote.
- The goal is to maintain consistent weights across networks and the GitHub config.
