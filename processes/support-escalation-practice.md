## Support Escalation Practice Process

### Purpose

This process defines the cadence, execution, and follow-up steps for conducting Support Escalation Practice exercises among Super Validators (SVs) to ensure readiness for production issues requiring escalation and coordination.

### Scope

This applies to all SVs participating in the Global Synchronizer ecosystem. The process is designed to simulate real incident escalations across the network and validate that procedures, roles, and response timelines function as expected.

### Cadence

- Support Escalation Practices will be conducted **twice per year**.
- Dates will be scheduled and published at least **four weeks in advance**.
- Scheduling and facilitation responsibilities will rotate among SVs or be delegated by random selection.

### Execution

1. **Design the Scenario**
   - The practice facilitator prepares one or more synthetic incident scenarios.
   - Scenarios must:
     - Require multi-party coordination
     - Involve escalation paths
     - Simulate real failure modes (e.g., stuck transactions, node outages)

2. **Notify Participants**
   - All participating SVs will receive the scheduled time, facilitator contact, and any preconditions (e.g., login setup, communication tools).
   - Participation is mandatory unless a written exception is provided.

3. **Run the Practice**
   - Facilitator initiates the incident scenario and monitors the response timeline and accuracy.
   - Participants are expected to escalate, respond, and communicate using standard production channels (e.g., Slack, email, incident tooling).

4. **Track Outcomes**
   - [A standardized tracking sheet](https://docs.google.com/spreadsheets/d/1E_mpitcz-R9Hd3BdqriWCLXQRC5-wHo8iJf1pSA5UvE/edit?gid=626954229#gid=626954229) will be used to capture:
     - Time to detect and escalate
     - Time to resolution or simulated resolution
     - Gaps in process, tooling, or communication
   - The tracking sheet must be shared in `#supervalidator-ops` within 48 hours.

5. **Debrief and Document**
   - A short debrief session will be held within one week.
   - The facilitator will publish:
     - A summary of findings
     - Identified process failures (if any)
     - Action items and owners for remediation

6. **Remediation**
   - Any confirmed failures in the escalation process must be addressed before the next practice cycle.
   - Remediation actions and their status must be reported in `#supervalidator-ops`.

### Notes

- All SVs are expected to maintain accurate escalation contact information and be reachable during scheduled practices.
- This process is reviewed annually and updated based on retrospectives from prior practices.
