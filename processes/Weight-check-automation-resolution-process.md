## Weight Check Automation & Resolution Process

### Purpose

Ensure that automated checks validate Super Validator weight configurations against on-chain votes and provide a clear resolution workflow for any discrepancies.

### Process

#### 1. Re-enable automated weight checks  
- GSF DevOps toggles the CI pipeline to run weight-consistency checks on every PR against `approved-sv-id-values.yaml`  
- Checks fetch live on-chain weights and compare them to the YAML configuration

#### 2. Flag and notify  
- On mismatch, CI creates an issue labeled `weight-check-failure` in the SV config repo  
- A notification is sent to `#validator-ops` on Slack and emailed to the originator of the vote

#### 3. Assign responsibility  
- The originator of the weight-change proposal must resolve any flagged errors  
- If no PR corresponds to a recent vote, that vote should be voted down by default

#### 4. PR creation and correction  
- As per Itai’s guidance, the proposal originator opens the PR and references it in the vote request  
- The originator must update the PR to clear all CI flags before merging

#### 5. Merge permissions  
- IEU staff may merge weight-change PRs internally provided that:  
  - One individual submits the PR and a different individual merges it  
  - All CI checks pass

#### 6. Visibility and reporting  
- CI results and open failure issues remain publicly visible in the SV config repository  
- A weekly summary of weight-check failures is distributed to all SV operators

#### 7. Escalation  
- Unresolved errors older than 48 hours trigger notification of the GSF governance team  
- Repeated non-compliance may lead to an off-boarding vote under SV governance policy

---

### Background & Related Automations

- GSF now handles many parallel weight changes; automated checks prevent configuration drift  
- **Legacy node advertising lessons:**  
  - Tie `legacy_migration_id` to active legacy nodes; unset only when nodes are shut down  
  - Recommend automating enforcement:  
    ```
    if migrating = true ⇒ legacy_migration_id != null
    ```  
  - Manual recovery exists but network risk is low if ≥ 1 SV remains correctly configured  
  - Mid-term: enforce the migrating ⇒ legacy_migration_id rule; long-term: eliminate hard migrations  
