# drift-check-as-packet — automate applications[] drift detection

#convention
## Thesis

Phase C added `applications[]` to packet.yaml so that
edits, once shipped, leave a paper trail: which commit
applied the packet to which file. The trail's value is
only as good as our discipline in reading it. Today the
only check is manual `git diff <sha>..HEAD -- <files>`.
That does not scale: 25 packets × N applications each.

## Antithesis

Drift detection sounds like a job for CI. But CI is a
separate dependency the convention deliberately avoids
("plain text + git, no external tools beyond POSIX sh").
A POSIX shell script that calls `git diff` is the
convention-native answer: same tool we already trust.

A second objection: drift is informational; an automated
"rebuild" script that mutates files would be wrong.
Drift must be reported, never silently fixed. This keeps
human judgement in the loop, as the verifier already does.

## Synthesis

`core/drift-check.sh` walks `math/*/packet.yaml`, parses
the `applications[]` block, and for each non-zero SHA
runs `git diff --quiet <sha>..HEAD -- <files>`. A non-empty
diff → "DRIFT: <packet-id> application <sha> stale in <file>"
on stderr, with a summary line at the end. Exit code is
always 0: drift is informational, not a verdict.

Empty applications (`applications: []`) is valid and
yields no drift — the convention does not require every
packet to ship work.

This packet authorizes `core/drift-check.sh` as
convention OS. It pairs with D28 (think-before-do) and
D29 (applications: required): drift-check operationalises
the field that D29 made mandatory.

## What this packet commits to

- `core/drift-check.sh` exists, POSIX-only, no external
  dependencies beyond `git`
- It reports stale applications[] on stderr; exits 0
- Empty `applications: []` is silent (correct — no work
  has been recorded yet)
- Zero-SHA placeholder entries are skipped, not flagged
  (they mark work-in-progress, not drift)

## What this packet does NOT commit to

- Automatic fixes (drift is reported, never auto-resolved)
- A CI hook (deferred; core/drift-check.sh is run on
  demand by convention authors)
- Mutation of any file (strictly read-only)
- Multi-repo or remote-SHA support (local repo only)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/drift-check-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/drift-check-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/drift-check-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/drift-check-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/drift-check-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Phase C added `applications[]` to packet.yaml so that
edits, once shipped, leave a paper trail: which commit
applied the packet to which file. The trail's value is
only as good as our discipline in reading it. Today the
only check is manual `git diff <sha>..HEAD -- <files>`.
That does not scale: 25 packets × N applications each.
## Antithesis
Drift detection sounds like a job for CI. But CI is a
separate dependency the convention deliberately avoids
("plain text + git, no external tools beyond POSIX sh").
A POSIX shell script that calls `git diff` is the
convention-native answer: same tool we already trust.
A second objection: drift is informational; an automated
"rebuild" script that mutates files would be wrong.
Drift must be reported, never silently fixed. This keeps
human judgement in the loop, as the verifier already does.
## Synthesis
`core/drift-check.sh` walks `math/*/packet.yaml`, parses
the `applications[]` block, and for each non-zero SHA
runs `git diff --quiet <sha>..HEAD -- <files>`. A non-empty
diff → "DRIFT: <packet-id> application <sha> stale in <file>"
on stderr, with a summary line at the end. Exit code is
always 0: drift is informational, not a verdict.
Empty applications (`applications: []`) is valid and
yields no drift — the convention does not require every
packet to ship work.
This packet authorizes `core/drift-check.sh` as
convention OS. It pairs with D28 (think-before-do) and
D29 (applications: required): drift-check operationalises
the field that D29 made mandatory.
## What this packet commits to
- `core/drift-check.sh` exists, POSIX-only, no external
  dependencies beyond `git`
- It reports stale applications[] on stderr; exits 0
- Empty `applications: []` is silent (correct — no work
  has been recorded yet)
- Zero-SHA placeholder entries are skipped, not flagged
  (they mark work-in-progress, not drift)
## What this packet does NOT commit to
- Automatic fixes (drift is reported, never auto-resolved)
- A CI hook (deferred; core/drift-check.sh is run on
  demand by convention authors)

## Task

# drift-check-as-packet — task

#convention
## Problem

`packet.yaml:applications[]` records the SHA at which a
packet was applied to a set of files. Over time the files
change, but the SHA does not. The convention has no
mechanical way to ask "which applications are stale?".

The only currently available check is manual:
`git diff <sha>..HEAD -- <files>`. Repeated by every
convention author on every commit, it does not scale past
a handful of applications.

## Desired outcome

A POSIX shell script that:

- walks every `math/*/packet.yaml`
- parses the `applications[]` block (block-based, not
  line-based — to match `core/verify.sh`)
- for each entry with a non-zero SHA, runs
  `git diff --quiet <sha>..HEAD -- <files>`
- prints `DRIFT: <packet> application <sha> stale in <file>`
  on stderr for each file that has changed since the SHA
- prints a summary line:
  `drift detected: <N> applications stale`
- exits 0 always (informational, not a verdict)

Constraints:

