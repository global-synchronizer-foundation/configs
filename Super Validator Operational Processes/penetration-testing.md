## Penetration Testing Policy

### Purpose

This process defines the rules and procedures for conducting penetration testing (pen testing) on Canton Network environments to ensure security testing does not disrupt normal network operations.

### Status

This is a draft process based on current working practices and prior agreements among SV operators.

### Process

#### 1. Approved Testing Environments

- **All testing must be conducted on ScratchNet first.**
- If testing is planned on **DevNet** or **TestNet**:
  - The tester must **notify SV operators in advance**.
  - Provide testing scope, expected start time, and estimated duration.

#### 2. Restrictions

- **Pen testing is strictly prohibited on MainNet.**

#### 3. Handling Disruptions

- If testing causes operational issues on DevNet or TestNet:
  1. Contact the tester immediately to inform them of the problem.
  2. If the tester is **unresponsive**, **offboard the testing node** to restore network stability.

#### 4. Communication and Documentation

- All testing activities outside ScratchNet must be documented, including:
  - Tester’s name and contact information
  - Testing scope and timeline
  - Notified SV operators
- Any incidents caused by testing must be recorded and reviewed in the next SV Operations meeting.

### Notes

- ScratchNet is the preferred and safe environment for experimentation.
- Advance notification ensures operators can monitor network health and minimize potential disruption.
- Enforcement actions (such as offboarding) are a last resort if communication fails.