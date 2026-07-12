# friction-append-application-bugfix

#convention
## Thesis

`core/append-application.sh` was specced in
`math/friction-append-application-as-packet/` with a clear
contract: `--by=agent` works inline, multi-line applications
are first-class. Two bugs broke that contract in practice:

1. The arg parser accepts `--by VALUE` but rejects `--by=VALUE`,
   even though the help text and refinement.md both advertise
   the `--by=...` form.
2. The awk-based appender only matched
   `^applications:[[:space:]]*$`. A packet.yaml shipping
   `applications: []` (inline empty form, emitted by
   `init-packet.sh`) was silently left untouched — the script
   exited 0 saying "ok", but `applications[]` stayed empty.

The first bug makes the script surprise users. The second
bug **silently lies**: it reports success while doing nothing.

## Antithesis

A bug report against `append-application.sh` deserves a
one-line fix without ceremony. But the convention says every
non-trivial fix is authorized by a packet. The task here is
small (2 flags, 1 regex), but the rule applies: open a packet.

## Synthesis

Open `math/friction-append-application-bugfix/`, supersede
`friction-append-application-as-packet/`. Two narrow changes:

1. Extend the case-loop to match `--by=VALUE` alongside
   `--by VALUE`.
2. Extend the awk regex to handle `^applications:\s*\[\]\s*$`
   by rewriting it to a multi-line form and inserting the
   entry immediately. Track an `inserted` flag so the END
   branch does not double-print.

Test obligation is unchanged: a fresh `applications: []`
packet now becomes a single-entry `applications:` block after
one script call.

What this packet commits to:
- `core/append-application.sh` parses `--by=VALUE` and the
  inline empty `applications: []` form correctly.
- The `--force` path continues to work (regression-tested).
- Supersession: `friction-append-application-as-packet` →
  `lifecycle: superseded` with reason pointing here.

What this packet does NOT commit to:
- A YAML-aware parser (mature yq/ysy-based replacement is
  deferred to a future packet if needed).
- Coverage.yaml unique-id check (that's a verifier change,
  not a script change — separate packet).
- Wire-up of `core/init-packet.sh` to emit multi-line
  `applications:` from the start (orthogonal improvement).

`See: math/friction-append-application-as-packet/refinement.md#test-obligation`
`See: core/append-application.sh`

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-bugfix/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-bugfix/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-bugfix/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-bugfix/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/friction-append-application-bugfix/packet.yaml)

## Decision

#convention
## Thesis
`core/append-application.sh` was specced in
`math/friction-append-application-as-packet/` with a clear
contract: `--by=agent` works inline, multi-line applications
are first-class. Two bugs broke that contract in practice:
1. The arg parser accepts `--by VALUE` but rejects `--by=VALUE`,
   even though the help text and refinement.md both advertise
   the `--by=...` form.
2. The awk-based appender only matched
   `^applications:[[:space:]]*$`. A packet.yaml shipping
   `applications: []` (inline empty form, emitted by
   `init-packet.sh`) was silently left untouched — the script
   exited 0 saying "ok", but `applications[]` stayed empty.
The first bug makes the script surprise users. The second
bug **silently lies**: it reports success while doing nothing.
## Antithesis
A bug report against `append-application.sh` deserves a
one-line fix without ceremony. But the convention says every
non-trivial fix is authorized by a packet. The task here is
small (2 flags, 1 regex), but the rule applies: open a packet.
## Synthesis
Open `math/friction-append-application-bugfix/`, supersede
`friction-append-application-as-packet/`. Two narrow changes:
1. Extend the case-loop to match `--by=VALUE` alongside
   `--by VALUE`.
2. Extend the awk regex to handle `^applications:\s*\[\]\s*$`
   by rewriting it to a multi-line form and inserting the
   entry immediately. Track an `inserted` flag so the END
   branch does not double-print.
Test obligation is unchanged: a fresh `applications: []`
packet now becomes a single-entry `applications:` block after
one script call.
What this packet commits to:
- `core/append-application.sh` parses `--by=VALUE` and the
  inline empty `applications: []` form correctly.
- The `--force` path continues to work (regression-tested).
- Supersession: `friction-append-application-as-packet` →
  `lifecycle: superseded` with reason pointing here.
What this packet does NOT commit to:
- A YAML-aware parser (mature yq/ysy-based replacement is
  deferred to a future packet if needed).
- Coverage.yaml unique-id check (that's a verifier change,
  not a script change — separate packet).
- Wire-up of `core/init-packet.sh` to emit multi-line
  `applications:` from the start (orthogonal improvement).

## Task

# friction-append-application-bugfix

#convention
## Problem

`core/append-application.sh` does not honour its own spec.
Two symptoms:

1. `sh core/append-application.sh <id> HEAD --by=agent` exits
   with `ERROR: unknown flag '--by=agent'`. The help text and
   the original packet's test obligation both claim the
   `--by=...` form should work.
2. `sh core/append-application.sh <id> HEAD --by=agent` on a
   fresh packet.yaml (`applications: []` emitted by
   `init-packet.sh`) reports `ok` and exits 0 but writes
   nothing. Operators assume the SHA was appended.

## Desired outcome

- `--by=VALUE` accepted alongside `--by VALUE`.
- `applications: []` rewritten to multi-line form on first
  append; existing multi-line packets unchanged.
- Single-entry result on a fresh packet (no duplicate from
  the END branch).
- `sh core/verify.sh` returns VERIFIED.

## Constraints

- Mode: `standard` (structural edit on a core/ tool
  authorized by an existing packet).
