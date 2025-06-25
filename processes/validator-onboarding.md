

# Validator Onboarding Process

*Note: If you are only interested in setting up a validator node, you can set up a node on DevNet for practice, then jump to MainNet. If you’d like to build, test, or deploy an app, we recommend that you run a node on DevNet, TestNet, and MainNet.*

*Note: DevNet is open to any whitelisted node, TestNet and MainNet require invitation via an SV sponsor.*

**Docs:**

[https://sync.global/docs/](https://sync.global/docs/)

**Join the #validator-operations channel hosted by the Global Synchronizer Foundation using Slack Connect:**

[https://daholdings.slack.com/archives/C08AP9QR7K4](https://daholdings.slack.com/archives/C08AP9QR7K4)

→ Your Slack workspace may allow you to browse to this channel, or you can ask your SV sponsor to send you an invitation. 

**High Level Steps:**


1. Ask the Super Validators to whitelist a fixed IP on DevNet for your Validator node
2. Spin up your node for DevNet
3. Request a DevNet onboarding secret - via API call (curl) 
4. Ask the Super Validators to whitelist your fixed Whitelist your IP on MainNet for your Validator node
5. Spin up your node on MainNet
6. Request a MainNet onboarding secret - via Slack to your sponsoring SV 

**Stay Connected:**

Also, to stay up to date with changes and announcements from the Global Synchronizer Foundation, you should consider joining the following email lists. 

* main
* cip-announce
* tokenomics-announce
* validator-announce

To join these lists, 

1. Create an account at groups.io
2. Go to lists.sync.global and sign up




## 1. Whitelist your IP for DevNet

Share your IP with your Super Validator sponsor. 

The Super Validator sponsor will submit a request to the other Super Validators. It will take between 2-7 days for other SVs to adopt this IP address.

*Note: If you’re wondering whether the Super Validator nodes have whitelisted your IP address, you can attempt to open the Scan UI of each Super Validator from your whitelisted IP, or simply, curl the Scan endpoints in the listed [Super Validator Node Information](https://sync.global/sv-network/).*

*For example, by using a command like this, and changing the input URL to each Scan URL offered by the Super Validators:*

	`curl https://scan.sv-1.dev.global.canton.network.sync.global/api/scan/v0/scans | jq`


## 2. Spin up your DevNet Node

Follow the steps detailed in the documentation below to spin up your node in preparation for joining DevNet.


## 3. Request a Secret from your SV Sponsor

Once ⅔ of the Super Validators have whitelisted your IP address, you’ll be able to join DevNet. To join, request an onboarding secret via API call (curl). 

Request approval to join MainNet. To do so: 



* Ask a Super Validator to sponsor you on MainNet
* Complete the Validator node request form here: [https://sync.global/validator-request/](https://sync.global/validator-request/)
* Your application will be reviewed by the Tokenomics committee of the Global Synchronizer Foundation. 
* Requests are accepted, or rejected, after one week. 
* Accepted Validators are announced in the tokenomics-announce mailing list at https://lists.sync.global


## 4. Whitelist your IP for MainNet

Share your MainNet IP with your Super Validator sponsor. 

The Super Validator sponsor will submit a request to the other Super Validators.

Super Validators will check the status of your Validator Request before accepting your whitelisting request. 

As with DevNet, it will take between 2-7 days for other SVs to adopt this IP address.


## 5. Spin up your MainNet Node

Follow steps detailed in the docs to spin up your node on MainNet. At this point everything should be prepared to be deployed, and deployment will occur with the onboarding secret described in the next step. 


## 6. Request a Secret from your SV Sponsor

Request an onboarding secret from your SV sponsor via Slack to your sponsoring SV for TestNet & MainNet. 
