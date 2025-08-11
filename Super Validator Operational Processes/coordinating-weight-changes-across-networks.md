## Coordinating Weight Changes Across Networks


### Purpose

 - To ensure runtime consistency between onchain Super Validator (SV) weights and the configuration published in `approved-sv-id-values.yaml`. This prevents discrepancies that could cause operational issues and ensures the file remains the authoritative public reference for SV owners, re-onboarding processes, and monitoring.


### Background
- The SV network relies on the consistency between onchain weights and the GitHub configuration file.

- The configuration file at https://sync.global is used:
  - By SV owners to verify weight allocations are correct.
  - During SV re-onboarding (nodes receive the weight defined in the file).

- Agreement from Operations Call: Adopt Option 3a for synchronization:
  - Keep a single PR if all votes have the same effective date.
  - The node that proposes the weight change is responsible for updating the file.

### Scope
- This process applies to:
  - All SV operators who submit onchain votes to change weights.
  - All networks: MainNet, TestNet, DevNet.

### Process

#### 1. Initiate Onchain Vote

- Propose and pass the weight change vote for the relevant network.
- Ensure the vote is recorded in the governance log.

#### 2. Update GitHub Configuration

- Responsible Party: The SV node that proposed the onchain weight change.
- File to Update: approved-sv-id-values.yaml in configs repo.
- Required Changes: Update the weight values for the relevant SV IDs to match the onchain result.
- Commit Message Format:`chore(weights): sync with onchain vote [vote ID or link]1

- Pull Request Requirements:
- Target main branch.
- Link to governance vote in the PR description.
- Request review from repo maintainers.

-   Title format: `Sync SV weights – [Network] – [Effective Date] `

#### 3. Review & Merge

- Reviewers verify:
  - Onchain weights match the YAML changes.
  - Correct network and effective date are noted.
- Upon approval, merge the PR before the effective date of the vote.


#### 4. Confirmation & Publication

- Once merged, confirm that the update is live at https://sync.global/sv-network/.

#### 5. Compliance & Escalation

- If the proposer fails to submit the PR within 48 hours of vote passing, Operations will:

  - Issue a reminder in the #supervalidator-operations Slack channel.
  - If no action within the next 48 hours, escalate to the Governance Committee.

- Persistent failure may trigger:
  - Reconsideration of process (including fallback to Option 2).
  - Potential offboarding vote against the non-compliant SV.

#### 6. Special Notes
- During re-onboarding, the SV node will receive the weight in the file, regardless of prior allocation.
- All weight changes must be network-consistent; discrepancies may cause minting or reward distribution errors.
- The GitHub PR must be merged before the change is operationally relied upon.
