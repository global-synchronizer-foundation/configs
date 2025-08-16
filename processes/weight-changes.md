## Coordinating Weight Changes Across Networks

### Purpose

This process ensures that on-chain Super Validator weights remain in sync with our public GitHub configuration (`approved-sv-id-values.yaml`), and that any SV re-onboarding uses the correct, network-approved weights.

### Process

#### 1. Initiate on-chain vote  
- Propose weight changes via on-chain governance (single synchronized vote across all networks with a common effective date).

#### 2. Submit a Pull Request  
- The node operator who proposed the weight change creates PRs (one PR for each vote) in the [configs](https://github.com/global-synchronizer-foundation/configs) repository against `approved-sv-id-values.yaml` for each network.
- In the PR description, reference the on-chain vote transaction ID and effective date.  


#### 4. Review & Merge  
- When one or more votes pass the votes initiator leaves comments about this fact on the related PRs
- Maintainers review the PRs for accuracy and consistency, approve and merge them so the public files reflect the live network state.

#### 5. Publication & Confirmation  
- The merged file is automatically published at https://sync.global/sv-network.
- SV operators may verify weights by inspecting this public file.

#### Notes
- Re-onboarding  
  - If an SV is off-boarded and then re-onboards, they will receive the weight defined in the merged `approved-sv-id-values.yaml`.

- Enforcement & Escalation  
  - If the PR is not ready for merging within two business days of vote finalization, the proposing node may be flagged for non-compliance.  
  - Repeated failures to prepare the PRs within required time may trigger an off-boarding vote.

- Keep one PR per vote round when all networks share the same activation date  
