# semantic-check-as-packet — convention's semantic verifier

#convention
## Thesis

`core/verify.sh` checks *structure*: 5 files, required fields,
enum values, theory⇄packet harmony. It cannot tell whether a
packet's *claims* about behaviour hold. A packet can declare
"this FSM has a verified safety property" without that ever
being checked against the code. Phase D axis D1 closes that
gap with a second, semantic verifier.

## Antithesis

A semantic verifier must talk to external tools — TLA+
model-checker, Coq proof assistant, Alloy analyzer — which
breaks the "POSIX shell, no external dependencies" rule that
gave the convention its portability. Heavier substrates also
need a runner layer that the convention does not yet have.

## Synthesis

`core/semantic-check.sh` is a *dispatcher* in POSIX shell. It
reads a packet's `packet.yaml`, sees the declared `substrate`
and `verifier.command`, and routes to the right runner. For
Phase D axis D1 the runners per substrate are mostly stubs —
they return `UNVERIFIABLE:DEFERRED` — but the dispatch logic,
the shell substrate runner, and the verdict taxonomy are real
and testable.

The contract (in order of precedence):

1. `substrate: none` → `UNVERIFIABLE:DEFERRED` (no claim to check)
2. `substrate: shell` with `verifier.command` set → run it via
   `sh -c`; exit 0 → `VERIFIED`, non-zero → `NEEDS_REVISION`
3. `substrate: shell` with `verifier: null` → `UNVERIFIABLE:TOOL_MISSING`
4. `substrate: tla | coq | alloy | typescript | pbt | pbt-prism` →
   `UNVERIFIABLE:DEFERRED` (Phase D will add per-substrate runners)

The verifier always ends with `exit 0`. It is informational,
not a hard fail: the bundle may contain packets whose semantic
claims are deferred, and that is fine.

## What this packet commits to

- `core/semantic-check.sh` exists, is POSIX shell, takes one
  argument (a packet directory), and produces one of five
  verdict strings on stdout
- The dispatcher covers `none`, `shell`, and the six other
  substrates named in `core/packet-schema.md`
- The verdict vocabulary matches `core/theories/verdict.md`
- The packet owns its row in `core/coverage.yaml` (id D35)

## What this packet does NOT commit to

- TLA+/Coq/Alloy runners (axis D4-T/D4-C/D4-A will add them)
- Drift automation against `git log --all` (axis D6)
- Self-as-probe recursion (axis D3, sequenced after D1)
- Auto-failing the bundle on `NEEDS_REVISION` (semantic-check
  reports; humans decide)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/semantic-check-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/semantic-check-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/semantic-check-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/semantic-check-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/semantic-check-as-packet/packet.yaml)

## Decision

#convention
## Thesis
`core/verify.sh` checks *structure*: 5 files, required fields,
enum values, theory⇄packet harmony. It cannot tell whether a
packet's *claims* about behaviour hold. A packet can declare
"this FSM has a verified safety property" without that ever
being checked against the code. Phase D axis D1 closes that
gap with a second, semantic verifier.
## Antithesis
A semantic verifier must talk to external tools — TLA+
model-checker, Coq proof assistant, Alloy analyzer — which
breaks the "POSIX shell, no external dependencies" rule that
gave the convention its portability. Heavier substrates also
need a runner layer that the convention does not yet have.
## Synthesis
`core/semantic-check.sh` is a *dispatcher* in POSIX shell. It
reads a packet's `packet.yaml`, sees the declared `substrate`
and `verifier.command`, and routes to the right runner. For
Phase D axis D1 the runners per substrate are mostly stubs —
they return `UNVERIFIABLE:DEFERRED` — but the dispatch logic,
the shell substrate runner, and the verdict taxonomy are real
and testable.
The contract (in order of precedence):
1. `substrate: none` → `UNVERIFIABLE:DEFERRED` (no claim to check)
2. `substrate: shell` with `verifier.command` set → run it via
   `sh -c`; exit 0 → `VERIFIED`, non-zero → `NEEDS_REVISION`
3. `substrate: shell` with `verifier: null` → `UNVERIFIABLE:TOOL_MISSING`
4. `substrate: tla | coq | alloy | typescript | pbt | pbt-prism` →
   `UNVERIFIABLE:DEFERRED` (Phase D will add per-substrate runners)
The verifier always ends with `exit 0`. It is informational,
not a hard fail: the bundle may contain packets whose semantic
claims are deferred, and that is fine.
## What this packet commits to
- `core/semantic-check.sh` exists, is POSIX shell, takes one
  argument (a packet directory), and produces one of five
  verdict strings on stdout
- The dispatcher covers `none`, `shell`, and the six other
  substrates named in `core/packet-schema.md`
- The verdict vocabulary matches `core/theories/verdict.md`
- The packet owns its row in `core/coverage.yaml` (id D35)
## What this packet does NOT commit to
- TLA+/Coq/Alloy runners (axis D4-T/D4-C/D4-A will add them)
- Drift automation against `git log --all` (axis D6)
- Self-as-probe recursion (axis D3, sequenced after D1)

## Task

# semantic-check-as-packet — task

#convention
## Problem

`core/verify.sh` confirms structural conformance: 5 files,
enums, theory⇄packet, FSM states, epistemic markers. It does
not confirm that a packet's *semantic* claims — e.g. "this
shell script tests property X" — actually hold when the
declared tool runs. Without a semantic layer the convention
can pass structural verification while its claims are hollow.

## Desired outcome

A POSIX shell script, `core/semantic-check.sh`, that:

- takes one argument: a packet directory (`math/<name>/`)
- reads that packet's `packet.yaml`
- inspects `substrate:` and `verifier:`
- dispatches per substrate:
  - `none` → `UNVERIFIABLE:DEFERRED`
  - `shell` with `verifier.command` → run via `sh -c`, map
    exit 0 → `VERIFIED`, non-zero → `NEEDS_REVISION`
  - `shell` with `verifier: null` → `UNVERIFIABLE:TOOL_MISSING`
  - `tla | coq | alloy | typescript | pbt | pbt-prism` →
    `UNVERIFIABLE:DEFERRED`
- prints exactly one verdict line on stdout
- ends with `exit 0` (informational)

## Constraints

- POSIX shell only (`sh`, `grep`, `sed`, `awk`, `tr`)
- No external tools beyond the packet's own `verifier.command`
- Verdict vocabulary matches `core/theories/verdict.md`
- Does not modify any files
- Plays nicely alongside `core/verify.sh` (orthogonal concerns)

## Assumptions

```yaml
task_id: semantic-check-as-packet
assumptions:
  - id: A1
    statement: "POSIX shell is sufficient to dispatch per-substrate, given substrate names are an enum"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      The 9 substrate values are declared in core/packet-schema.md
      and validated by core/verify.sh. A case statement over them
      is trivial POSIX shell.
      See: packet:math-coding-birth/decision.md#what-this-packet-commits-to
      See: core/packet-schema.md#required-fields

  - id: A2
    statement: "shell substrate verifier.command maps cleanly to `sh -c` exit codes"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      POSIX sh exit codes are 0 for success, non-zero for failure.
      Two outcomes suffice: VERIFIED vs NEEDS_REVISION. Anything
      that exits non-zero is a counterexample to the packet's claim.
      See: packet:theory-verdict-as-packet/refinement.md

  - id: A3
    statement: "Other substrates (tla, coq, alloy, typescript, pbt, pbt-prism) defer to Phase D runners"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      The Phase D roadmap enumerates axes D4-T, D4-C, D4-A as
      substrate examples. Without runners, semantic-check returns
      UNVERIFIABLE:DEFERRED — informative but not blocking.
      See: packet:phase-d-roadmap-as-packet/decision.md#synthesis

  - id: A4
    statement: "semantic-check always exits 0 (informational, not a hard fail)"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      Convention discipline: verifier reports, humans decide.
      Same axiom that lets core/verify.sh report NEEDS_REVISION
      without refusing to continue.
      See: packet:theory-curry-howard-as-packet/refinement.md

  - id: A5
    statement: "The agent substrate (LLM) is not in the 9-value enum; the dispatcher ignores it implicitly"
    status: agent-inferred
    epistemology: judgment
    confidence: 0.9
    evidence: |
      agent.md models the LLM as a substrate for the convention
      itself, not as a packet substrate. The dispatcher treats
      any unrecognized substrate as DEFERRED — the same fallback
      used for stubs.
      See: core/theories/agent.md

  - id: A6
    statement: "A placeholder SHA of 40 zeros is syntactically valid for applications[]"
    status: fact
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/verify.sh regex is `sha: [0-9a-f]+`. Forty zeros match.
      The bundle commit will replace the placeholder with the
      real SHA.
      See: core/verify.sh
```

## Refinement

# Refinement: semantic-check-as-packet

#convention
## State

- A packet directory `math/<name>/`
- Its `packet.yaml` with `substrate:` and `verifier:`
- Verdict vocabulary from `core/theories/verdict.md`

## Operations

- parse the packet's `substrate` and `verifier` fields
- dispatch per substrate (case statement)
- for `shell`, optionally run `verifier.command` via `sh -c`
- print exactly one verdict line on stdout

## Mapping (substrate → verdict)

| substrate  | verifier.command | outcome |
|------------|------------------|---------|
| none       | (any)            | UNVERIFIABLE:DEFERRED |
| shell      | set              | run `sh -c <cmd>`; exit 0 → VERIFIED, else NEEDS_REVISION |
| shell      | null             | UNVERIFIABLE:TOOL_MISSING |
| tla        | (any)            | UNVERIFIABLE:DEFERRED |
| coq        | (any)            | UNVERIFIABLE:DEFERRED |
| alloy      | (any)            | UNVERIFIABLE:DEFERRED |
| typescript | (any)            | UNVERIFIABLE:DEFERRED |
| pbt        | (any)            | UNVERIFIABLE:DEFERRED |
| pbt-prism  | (any)            | UNVERIFIABLE:DEFERRED |

## Invariant preservation

- semantic-check never mutates the repo
- always `exit 0` so it can be informational alongside the
  structural verifier
- verdict vocabulary matches `core/theories/verdict.md`

## Mapping to convention axes

- **Axis D1 (semantic verification):** this packet is the
  runtime
- **Theory verdict:** every outcome is one of the 5 in
  `core/theories/verdict.md`
- **Theory agent:** the agent's trace ends with semantic-check
  output, completing the proof term

## Test obligation

- `sh core/semantic-check.sh math/semantic-check-as-packet/`
  must return `VERIFIED` (this packet declares `substrate: shell`
  with `verifier.command: sh core/semantic-check.sh ...`)
- Running against a packet with `substrate: none` returns
  `UNVERIFIABLE:DEFERRED`
- Running against a packet with `substrate: shell` and
  `verifier: null` returns `UNVERIFIABLE:TOOL_MISSING`

## Runtime check

- Convention authors run semantic-check alongside verify.sh
  before approving a packet's transition from `working` to
  `verified`
- Future: a single `core/check.sh` runs both and reports the
  union (out of scope for D1)

