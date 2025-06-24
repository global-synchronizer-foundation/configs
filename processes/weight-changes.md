## Coordinating Weight Changes Across Networks

### Purpose

This process ensures that on-chain Super Validator weight votes remain in sync with our public GitHub configuration (`approved-sv-id-values.yaml`), and that any SV re-onboarding uses the correct, network-approved weights.

### Process

#### 1. Initiate on-chain vote  
- Propose weight changes via on-chain governance under “Option 3a” (single synchronized vote across all networks with a common effective date).

#### 2. Update the GitHub configuration  
- After the vote passes, update `approved-sv-id-values.yaml` in the [SV config repo on GitHub](https://sync.global).  
- Ensure the new weight values and effective date match the on-chain vote exactly.

#### 3. Submit a Pull Request  
- The node operator who proposed the weight change creates a PR against `approved-sv-id-values.yaml`.  
- In the PR description, reference the on-chain vote transaction ID and effective date.  
- Tag the maintainers (`@gsf-maintainers`) as reviewers.

#### 4. Review & Merge  
- Maintainers review the PR for accuracy and consistency.  
- Once approved, merge the PR so the public file reflects the live network state.

#### 5. Publication & Confirmation  
- The merged file is automatically published at https://sync.global.  
- SV operators may verify weights by inspecting this public file.

#### 6. Re-onboarding behavior  
- If an SV is off-boarded and then re-onboards, they will receive the weight defined in the merged `approved-sv-id-values.yaml`.

#### 7. Enforcement & Escalation  
- If the PR is not opened within 24 hours of vote finalization, the proposing node may be flagged for non-compliance.  
- Repeated failures to submit or merge the PR may trigger an off-boarding vote or reconsideration of “Option 2” (automatic enforcement).

---

### Prior discussion and votes for reference

**YES: Separate PRs**  
- *pros:* immediate config/runtime consistency; avoids drift  
- *cons:* more PRs to manage; splits workflow into smaller steps  

**NOT Ignoring** (default)  
- *pros:* simplest—no extra steps  
- *cons:* renders the consistency check pointless; risk of unnoticed drift  

**Single PR + Reminders**  
- *pros:* fewer PRs; single source of truth for all envs  
- *cons:* requires active monitoring; notification fatigue leads to ignored reminders  

**Option 3a: Single PR with Common Effective Date**  
- Keep one PR per vote round when all networks share the same activation date  
