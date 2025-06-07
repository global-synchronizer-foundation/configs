## How to Change Weights of an SV Process

### Purpose

This process defines how to propose and implement changes to the voting weight of a Super Validator (SV) on Canton networks.

### Status

This is a draft process based on approved Option 3a in prior votes and current working practice. It formalizes an implied process already in use.

### Process

#### 1. Propose a weight change via on-ledger vote

- Initiate an on-ledger vote to propose the new weight(s).
- Wait for vote results to pass on-chain.

#### 2. Prepare GitHub update

- After vote passes, the proposer is responsible for submitting a pull request (PR) to:
  - Repo: [global-synchronizer-foundation/configs](https://github.com/global-synchronizer-foundation/configs)
  - File: `approved-sv-id-values.yaml`

- The PR should match the voted weights exactly.
- PR title should reference the corresponding vote.

#### 3. Announce PR

- Announce the PR in `#global-synchronizer-ops` Slack channel to request review.

#### 4. Review and merge

- Two reviewers (from different SV operators) must approve.
- The PR should remain open until the effective date of the vote.
- If some weights did not pass, they must be removed from the PR prior to merge.

#### 5. Post-merge checks

- Automated checks will compare on-ledger weights with GitHub.
- If a mismatch is detected and no corresponding PR exists, the weight change may be voted down.

### Notes

- This process was adopted as **Option 3a** by formal SV operator vote.
- The goal is to maintain consistent weights across networks and the GitHub config.
