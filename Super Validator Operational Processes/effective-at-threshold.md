## Effective at Threshold – Process and Use Guidelines

### Definition

“Effective at Threshold” means that as soon as ⅔ of Super Validators (SVs) vote in favor of a proposal, it immediately goes into effect. This overrides the normal “Effective Date” schedule and is intended only for very high-priority or emergency situations.


### When It Can Be Used

* Emergencies only — not for normal operations.
* Appropriate scenarios include:
  * Critical bug fix requiring immediate Daml model adoption or protocol upgrade.
  * Agreement among ⅔ SVs (in Slack) that a node is causing network instability and must be offboarded immediately.

### When It Should NOT Be Used

* Customer pressure to implement weight changes quickly.
* Accelerating featured app status for non-urgent reasons.
* Any case where urgency is based on convenience or external business demands rather than network security or stability.

Reason: In non-emergency situations, using “Effective at Threshold” can incentivize SVs to delay voting or not vote at all, which is counterproductive to timely participation.

###  Interaction with Other Voting Rules

* Rejection rule: Votes are rejected if ⅔ of SVs vote “Reject.”
* Expiration rule: If ⅔ of SVs take no action before the expiration date, the proposal expires (expiration applies to the proposal lifecycle, not voting rights).
* Post-expiration voting: SVs may still cast votes after the proposal expiration date.


### Offboarding Considerations

* Offboarding an SV may be an emergency but should not default to “Effective at Threshold.”
* In many cases, setting a short fixed effectivity window (e.g., 4 hours) is sufficient.

### Guiding Principle

Use “Effective at Threshold” only when delay would harm network stability, security, or integrity. SVs are not penalized for not participating in an emergency vote.