- POSIX shell only (`sh`, `awk`, `grep`, `sed`, `git`)
- No Python, no Node, no external tools
- Read-only: never modifies any file
- Empty `applications: []` and zero-SHA placeholders are
  silently skipped
- The script lives at `core/drift-check.sh`; this packet
  is the convention-Owner that authorizes it

## Constraints

- shell substrate (matches convention's "plain text + git")
- rigor: light (drift is reported, not proven)
- decision: made (matches the existence of `core/drift-check.sh`)
- depends_on: think-before-do-as-packet (applications[]
  exists because of it), recursive-check-as-packet
  (verifier-output style)

## Assumptions

```yaml
task_id: drift-check-as-packet
assumptions:
  - id: A1
    statement: "`applications[]` SHAs point at commits in this repo's git history"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      The convention uses local git as the only external
      tool. applications[] SHAs are short or full git
      commit hashes; core/drift-check.sh runs `git diff`
      against HEAD in the current repo.
      See: packet:core/packet-schema.md#applications-drift-tracking

  - id: A2
    statement: "Zero-SHA placeholder entries are skipped, not flagged as drift"
    status: agent-inferred
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Several packets in this repo use sha:
      0000000000000000000000000000000000000000 as a
      placeholder that gets resolved at bundle-commit
      time. Flagging it as drift before the bundle commit
      would be a false positive.
      See: packet:math/phase-c-harmony-as-packet/refinement.md

  - id: A3
    statement: "Empty applications: [] is silent (no drift reported)"
    status: fact
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/verify.sh already treats `applications: []`
      as the explicit no-work-recorded case. drift-check
      inherits this convention.
      See: packet:core/verify.sh#applications-structure

  - id: A4
    statement: "drift-check reports but never fixes"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Same discipline as core/verify.sh: a convention
      verifier is informational. Auto-fixing applications
      (e.g. rewriting the SHA to HEAD) would silently
      lie about when a packet was applied.
      See: packet:math/verifier-as-packet/decision.md#what-this-packet-does-not-commit-to

  - id: A5
    statement: "applications[] block parsing matches core/verify.sh semantics"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      core/verify.sh already implements a block-aware
      awk script for applications[]. drift-check uses
      the same approach to stay consistent.
      See: packet:core/verify.sh#applications-structure

  - id: A6
    statement: "Exit code is always 0 even when drift is reported"
    status: agent-inferred
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Drift is informational, not a verdict. A non-zero
      exit would break post-commit hooks and other
      tooling that wires drift-check in. Verdict
      discipline belongs to core/verify.sh.
      See: packet:core/verify.sh#returns
```

## Refinement

# Refinement: drift-check-as-packet

#convention
## State

- Repository at current `HEAD`
- `S` = set of all packets `math/*/`
- For each packet `p`:
  - `applications[p]` = list of `{sha, by, files[]}` from
    `packet.yaml`
- `drift(p, app)` = "yes" iff `sha` is non-zero AND
  `git diff --quiet <sha>..HEAD -- <files>` exits non-zero
  for any file in `files[]`

## Operations

- find all `math/*/packet.yaml`
- for each packet, parse the `applications[]` block
  (block-aware: opener plus indented children, same
  semantics as `core/verify.sh`)
- for each entry with non-zero SHA, for each file in
  `files[]`, run `git diff --quiet <sha>..HEAD -- <file>`
- on non-empty diff, emit:
  `DRIFT: <packet> application <sha> stale in <file>`
  to stderr
- after all packets walked, emit summary to stderr:
  `drift detected: <N> applications stale`
- always exit 0

## Invariant preservation

- I₀ — the script never modifies any file (read-only)
- I₁ — empty `applications: []` ⇒ zero drift lines
  emitted
- I₂ — zero-SHA placeholder ⇒ skipped (not flagged)
- I₃ — exit code is 0 regardless of how much drift
  is reported

## Mapping to convention axes

- **Axis 6 (Coverage / self-knowledge):** drift-check
  reports which applications[] entries are stale,
  feeding the convention's self-knowledge of its own
  history.
- **Axis 8 (Drift automation):** this packet IS axis
  D2 of Phase D. It operationalises D28 (think-before-do)
  and D29 (applications: required).
- **Axis 4 (Verdicts):** drift is not a verdict.
  Verdict discipline belongs to core/verify.sh.
  drift-check is informational, by design.

## Test obligation

- `sh core/drift-check.sh` runs to completion with exit 0
- on a repo where every recorded SHA matches HEAD for its
  declared files: zero `DRIFT:` lines
- on a repo where one file has moved since the recorded
  SHA: exactly one `DRIFT:` line plus the summary line
- on a packet with `applications: []`: zero drift lines
- on a packet whose `applications[0].sha` is `000...0`:
  the entry is skipped (no `DRIFT:` line)

## Runtime check

- run on demand: `sh core/drift-check.sh`
- future: hook to `core/verify.sh` output or to a
  pre-commit hook — out of scope for this packet
- output is two channels:
  - stderr: drift report and summary (the signal)
  - stdout: empty by design (signal stays out of pipes)

