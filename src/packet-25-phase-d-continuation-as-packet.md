# phase-d-continuation — Phase D axes D3, D7, D8, D9

#convention
## Thesis

Phase D fan-out (d311ac7) shipped D1, D2, D4-TLA/Coq/Alloy,
D5 wikilinks, D6 protocol-tuning in parallel. Three axes
remained pending:

- **D3 self-as-probe** — make axiom A4 executable
- **D7 convention-agent first-class** — the agent as the
  convention's runtime
- **D8 lazy checklists** — auto-generated progress tracking
- **D9 other-rigor example** — extend the envelope beyond
  rigor: light

These are independent in implementation but share the same
goal: turn recursive observability from slogan into runtime.

## Antithesis

Each axis risks being *demonstration only*. A self-probe
that always passes is theatre; an agent that runs without
showing its reasoning is a black box; a checklist nobody
fills is noise; a rigor: temporal packet that doesn't
demonstrate temporal reasoning is decoration. Each must
admit a real failure mode.

## Synthesis

Order (highest leverage first):

1. **D3 self-as-probe** — `core/probe.sh` already exists in
   the working tree; ship it. Clean up drift in
   `applications[]` (placeholder 0...0 SHA, stale SHAs from
   Phase C commits).
2. **D7 convention-agent first-class** — reify the agent as a
   runnable script: `core/agent.sh` that takes role + mode
   and produces a per-session manifest.
3. **D8 lazy checklists** — `core/generate-checklist.sh`
   reads each `refinement.md:test-obligation` and writes
   `core/checklists/<packet>.md`.
4. **D9 other-rigor example** — open
   `math/rigor-temporal-example-as-packet/` showing a packet
   at `rigor: temporal` with a real temporal argument.

## What this packet commits to

- The continuation order is the canonical sequence
- Each axis ships in its own packet (no nested work)
- After the four axes, the verifier should remain 0 errors
  and `core/probe.sh` should return VERIFIED

## What this packet does NOT commit to

- TLA/Coq/Alloy examples being runnable — those remain
  read-ready, per the per-axis packets
- Drift-check being non-informational (it stays advisory)
- Auto-recovery from a failed probe (humans/agents decide)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-continuation-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-continuation-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-continuation-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-continuation-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-continuation-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Phase D fan-out (d311ac7) shipped D1, D2, D4-TLA/Coq/Alloy,
D5 wikilinks, D6 protocol-tuning in parallel. Three axes
remained pending:
- **D3 self-as-probe** — make axiom A4 executable
- **D7 convention-agent first-class** — the agent as the
  convention's runtime
- **D8 lazy checklists** — auto-generated progress tracking
- **D9 other-rigor example** — extend the envelope beyond
  rigor: light
These are independent in implementation but share the same
goal: turn recursive observability from slogan into runtime.
## Antithesis
Each axis risks being *demonstration only*. A self-probe
that always passes is theatre; an agent that runs without
showing its reasoning is a black box; a checklist nobody
fills is noise; a rigor: temporal packet that doesn't
demonstrate temporal reasoning is decoration. Each must
admit a real failure mode.
## Synthesis
Order (highest leverage first):
1. **D3 self-as-probe** — `core/probe.sh` already exists in
   the working tree; ship it. Clean up drift in
   `applications[]` (placeholder 0...0 SHA, stale SHAs from
   Phase C commits).
2. **D7 convention-agent first-class** — reify the agent as a
   runnable script: `core/agent.sh` that takes role + mode
   and produces a per-session manifest.
3. **D8 lazy checklists** — `core/generate-checklist.sh`
   reads each `refinement.md:test-obligation` and writes
   `core/checklists/<packet>.md`.
4. **D9 other-rigor example** — open
   `math/rigor-temporal-example-as-packet/` showing a packet
   at `rigor: temporal` with a real temporal argument.
## What this packet commits to
- The continuation order is the canonical sequence
- Each axis ships in its own packet (no nested work)
- After the four axes, the verifier should remain 0 errors
  and `core/probe.sh` should return VERIFIED
## What this packet does NOT commit to
- TLA/Coq/Alloy examples being runnable — those remain
  read-ready, per the per-axis packets

## Task

# phase-d-continuation — task

#convention
## Problem

After Phase D fan-out (d311ac7) and the user-driven
"продолжай" command, four Phase D axes remain. They should
ship in canonical order.

