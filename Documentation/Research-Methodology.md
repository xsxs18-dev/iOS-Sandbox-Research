# Research methodology

## Before running

Record the app commit/build, device model, exact iOS version and signing configuration. Use your own device and data. Establish whether this is hardware or a simulator. Keep storage space, protection state and provisioning comparable. The app records model/OS/configuration but intentionally avoids serial numbers, device names, vendor/advertising IDs and personal content.

## Measurement

An experiment has a stable ID, category, objective, method and expected behavior. A run adds start/end times, environment, operations, errors and notes. Each operation becomes timestamped evidence with a resource, expected/actual result, state, error domain/code/description and environment. Automatic experiments run serially through a worker actor; the UI reports progress and checkpoints sessions. Manual experiments require explicit researcher actions or incoming configured links.

A successful API call is checked against expected bytes, attributes or callback data where possible. `PASS` is scoped to the described operation. Access refusal is `DENIED`. Missing capability/configuration is `NOT_SUPPORTED`. Missing prerequisites, future-launch checks and unperformed manual actions are `NOT_TESTED`. Operational failure is `ERROR`. A contradictory verification is `NEEDS_REVIEW`.

Session completion means the selected workflow finished; it does not mean every operation passed or every manual experiment was performed. Aggregated experiment results conservatively retain untested/failed/review states. Run details are more informative than a single summary badge.

## Evidence integrity and storage

Sessions are locally encoded as Codable JSON with schema version 1 and atomic file replacement. The store is actor-isolated. Interrupted runs are labeled on recovery. Corrupt files are retained and listed as load warnings. An interruption inside an experiment can lose its not-yet-checkpointed evidence. Session persistence is not a transactional journal of every system call.

Researcher notes are editable; the app is not a tamper-proof forensic recorder. Export an unchanged baseline and hash it externally for a stronger evidence chain. Imports have a 25 MiB limit, validate schema/identities, reject duplicate session IDs and are marked unauthenticated in their notes. Absolute paths in imported evidence remain inert display data. Exported reports include errors and notes; review them before sending outside your organization. Delete local sessions via a confirmed History action; external exports/backups are not recalled.

## Comparisons

Match operation identity and occurrence order within stable experiment IDs. Ignore random resource paths/timestamps for successful-operation comparison. Compare result states, complete error information and explicitly comparable configuration details. New operations/removals are differences, not automatically failures. A denied-to-pass transition is a newly allowed operation requiring investigation, not proof of a permission grant or regression.

Inspect device, OS, app build, bundle ID, simulator flag and protected-data availability differences. Different groups/signing can also explain results. Repeated lock samples must be interpreted with their event order and manual timing; arbitrary sessions are not necessarily comparable. A preexisting `NEEDS_REVIEW` result can remain unchanged and is still shown in B's review count.

## Follow-up

Reproduce mismatched bytes/attributes, persistence loss with a surviving receipt, unexpected post-delete presence, or repeatable changed access under genuinely equivalent context. Rule out lifecycle, disk errors, simulator behavior and configuration first. Preserve the evidence. Use [Responsible Disclosure](Responsible-Disclosure.md) only after manual validation.