- POSIX-shell only — no awk features beyond what the prior
  script already used.
- Existing `--force`, `--by VALUE`, and multi-line applications
  paths must keep working (regression-tested).
- The original packet `friction-append-application-as-packet`
  is superseded, not edited.

## Out of scope

- Rewriting the script in Python or adding yq/ysy.
- Adding a `unique-id` check on coverage.yaml.
- Touching `core/init-packet.sh` to emit multi-line
  applications[] from the start.

## Steps taken

1. Edit `core/append-application.sh` arg loop to accept
   `--by=*`.
2. Edit awk block in `core/append-application.sh` to handle
   inline empty `[]` form.
3. Test on a temp packet in `math/test-pkt/` (since deleted).
4. Open `math/friction-append-application-bugfix/` packet.
5. `sh core/verify.sh`. Expect VERIFIED.
6. Commit, append applications[].

## Assumptions

```yaml
task_id: friction-append-application-bugfix
assumptions:
  - id: A1
    statement: "The original test obligation in friction-append-application-as-packet/refinement.md#L33-L35 is the spec the script must match"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      refinement.md lines 33-35 list `sh core/append-application.sh <id>
      HEAD --by=agent` as the very first test obligation. The
      script does not satisfy it on `--by=agent` (parser rejects).
      See: packet:friction-append-application-as-packet/refinement.md

  - id: A2
    statement: "core/init-packet.sh emits applications: [] on the same line as the key"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Read core/init-packet.sh template and freshly-created
      packet.yaml under math/*/ — all show `applications: []`
      on a single line. The awk regex in the original script
      only matched `^applications:[[:space:]]*$`, silently
      leaving inline-empty blocks un-updated.
      See: core/init-packet.sh
      See: math/README-as-OS-clarification/packet.yaml

  - id: A3
    statement: "Supersession, not in-place edit, is the correct way to fix a packet-authorized utility"
    status: judgment
    epistemology: judgment
    evidence: |
      agents.md#strict-rules says: outside math/ is OS,
      authorized by a packet. agents.md#edit-protocol says
      structural edits to a packet-authorized artifact are
      made via a new packet with supersession. The bug is in
      core/, so a new packet must own the fix.
      See: agents.md
      See: packet:math-coding-birth/refinement.md#edit-protocol

  - id: A4
    statement: "POSIX awk regex character classes + simple BEGIN/in_app state machine are sufficient for the fix"
    status: agent-inferred
    epistemology: proven
    confidence: 0.95
    evidence: |
      The original awk already uses BEGIN + in_app + END pattern
      with no GNU extensions. Adding an inserted flag plus one
      more match arm for the inline-empty form stays within that
      envelope. Manual test on math/test-pkt/ (since deleted)
      confirmed single-entry result.
      See: core/append-application.sh (post-fix)

  - id: A5
    statement: "Dup-printing bug in the awk END branch is real and visible only on the inline-empty path"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Manual reproduction on /tmp/test_orig.yaml with the
      pre-fix awk printed 2 entries; multi-line form printed 1.
      The dup-print is caused by inline-branch setting in_app=1
      without an inserted flag, so END fires.
      See: /tmp/test_orig.yaml reproduction

  - id: A6
    statement: "The append-application.sh script is convention-OS, not a packet; the fix doesn't need verifier drift-check beyond running sh core/verify.sh"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/*.sh are OS files per packet-core-as-packet; only
      math/*/ carry packet schemas. core/verify.sh checks
      packet structural invariants, not script behavior.
      See: packet:core-as-packet/decision.md
      See: core/verify.sh (code inspection)
```

## Refinement

# Refinement: friction-append-application-bugfix

#convention
## State

- **pre**:
  - `core/append-application.sh` rejects `--by=VALUE`.
  - `core/append-application.sh` silently no-ops on
    `applications: []` (claims ok, writes nothing).
  - `--force` and multi-line append paths work but are
    shadowed by the two bugs above.
- **post**:
  - `--by=VALUE` accepted (alongside the prior `--by VALUE`).
  - Inline empty `applications: []` rewritten to multi-line
    form on append, single entry written, no double-print.
  - `--force`, multi-line append, and dedup paths unchanged.
  - `friction-append-application-as-packet` lifecycle
    becomes `superseded`.

## Operation

- Open packet `math/friction-append-application-bugfix/`.
- Edit `core/append-application.sh`:
  - arg-loop: add `--by=*)` arm before `--by)` arm.
  - awk: add inline-empty match arm + `inserted` flag,
    leave multi-line arm unchanged.
- `sh core/verify.sh` returns VERIFIED.
- Append this commit's SHA to `applications[]`.
- Set `friction-append-application-as-packet/`
  `lifecycle: superseded` with `supersession` pointing here.

## Invariant

- `sh core/append-application.sh <id> HEAD --by=agent` no
  longer errors with "unknown flag".
- `sh core/append-application.sh <id> HEAD --by agent` keeps
  working.
- A fresh packet (applications: []) becomes a single-entry
  applications: block after one script call.
- No double-print in any test path.

## Test obligation

- Manual: on a temp `math/test-pkt/` packet, run with
  `--by=agent`, `--by human`, with and without `--force`,
  with inline `[]` and multi-line applications[]. Verify one
  entry per call.
- Static: `sh core/verify.sh` returns VERIFIED, packets
  count +1, errors 0.

## Runtime check

- `sh core/probe.sh` if running on a non-fresh repo (probe
  smoke-test still passes; script-correctness is a developer
  concern, not a runtime one).

