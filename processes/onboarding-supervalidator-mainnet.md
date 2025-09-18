## Background: 

Super Validator operators prioritize stable operation of the MainNet for the Global Synchronizer on Canton Network. To increase the likelihood of stable operations, the Super Validators have operated Super Validator nodes on a DevNet since March 2023, with a formal launch of TestNet in July 2023. New operators have added nodes to DevNet and TestNet over time. 

Operating independently, the Super Validators have adopted decentralized governance processes. Actions and decisions take effect when a ⅔ majority of node operators adopt the same Canton version, Daml smart contract code, application code and/or configuration settings on their respective nodes. 

This document outlines the acceptance criteria that existing Super Validators have considered to determine whether to vote to allow a new Super Validator to join the MainNet. The document represents an ongoing consensus on recommendations, and although there is broad agreement, no Super Validator is bound to follow these guidelines in the event of an onboarding vote. 

Super Validator operators upgrade their nodes on a regular basis, typically once per week, and sometimes more than once per week on DevNet. Deployment is highly automated, and operators can generally adopt changes quickly across all the nodes they operate. Software upgrades are expected to take five to ten minutes, and backup and restore procedures are expected to complete on the order of an hour.  Major migrations with breaking changes (also called “hard migrations”) are performed in a synchronous process during a one- to three-hour video call.  


## Onboarding Process

### Communications 

* Once new Super Validator operators are ready to begin the onboarding process, they will be added to the “supervalidator-operations” Slack channel
    * Their first action after joining the “supervalidator-operations” channel should be to provide
        * SV-Name, aka “onboarding name”
            * Full business name of the entity which has rights to operate this Super Validator, with normal Capitalization, and hyphens between words. SV Name should be the same as that used by the Super Validator in typical business documentation. (e.g. My-Company-Limited).
        * Public Key
        * Fixed IP for whitelisting the SV node.  


### Acceptance Criteria and Recommendations

* The Super Validator operators have reached consensus on a set of acceptance criteria that they will likely use to determine whether to vote to add a new SV node operating on DevNet to join TestNet, and an additional set of criteria to be met while operating on TestNet in order to join the MainNet. The Super Validators have also provided a list of additional Recommendations for Super Validator operators. 
* The line between Acceptance Criteria and Recommendations is still under discussion among the Super Validator operators. Some Recommendations may be added to the Acceptance Criteria by ⅔ vote, and each Super Validator may vote independently whether to onboard a new node. 

#### Acceptance Criteria

##### Before operating on DevNet

* Use the following naming conventions for Super Validator operators
    * URLs: 
        * https://&lt;appname>.sv-&lt;enumerator>.dev.global.canton.network.&lt;TLD>
            * Where “TLD” is the top level domain commonly associated with the entity which has rights to operate this Super Validator node. 
        * Report these URLs to the other Super Validator operators in Slack
    * Open a PR to add the SV node to `approved-sv-id-values.yaml` on DevNet
        * To do this, fork the repo against the main repo from your fork.
        * As part of this PR, the onboarding SV operator sets the weight of the onboarding SV to zero (0). 
        * The actual SV weight will be allocated via an onchain vote. 

##### While operating on DevNet

1. Document and explain your deployment of the Super Validator node. This explanation may be in writing, or in an Operations meeting of the Super Validators.
2. Restore a Super Validator node from backup.
3. Complete an asynchronous upgrade of the Super Validator node.
4. Stage a migration-ready SV node in advance of a hard migration (protocol-changing migration).
    - a. Allow other SV operators to confirm the sequencer endpoint
    - b. Allow other SV operators to confirm that the node communicates with its peers on the BFT ordering layer
5. Change the Super Validator Canton Coin minting weight of the Super Validator node .
6. Confirm connectivity on all required ports before and after major upgrade / hard migration.
7. Complete a Major Upgrade / Hard Migration rehearsal action with all other Super Validators. Hard Migrations take place in coordinated, synchronous ceremonies involving all Super Validators. 
8. Complete a network-wide disaster recovery action with all other Super Validator operators
9. Provide an escalation method through which other Super Validator operators can reach your node operator in the following three conditions:
    - a. Your SV node is down
    - b. Another Super Validator node is down, and there is a vote proposal active to offboard that node from the quorum of Super Validator nodes
    - c. The Global Synchronizer is down and disaster recovery is in progress. 
    - d. Recommended response time for these escalations is currently four (4) hours. 
10. Attend weekly meetings of the Super Validator operator. These meetings are currently held in two weekly sessions: one session at 8 pm US Eastern (NYC) time on Mondays, and a second session at 9 am US Eastern (NYC) on Tuesdays. An operator of your node should attend one session each week.  
11. If applicable, transition SV weights from a hosted service to your own node. 

##### While operating on TestNet

1. Complete an asynchronous upgrade of the Super Validator node
2. Change the Super Validator Canton Coin minting weight of the Super Validator node 
3. Complete a Hard Migration (protocol changing) action with all other Super Validators. Hard Migrations take place in coordinated, synchronous ceremonies involving all Super Validators. 
4. Confirm connectivity on all required ports before and after major upgrade
5. Complete a network-wide disaster recovery action with all other Super Validator operators
6. Continue to join weekly SV operator calls. 
7. If applicable, transition SV weights from a hosted service to your own node.

#### Recommendations 

Before joining DevNet, complete or prepare to complete the following: 

* Show that it is possible to:
    * Deploy SV apps + Ingress configuration with a single command
    * Roll out configuration changes with single command
    * Roll out a new version of apps with single command
    * Run two (old and current) synchronizers (cometbft + global-domain + participant) with different configurations at the same time where SV apps are pointing to one of them
* Recover CometBFT storage from backup
* Recover all databases from backup to either the same point in time (if all DBs share the same WAL) or in a specific order of data age
* Trigger backup jobs for CometBFT storage and PostgreSQL databases  manually
* Show that it is possible to change all configuration parameters in one place, including:
    * domain (string, e.g. `dev.global.canton.network.&lt;tld>`)
    * sponsor_domain (string, `dev.global.canton.network.digitalasset.com`)
    * env (string, e.g. devnet)
    * synchronizer_migration_id (int)
    * synchronizer_migrating (bool, default: false)
    * cometbft_state_sync_enabled (bool, default: false)
    * use_old_synchronizer (bool, default: false)
* Implement a backup system that allows the SV node to recover CometBFT and PostgreSQL databases to a point in time up to at least 7 days in the past, with granularity of 4 hours or less. 
* Confirm that you allow outbound traffic to all Super Validator peers
* Demonstrate that your Scan, Sequencer are reachable by the other Super Validator operators, and that other SV operators see you as a peer. 
* Document your procedures for
* Deploying, re-configuring and upgrading Super Validator apps and ingress
* Backing up and restoring CometBFT storage and PostgreSQL databases
*  Confirm that it is possible to:
    * Detect difference between running and desired configuration of sv apps and ingress
    * Delete all apps without deleting persistent data (CometBFT storage and PostgreSQL databases)
    * Delete CometBFT storage, global-domain and participant databases for an old synchronizer while keeping backups
    * Configure OIDC provider with a single command
* Document your internal procedures for performing a Hard Migration of the synchronizer
* Minimize network latency within your cluster. This usually means hosting apps in the same availability zone as their databases. 