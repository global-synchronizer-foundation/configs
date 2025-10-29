# Proposal: SV bugfix releases for MainNet

## Motivation

When an issue is threatening MainNet that requires a new Splice release to adequately resolve, our current practices only allow for the following options:

1. Fast-track a regular release, i.e., cut a regular release and reduce the time we require it to stay on DevNet and TestNet before accepting on MainNet.  
2. Skip a problematic release on MainNet.  
3. Accept the risk and just wait for 2-3 weeks.

3 is clearly not always an option, and neither is 2\.

1 Is always an option, but fast-tracking a full Splice release adds additional risks as the release will usually include significantly more changes than required for addressing the issue.

It seems like the current risks to MainNet stability require us to react more quickly.

## Scope of this document

* Aligning on a process for bugfix releases that need to be applied **only on SVs**.  
  * This process does not cover any method for adopting bugfix releases by validators.  
* Validators are expected to stick to the regular release schedule.  
* *If* we see the necessity for a bugfix process for validators as well, we’ll follow up with an update to this process.

## Proposed rules for bugfix releases

* Targeted: A bugfix release contains only the minimal amount of changes on top of its base version to fix a given issue.  
  * This can include a Canton upgrade as long as the change on the Canton side meets the “targeted” criterion as well.  
  * The following types of changes are not considered sufficiently “targeted” by default and need additional justification and explicit highlighting if they are to be included in a bugfix release  
    * “One-way” upgrades that make downgrades to the previous version unsafe  
    * Daml model upgrades  
    * DB schema migrations  
    * Major upgrades that require a synchronizer migration (implies: no protocol change)  
* No skipping: The default upgrading schema is “we fast-track the bugfix”; i.e.:  
  * No (snippet) of code runs on MainNet before having been confirmed to work on DevNet *and* TestNet.  
  * The releases containing the bugfix might still vary between networks (but all of them must include the bugfix code targeted for MainNet).  
  * Deviations from this default need additional justification and explicit highlighting.  
* Fast preparation: The Splice team can cut a bugfix release with low overhead and delays.  
  * This includes delays for coordinating upgrading schedules: bugfix releases do not change the regular release cutting and upgrading schedule.  
* Naming ([Semantic Versioning](https://semver.org/spec/v2.0.0.html))  
  * Before Splice 1.0.0: by example: a bugfix release for 0.4.18 would (have to) be called `0.4.19-bugfix.preview`, the next one `0.4.19-bugfix.preview.1`, etc.  
  * After Splice 1.0.0: by example: a bugfix release for 1.1.0 could just be `1.1.1`  
* Vote and commit  
  * Once a governance majority (\>⅔) of SV operators have agreed to a bugfix release \+ upgrading plan, each SV operator is obliged to commit to it.

## Proposed process and rules for accepting bugfix releases

Assuming an issue has been identified that is threatening MainNet:

1. Splice maintainers come to the conclusion that a bugfix release is their recommended option for resolving this issue in time.  
2. Splice maintainers prepare a proposal  
   * Description of the issue and proposed resolution.  
   * Description of the diff of the planned bugfix release.  
     * More impactful changes are not allowed by default and need to be highlighted for explicit risk-acceptance; see “targeted” rule above.  
   * Detailed description of the planned upgrading schedule; for example  
     1. when and how the bugfix will be applied to DevNet and TestNet first  
        * “Skipping” of a network is not allowed by default and needs to be highlighted for explicit risk-acceptance; see “no skipping” rule above.  
     2. application to only some SVs first for testing; others following suit only after additional confirmation  
     3. do all SV need to apply the bugfix release or is a subset sufficient (if so: who must do it, and who may)  
     4. description of the reconciliation with the regular release schedule, i.e.  
        * which regular release is expected to include the bugfix (or a superset thereof)  
        * what (if anything) needs to be considered when upgrading from a bugfix release to the next regular release  
   * Description of the best alternative option we have for resolving the issue (for example, fast-tracking a regular release).  
3. The proposal is sent out to all SV operators on the relevant production networks, via email to the [supervalidator-ops](https://lists.sync.global/g/supervalidator-ops) mailing list.   
   * Discussion is welcome on Slack as well, but we want a record for both the original proposal and the subsequent voting on it.  
4. (In parallel to the remaining steps.) The splice team prepares the bugfix release. (Preparing does not imply that it will be used\!)  
5. Each SV operator individually decides on whether they support the proposal or not, based for example on the following criteria:  
   * Is the risk relevant enough to warrant timely action from all SV operators. (If no reject.)  
   * Are the costs and risks of the alternative option acceptable for the network as a whole. (If yes reject.)  
   * Could application of the bugfix release imply additional risks such that the situation after applying the bugfix release appears more risky than accepting the risk without action. (If yes reject.)  
6. SV operators that are in favor confirm via email to the supervalidator-ops mailing list.  
   * Not Slack\! For better overview \+ more durable record.  
7. Once a governance majority (\>⅔) of SV operators have agreed to the bugfix release, each SV operator is obliged to apply the bugfix release on their node if required to do so per the schedule contained in the proposal.  
8. (Eventually) Nodes upgraded to a bugfix release are upgraded to a regular release (as per the bugfix release proposal) and return to the regular upgrading schedule from there on.

## Proposed test of this process if accepted

If this process is adopted, we suggest to test it once by releasing an “empty” bugfix release (no actual changes) and adopting it on `TestNet` (skipping `DevNet`), following the exact steps outlined above.