## Desired outcome

- `core/probe.sh` runs all three verifiers (verify, semantic,
  drift) and writes a unified probe-report.
- `applications[]` SHA cleanup: replace placeholder 0...0
  with real SHAs; verify which existing applications show
  real drift vs false positive.
- D7 axis: `core/agent.sh` (or equivalent) executes the
  role-defaulted, mode-overridable agent-loop.
- D8 axis: `core/generate-checklist.sh` produces per-packet
  checklists under `core/checklists/`.
- D9 axis: a packet at `rigor: temporal` with real temporal
  content (FSM + LTL lifecycle cross-check).
- `sh core/verify.sh` returns VERIFIED, 0 errors after each
  axis lands.

## Constraints

- POSIX shell only
- Each axis opens its own packet, no nesting
- No web UI (web-ui-as-packet remains sketch)
- No silent failures — every script either passes or reports
  exit code

## Assumptions

```yaml
task_id: phase-d-continuation
assumptions:
  - id: A1
    statement: "D3 self-as-probe is the keystone: without an executable probe, axiom A4 remains aspirational"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Axiom A4 says convention verifies itself.
      core/probe.sh runs verify + semantic + drift; this
      turns axiom A4 from claim into subroutine.
      See: math-coding-birth/refinement.md#9-recursive

  - id: A2
    statement: "applications[] SHAs should be real SHAs, not placeholders; placeholders are syntactic but report false drift"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      core/drift-check.sh reports any non-empty diff for
      a placeholder sha, which is always non-empty diff
      vs current HEAD. Replacing 0...0 with real SHA makes
      drift-check trustworthy again.
      See: core/drift-check.sh

  - id: A3
    statement: "D7 (convention-agent first-class) is D3+1: the probe executes, the agent orchestrates"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      D3 says what the convention runs at commit time. D7
      says who runs the convention between commits. The
      agent loop reads history, proposes work, dispatches
      subagents, and records applications[].
      See: math/agent-as-packet/refinement.md

  - id: A4
    statement: "D8 lazy checklists are practical: a 5-section refinement.md has a Test obligation section that maps to a checklist"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Every refinement.md ends with a 'Test obligation'
      section. Generating a checklist from it is mechanical
      and useful for humans tracking per-packet work.
      See: math/theory-refinement-as-packet/refinement.md

  - id: A5
    statement: "D9 (rigor: temporal example) is illustrative; it cross-references FSM and LTL theories and shows temporal reasoning in a packet body"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Current packets are mostly rigor: light (decision
      packets) or rigor: property (theory packets). A
      rigor: temporal example demonstrates the third level
      through FSM-state + LTL-property cross-checks.
      See: core/coverage.yaml#D7
```

## Refinement

# Refinement: phase-d-continuation

#convention
## State

- **pre**: 32 packets pass `core/verify.sh`; the user-asked
  "продолжай" requires a canonical continuation.
- **post**: 4 more axes ship (D3, D7, D8, D9); the bundle
  commit preserves all invariants.

## Operation

- Created `math/phase-d-continuation-as-packet/` with 5 files
- Continued work in this order:
  D3 → applications[] cleanup → D7 → D8 → D9

## Mapping (axes → deliverables in this commit)

| Axis | Artifact                              |
|------|----------------------------------------|
| D3   | core/probe.sh (already in working tree) |
| D3'  | applications[] SHA cleanup              |
| D7   | core/agent.sh + math/convention-agent-as-packet/ |
| D8   | core/generate-checklist.sh + math/checklists-as-packet/ |
| D9   | math/rigor-temporal-example-as-packet/ |

## Invariant preservation

- `sh core/verify.sh` returns VERIFIED after each axis
- `AGENTS.md` ≤ 60 lines (none of these axes touch it)
- No new external dependencies

## Test obligation

- `sh core/probe.sh` runs all three verifiers
- `core/drift-check.sh` reports 0 stale applications after
  SHA cleanup
- Each new packet has 5 files matching convention

## Runtime check

- `sh core/generate-checklist.sh` writes one checklist per
  packet under `core/checklists/`
- `sh core/agent.sh --role researcher --mode standard`
  prints a session manifest

## Cross-reference

Pairs with `phase-d-fanout-as-packet` and `phase-d-roadmap-as-packet`.
Continues the canonical Phase D order.

