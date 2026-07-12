# phase-d-development — where math-coding grows next

#convention
## What is now in place (Phase B + C)

Phase B (structural) and Phase C (harmony) shipped:

- **21 packets in math/** at this commit, 0 verifier errors, 638 checks
- **11 mathematical theories** in `core/theories/`, plus a 12th
  (`agent.md`) for the LLM substrate
- **`core/theories/` are compact LLM specs**, not duplicating tables
- **`core/coverage.yaml` is the formal bridge** between every
  decision and (where applicable) the theory it applies
- **`applications:` is required on `packet.yaml`** so each
  packet records which commits implemented it
- **`core/think-before-do.md` + `core/decision-modes.md`** are
  two new OS runtime manifests, surfaced in `agents.md`
- **4 drift checks** in `core/verify.sh`: orphan theory,
  coverage-resolve, FSM-state equality, epistemic-marker equality

The convention is recursive (axiom A4), evidence-based
(4 epistemic markers), and structurally self-verifying.

## What next (Phase D, ordered by leverage)

### D1. Semantic verifier (`core/semantic-check.sh`)

Today `core/verify.sh` checks **structure** — file existence,
enum values, depends_on graph. It does not check **claims**.

A semantic verifier reads each `decision.md:thesis` and
attempts to dispatch it to a substrate:

- if `substrate: none` → skip (no claim, no check)
- if `substrate: shell` → run `verifier:command`
- if `substrate: tla` → run the Apalache model checker
- if `substrate: coq` → run `coqc` on the proof term
- if `substrate: alloy` → run the Alloy analyser
- if `substrate: typescript` → run `tsc`
- if `substrate: pbt`/`pbt-prism` → run the property-based test

Output: a per-packet verdict appended to `verifier-output.yaml`.
The lifecycle map becomes real: `lifecycle: verified` requires
a `VERIFIED` verdict; `NEEDS_REVISION` rolls back to `working`.

### D2. Drift automation

The convention has `applications[].sha` and a list of files.
What is missing is the **comparison** against current HEAD.
`core/drift-check.sh` runs after `core/verify.sh`:

- for each packet's `applications[]` entry, compute
  `git diff <sha>..HEAD -- <files>`
- if non-empty, write a `drift` section into
  `verifier-output.yaml`
- the agent reads this section on every session and reports

The drift section does **not** auto-fail the verifier — it is
informational, surfacing spec↔code disagreements to humans.

### D3. Self-as-probe — the strongest test

A small example packet where the convention is applied to a
trivial change inside math-coding itself. The agent opens the
packet, writes the change, declares the application, and the
verifier validates the drift. This is the convention's
*end-to-end* runtime check; without it, recursive observability
is a slogan.

### D4. TLA+/Coq/Alloy example packets

Three packets — one per substrate — that demonstrate how
formal models attach to a packet:

- `math/tla-pbt-as-packet/` — a `.tla` spec of packet lifecycle
- `math/coq-proof-as-packet/` — a `.v` proof that the FSM is a
  strict partial order
- `math/alloy-model-as-packet/` — a `.als` relational structure
  showing the dependency graph

Each is opened only when a *real* use-case appears. Without a
use-case, these examples are theatre.

### D5. Obsidian interop

Add `[[wikilinks]]` in `core/theories/*.md` for the cross-references
that are currently expressed as `See: ...` lines. Tools like
Obsidian will render these as bidirectional links. This does
not change the verifier; it is a polish pass for human readers.

### D6. Per-repo protocol tuning

`math/.protocol.yaml` (or a generic name) lets each project
override the role default. A TypeScript-heavy project defaults
everyone to `developer`; a math library defaults `researcher`.
This is the convention's escape hatch for niche projects.

### D7. Convention agent — first-class reusable

Promote `math-coding` itself into a small reusable *agent*:
the `agents.md` is parameterised over role, project, and the
current task. The agent can answer questions, propose
packets, and run the verifier on a regular cadence.

### D8. Lazy checklist generation

For each packet, derive a checklist (`core/checklists/<id>.md`)
from `refinement.md:test-obligation`. The checklist is
project-local (gitignored) and tracks per-test results.
Drift into `lifecycle: working` is automatic when an item
fails.

### D9. Other-rigor levels

Currently the convention allows `rigor: temporal` and
`rigor: proof` but no examples above `light`. Phase D adds
one packet per rigor level that exhibits it concretely.

### D10. Multi-packet atomicity

Cross-packet changes (e.g., introducing a new enums value
requires updates in `packet-schema.md`, `verify.sh`, and a
test packet) are still manual. A `math/bundle-as-packet/`
introduces bundles: a single packet that owns a set of
sibling changes and migrates their lifecycles together.

## Open questions for the convention authors

- **What is a non-coding contributor?** Designers and PMs
  might not write YAML. Should `agents.md` ever offer a
  non-packet interface (e.g., a flat message board) for them?
- **What is the cost of `applications[]`?** Every commit
  appends. After 1k commits, is the YAML still parseable in
  a single `sh core/verify.sh` run?
- **When does math-coding fail?** The current verifier
  never returns UNVERIFIABLE:*. Should there be a class of
  failures the convention explicitly refuses to classify?
- **What is the meta-theory?** The convention models
  itself via Curry-Howard, FSM, LTL, modal. Is there a
  *meta* theory (e.g., category theory, type-theoretic
  semantics) that unifies the 12 theories?

## What's not in Phase D

- Web UI for the verifier (stays shell-only)
- Per-user customisation (we agree on defaults; one matrix
  is enough)
- Multi-agent protocol (the convention assumes one agent at a
  time; multiple agents is Phase E+)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-development-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-development-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-development-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-development-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-development-as-packet/packet.yaml)

## Decision

#convention
## What is now in place (Phase B + C)
Phase B (structural) and Phase C (harmony) shipped:
- **21 packets in math/** at this commit, 0 verifier errors, 638 checks
- **11 mathematical theories** in `core/theories/`, plus a 12th
  (`agent.md`) for the LLM substrate
- **`core/theories/` are compact LLM specs**, not duplicating tables
- **`core/coverage.yaml` is the formal bridge** between every
  decision and (where applicable) the theory it applies
- **`applications:` is required on `packet.yaml`** so each
  packet records which commits implemented it
- **`core/think-before-do.md` + `core/decision-modes.md`** are
  two new OS runtime manifests, surfaced in `agents.md`
- **4 drift checks** in `core/verify.sh`: orphan theory,
  coverage-resolve, FSM-state equality, epistemic-marker equality
The convention is recursive (axiom A4), evidence-based
(4 epistemic markers), and structurally self-verifying.
## What next (Phase D, ordered by leverage)
### D1. Semantic verifier (`core/semantic-check.sh`)
Today `core/verify.sh` checks **structure** — file existence,
enum values, depends_on graph. It does not check **claims**.
A semantic verifier reads each `decision.md:thesis` and
attempts to dispatch it to a substrate:
- if `substrate: none` → skip (no claim, no check)
- if `substrate: shell` → run `verifier:command`
- if `substrate: tla` → run the Apalache model checker
- if `substrate: coq` → run `coqc` on the proof term
- if `substrate: alloy` → run the Alloy analyser
- if `substrate: typescript` → run `tsc`
- if `substrate: pbt`/`pbt-prism` → run the property-based test
Output: a per-packet verdict appended to `verifier-output.yaml`.
The lifecycle map becomes real: `lifecycle: verified` requires
a `VERIFIED` verdict; `NEEDS_REVISION` rolls back to `working`.
### D2. Drift automation
The convention has `applications[].sha` and a list of files.
What is missing is the **comparison** against current HEAD.
`core/drift-check.sh` runs after `core/verify.sh`:
- for each packet's `applications[]` entry, compute
  `git diff <sha>..HEAD -- <files>`
- if non-empty, write a `drift` section into
  `verifier-output.yaml`
- the agent reads this section on every session and reports
The drift section does **not** auto-fail the verifier — it is
informational, surfacing spec↔code disagreements to humans.
### D3. Self-as-probe — the strongest test
A small example packet where the convention is applied to a
trivial change inside math-coding itself. The agent opens the
packet, writes the change, declares the application, and the
verifier validates the drift. This is the convention's
*end-to-end* runtime check; without it, recursive observability
is a slogan.
### D4. TLA+/Coq/Alloy example packets
Three packets — one per substrate — that demonstrate how
formal models attach to a packet:
- `math/tla-pbt-as-packet/` — a `.tla` spec of packet lifecycle
- `math/coq-proof-as-packet/` — a `.v` proof that the FSM is a
  strict partial order
- `math/alloy-model-as-packet/` — a `.als` relational structure
  showing the dependency graph
Each is opened only when a *real* use-case appears. Without a
use-case, these examples are theatre.
### D5. Obsidian interop
Add `[[wikilinks]]` in `core/theories/*.md` for the cross-references
that are currently expressed as `See: ...` lines. Tools like
Obsidian will render these as bidirectional links. This does
not change the verifier; it is a polish pass for human readers.
### D6. Per-repo protocol tuning
`math/.protocol.yaml` (or a generic name) lets each project
override the role default. A TypeScript-heavy project defaults
everyone to `developer`; a math library defaults `researcher`.
This is the convention's escape hatch for niche projects.
### D7. Convention agent — first-class reusable
Promote `math-coding` itself into a small reusable *agent*:
the `agents.md` is parameterised over role, project, and the
current task. The agent can answer questions, propose
packets, and run the verifier on a regular cadence.
### D8. Lazy checklist generation
For each packet, derive a checklist (`core/checklists/<id>.md`)
from `refinement.md:test-obligation`. The checklist is
project-local (gitignored) and tracks per-test results.
Drift into `lifecycle: working` is automatic when an item
fails.
### D9. Other-rigor levels
Currently the convention allows `rigor: temporal` and
`rigor: proof` but no examples above `light`. Phase D adds
one packet per rigor level that exhibits it concretely.
### D10. Multi-packet atomicity
Cross-packet changes (e.g., introducing a new enums value
requires updates in `packet-schema.md`, `verify.sh`, and a
test packet) are still manual. A `math/bundle-as-packet/`
introduces bundles: a single packet that owns a set of
sibling changes and migrates their lifecycles together.
## Open questions for the convention authors
- **What is a non-coding contributor?** Designers and PMs
  might not write YAML. Should `agents.md` ever offer a
  non-packet interface (e.g., a flat message board) for them?
- **What is the cost of `applications[]`?** Every commit
  appends. After 1k commits, is the YAML still parseable in
  a single `sh core/verify.sh` run?
- **When does math-coding fail?** The current verifier
  never returns UNVERIFIABLE:*. Should there be a class of
  failures the convention explicitly refuses to classify?
- **What is the meta-theory?** The convention models
  itself via Curry-Howard, FSM, LTL, modal. Is there a
  *meta* theory (e.g., category theory, type-theoretic
  semantics) that unifies the 12 theories?
## What's not in Phase D
- Web UI for the verifier (stays shell-only)
- Per-user customisation (we agree on defaults; one matrix
  is enough)

## Task

# phase-d-development — task

#convention
## Problem

Phase C closed structural harmony but left a narrative gap:
the user asked "describe further development of math-coding in
this repo". The roadmap packet records *what* to do, but the
narrative *why* (each axis's motivation, ordering, and risks)
belongs in this packet so future readers can pick up the
context that was implicit in this conversation.

## Desired outcome

A single packet (`phase-d-development-as-packet`) narrating:

1. what the convention has now (Phase B+C recap)
2. the 10 Phase D axes in order of leverage
3. open questions for convention authors
4. the explicitly non-Phase D list

## Constraints

- `lifecycle: working` not `verified`: this packet is itself
  Phase D prep, not a verified artifact
- `rigor: light`: this is narrative, not a verifiable claim
- Sub-100 lines of decision.md for readability
- No new theory files (they live in their own packets)

## Assumptions

```yaml
task_id: phase-d-development
assumptions:
  - id: A1
    statement: "Phase D axes are ordered by leverage: semantic verification first because it makes axiom A4 (recursive observability) concrete"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Recursive observability is the convention's load-bearing
      claim. Without a semantic verifier, it is a slogan.
      Adding one turns the claim into a runtime check.
      See: packet:math-coding-birth/refinement.md#9

  - id: A2
    statement: "TLA+/Coq/Alloy example packets should open only when a real use-case appears"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Empty formal examples attract attention without solving
      a problem. Phase D prep records the *protocol* for
      opening them but defers the actual packets.
      See: math/phase-d-roadmap-as-packet/decision.md

  - id: A3
    statement: "Self-as-probe (D3) is the highest-leverage once D1 (semantic verifier) exists"
    status: judgment
    epistemology: judgment
    evidence: |
      A self-as-probe without a semantic verifier is
      structural testing only. With one, it becomes the
      full recursive-observability claim.
      See: packet:phase-d-roadmap-as-packet/decision.md

  - id: A4
    statement: "Obsidian interop (D5) is polish, not leverage; should ship after the keystone axes"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Wikilinks improve human reading but don't change the
      verifier. They are a Phase D+ polish pass, not keystone.
      See: packet:phase-d-roadmap-as-packet/refinement.md

  - id: A5
    statement: "The convention should *fail explicitly* when it cannot classify"
    status: agent-inferred
    epistemology: hypothesis
    confidence: 0.7
    evidence: |
      UNVERIFIABLE:* outcomes exist in the verdict theory.
      The current verifier always picks VERIFIED or
      NEEDS_REVISION. The 'fail explicitly' pattern is
      orthogonal but may emerge from the semantic verifier.
      See: packet:theory-verdict-as-packet/refinement.md
```

## Refinement

# Refinement: phase-d-development

#convention
## State

- **pre**: roadmap packet exists in
  `math/phase-d-roadmap-as-packet/` as an ordered list of
  triggers ("until…") for each Phase D axis.
- **post**: this packet supplies the narrative for each axis
  — motivation, ordering, risks — in one readable document.

## Operation

- Created `math/phase-d-development-as-packet/` with 5 files
  (this packet)
- Linked to `phase-d-roadmap-as-packet` and
  `agent-as-packet` as dependencies (this packet reads both)

## Mapping

| Spec (this packet)       | Impl (artifact)                              |
|--------------------------|----------------------------------------------|
| Phase D narrative        | `math/phase-d-development-as-packet/`        |
| Phase D triggers list    | `math/phase-d-roadmap-as-packet/decision.md` |
| Agent-as-runtime theory  | `core/theories/agent.md`                     |

## Invariant preservation

- 23 packets still pass `core/verify.sh`
- No changes to `AGENTS.md`, `core/verify.sh`, or
  `core/coverage.yaml`
- This packet uses `substrate: none` (no formal example yet)

## Test obligation

- `sh core/verify.sh` returns VERIFIED
- This packet has 5 files (matching convention)
- `applications[]` declares the Phase D prep commit

## Runtime check

- A convention author reads this packet, then
  `phase-d-roadmap-as-packet`, and decides which axis to
  open next.

## Cross-reference

Pairs with `phase-d-roadmap-as-packet` (triggers list).
This packet has the narrative; that packet has the structure.

