## Logging Policies and Log Sharing Process

### Purpose

Following the Commitments failure, we identified the need for a consistent approach to log sharing. A new endpoint to reinitialize ACS commitments will land within ~2 weeks and propagate to mainnet through the normal release cycle.

This document describes agreed-upon logging policies, responsibilities, and handling procedures.

## Policies

### When / Why Logs Will Be Shared
- Logs are only shared upon request to resolve an incident.  
- Operators should respond within **two weeks** of a request.  
- During active incidents, operators are expected to respond faster whenever possible.  

### With Whom Logs Will Be Shared
- Other Super Validator (SV) Operators  
- Splice team (all organizations)  
- Canton team  
- Digital Asset  

### How Logs Will Be Shared & Secured
- Logs will be placed in a **limited-access Google Drive folder**.  
- Entities listed above may download at their discretion.  
- Logs must be scanned for secrets (KMS keys, DB credentials, etc.) before sharing.  

### What Will Be in the Logs
- Logs are not expected to contain sensitive information.  
- When nodes keep keys in KMS and secure database credentials, risk is minimal.  
- Operators must manually verify that secrets are removed.  

### Retention & Deletion
- Logs will be deleted from the shared Google Drive folder once the incident is resolved.  
- Entities that downloaded logs are responsible for deleting them per policy or manually (no central enforcement).  

## Process

1. **Incident Identification**  
   - An operator or team identifies an issue requiring logs for resolution.  

2. **Log Request**  
   - The request is communicated to the relevant operator(s).  
   - Requesting entity specifies scope and urgency.  

3. **Operator Response**  
   - Operator scans logs for secrets.  
   - Logs are uploaded to the designated Google Drive folder.  
   - Operator notifies requestor that logs are available.  

4. **Access & Use**  
   - Approved parties (SV Operators, Splice, Canton team, Digital Asset) may access and download logs.  

5. **Resolution & Cleanup**  
   - Once the incident is resolved:  
     - Logs are deleted from the shared Google Drive folder.  
     - Entities that downloaded logs are expected to delete their local copies.  

