# Canton Network Glossary

## Core Network Concepts

- **Canton Network**  
  A decentralized “network of networks” that enables applications to interoperate while preserving their own privacy, governance, and scaling properties.

- **Subnetwork**  
  A grouping of applications, participant nodes, and synchronization domains under a common perimeter or governance. Subnetworks allow controlled interaction between specific sets of participants.

- **Synchronization Domain (Sync Domain)**  
  A consistency boundary within a subnetwork. All transactions inside a sync domain must be ordered and validated through its synchronizer.

- **Global Synchronizer**  
  The top-level synchronization service of the Canton Network, run by a set of super validators. It ensures interoperability across subnetworks while providing security, reliability, and upgrade management.

---

## Node Types

- **Participant Node**  
  A node that runs DAML applications, holds contracts, and proposes transactions. Participant nodes submit transactions to a synchronizer for validation and ordering.

- **Synchronizer Node**  
  Provides consensus services within a synchronization domain. It is composed of:  
  - **Mediator**: Validates transaction correctness, checks contract rules, and ensures dependencies are met.  
  - **Sequencer**: Establishes a total order of transactions to guarantee consistent execution across all participants.

- **Validator Node**  
  Operated by organizations to run Canton infrastructure, maintain decentralization, and participate in governance. In the global context, validator nodes may be *super validators* that operate the Global Synchronizer.

- **Super Validator**  
  A validator with elevated responsibilities for operating the Global Synchronizer, including governance, upgrade cycles, and ensuring liveness of the network.

---

## Transaction & Consensus Flow

- **Transaction Proposal**  
  A request from a participant node to execute a DAML contract. It is submitted to the synchronizer of the relevant sync domain.

- **Validation**  
  The mediator checks whether a transaction complies with DAML rules, privacy constraints, and existing state.

- **Sequencing**  
  The sequencer assigns a final ordering to transactions, ensuring deterministic execution across the sync domain.

- **Finality**  
  Once a transaction is validated and sequenced, it becomes final and is executed across all relevant participant nodes.

---

## Assets & Applications

- **Application**  
  A DAML-based business logic program deployed on the Canton Network. Each application can choose its own governance and subnetwork scope.

- **Asset**  
  A digital representation of a real-world or synthetic object (e.g., cash, securities, data feeds). Assets are governed by DAML contracts and can be traded or transferred within subnetworks.

- **Amulet Rules**  
  A system of rules enforced at the validator level to ensure compliance with Canton Network requirements for participation, upgrade adoption, and network reliability.

---

## Governance & Operations

- **Governance Model**  
  Defines who can operate validators, how subnetworks are created, and how protocol upgrades are adopted. Governance occurs at both the subnetwork and global levels.

- **Upgrade Cycle**  
  The process of releasing and adopting new versions of DAML and the Canton protocol. Typical cadence: DAML ~3x per year, Canton protocol ~2x per year. Validators are expected to keep pace with upgrade adoption.

- **Network Perimeter**  
  The set of nodes and policies defining which participants can join a given subnetwork or sync domain.

- **Onboarding**  
  The operational and compliance process for admitting new participants or validators into a subnetwork or the global network.

---

## Canton Coin (CC)

- **Canton Coin**  
  The native utility token of the Canton Network, used for payment applications, validator rewards, and incentives.

- **Tokenomics**  
  The design of issuance, validator rewards, ecosystem funds, and emission rates for Canton Coin.

- **Minting**  
  The process of issuing new Canton Coins according to the network’s emission schedule, typically distributed across validator and ecosystem reward pools.

---

## Security & Reliability

- **Privacy Model**  
  Canton enforces application-level privacy by ensuring that only authorized parties see the contracts and transactions relevant to them.

- **Resilience**  
  Achieved through decentralization of validators, continuous uptime requirements, and rapid adoption of upgrades.

- **Interoperability**  
  The ability of multiple applications across different subnetworks to interact while preserving privacy and governance constraints.
