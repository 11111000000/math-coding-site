# phase-d-roadmap — describe further development of math-coding

#convention
## Thesis

Phase C closes structural harmony: theory⇄packet is enforced,
applications drift is auditable, modes × roles cover non-developer
intents. Now the convention needs *semantic* claims — a packet's
assertions should be checked against reality, not just structurally
shaped. Phase D lists the open expansions, ordered by leverage.

## Antithesis

Open every Phase D axis at once and the convention bloats. Drift
detection grows heavier than the convention itself; TLA+/Coq
substrates attract users who never reach for them; Obsidian-style
wikilinks add reader overhead without changing verifiability.
Each axis must justify itself before adoption.

## Synthesis

Phase D proposes 8 axes, each with an "until we adopt this" trigger:

1. **Semantic verification** — Phase D core: a `core/semantic-check.sh`
   reads `decision.md` claims, dispatches to a substrate, and produces
   VERIFIED / NEEDS_REVISION / UNVERIFIABLE:*.
2. **TLA+ substrate example** — one packet with a `.tla` spec
   demonstrating how state-machine properties are checked.
3. **Coq substrate example** — one packet with a `.v` file
   demonstrating proof-term-backed assumptions.
4. **Alloy substrate example** — one packet with a `.als` file
   demonstrating relational structural models.
5. **Role detection** — agents ask one question at the start of a
   session; the answer pins the role for the rest of the session.
6. **Drift automation** — `applications[]` SHA resolved against
   `git log --all`; the verifier reports drift but does not auto-fail.
7. **Obsidian interop** — `[[wikilinks]]` for `core/theories/*.md`
   paths so Obsidian-rendered links point back to the convention.
8. **Math-coding itself as a probe** — test the agent protocol by
   running it on itself: the agent performs a small change, the
   convention records the application, the verifier validates the
   drift.

## What this packet commits to

- An *ordered* list of Phase D axes with triggers.
- A new theory `core/theories/agent.md` modelling the LLM as a
  substrate (Phase D axis 0 — needed before any TLA/Coq axis
  makes sense).
- A new role-detection protocol in `core/decision-modes.md`
  extension (Phase D axis 5).

## What this packet does NOT commit to

- Adopting TLA+/Coq/Alloy packages (each is a future packet).
- Auto-fail on drift (we only report it).
- Changing Phase C invariants or the 60-line `agents.md` cap.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-roadmap-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-roadmap-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-roadmap-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/phase-d-roadmap-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-d-roadmap-as-packet/packet.yaml)

## Decision

#convention
## Thesis
Phase C closes structural harmony: theory⇄packet is enforced,
applications drift is auditable, modes × roles cover non-developer
intents. Now the convention needs *semantic* claims — a packet's
assertions should be checked against reality, not just structurally
shaped. Phase D lists the open expansions, ordered by leverage.
## Antithesis
Open every Phase D axis at once and the convention bloats. Drift
detection grows heavier than the convention itself; TLA+/Coq
substrates attract users who never reach for them; Obsidian-style
wikilinks add reader overhead without changing verifiability.
Each axis must justify itself before adoption.
## Synthesis
Phase D proposes 8 axes, each with an "until we adopt this" trigger:
1. **Semantic verification** — Phase D core: a `core/semantic-check.sh`
   reads `decision.md` claims, dispatches to a substrate, and produces
   VERIFIED / NEEDS_REVISION / UNVERIFIABLE:*.
2. **TLA+ substrate example** — one packet with a `.tla` spec
   demonstrating how state-machine properties are checked.
3. **Coq substrate example** — one packet with a `.v` file
   demonstrating proof-term-backed assumptions.
4. **Alloy substrate example** — one packet with a `.als` file
   demonstrating relational structural models.
5. **Role detection** — agents ask one question at the start of a
   session; the answer pins the role for the rest of the session.
6. **Drift automation** — `applications[]` SHA resolved against
   `git log --all`; the verifier reports drift but does not auto-fail.
7. **Obsidian interop** — `[[wikilinks]]` for `core/theories/*.md`
   paths so Obsidian-rendered links point back to the convention.
8. **Math-coding itself as a probe** — test the agent protocol by
   running it on itself: the agent performs a small change, the
   convention records the application, the verifier validates the
   drift.
## What this packet commits to
- An *ordered* list of Phase D axes with triggers.
- A new theory `core/theories/agent.md` modelling the LLM as a
  substrate (Phase D axis 0 — needed before any TLA/Coq axis
  makes sense).
- A new role-detection protocol in `core/decision-modes.md`
  extension (Phase D axis 5).
## What this packet does NOT commit to
- Adopting TLA+/Coq/Alloy packages (each is a future packet).

## Task

# phase-d-roadmap — task

#convention
## Problem

math-coding v0.618 Phase C makes the convention structurally
self-consistent. The 8 axes below are the next frontier; each
requires a separate decision-packet when its time comes, but a
single roadmap packet records their ordering so the convention
authors can plan.

## Desired outcome

A roadmap of 8 Phase D axes in `phase-d-roadmap-as-packet`,
each axis with a trigger ("until") and a verification shape.
Two short additions ship in this commit:

1. `core/theories/agent.md` — the agent as a runtime
   (predicates over chat history, decisions as actions).
2. `math/fast-track-as-packet` extended with a role-detection
   protocol so the role default becomes one question, not a
   long negotiation.

## Constraints

- This packet itself uses `lifecycle: sketch` until at least
  one Phase D axis is implemented (it is a roadmap, not a
  finished decision).
- No new substrate examples in this commit; they each become
  their own packet when triggered.
- `core/verify.sh` must remain 0 errors after the additions.

## Assumptions

```yaml
task_id: phase-d-roadmap-as-packet
assumptions:
  - id: A1
    statement: "An ordered roadmap is preferable to an unordered backlog: the convention's authors need to know which Phase D axis is next"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Without ordering, contributors pick the highest-glory
      axis first (TLA+/Coq) and skip the highest-leverage one
      (semantic verification). Ordering by "until" triggers
      solves this.
      See: packet:phase-c-harmony-as-packet/refinement.md

  - id: A2
    statement: "The LLM is itself a substrate and deserves a theory file under core/theories/agent.md"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Phase C established that text = code for an LLM
      interpreter. The agent's read/write actions form a
      state machine that the convention should model
      explicitly. TLA+/Coq examples need this substrate
      first.
      See: core/think-before-do.md

  - id: A3
    statement: "Role detection via one declarative question is honest and nenaвязчиво"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Asking auto-detection buries intent; asking every
      request is ceremony; asking once per session is
      aligned with the convention's epistemic markers.
      See: packet:fast-track-as-packet/refinement.md

  - id: A4
    statement: "Phase D axis order: agent-theory (0), semantic-check (1), TLA+ (2), Coq (3), Alloy (4), role-detection (5), drift automation (6), Obsidian interop (7), self-as-probe (8)"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Logical dependencies: any formal substrate example
      requires an explicit agent theory first; semantic
      verification is the keystone of the convention's
      recursive-observability claim (axiom A4).
      See: packet:math-coding-birth/refinement.md#9

  - id: A5
    statement: "Math-coding-on-itself probe (Phase D axis 8) is the strongest evidence that the convention works as a 'мыслительный экзоскелет'"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      The user said math-coding should be 'an example of
      how to develop with agents, syncing code and specs'.
      Applying math-coding to itself — agents writing packets
      about math-coding while math-coding verifies them —
      validates the claim.
      See: packet:phase-c-harmony-as-packet/decision.md
```

## Refinement

# Refinement: phase-d-roadmap

#convention
## State

- **pre**: convention has structural harmony (Phase C) and a
  60-line runtime protocol.
- **post**: a roadmap packet records 8 Phase D axes with
  ordering; `core/theories/agent.md` introduces the agent as
  a substrate; `fast-track-as-packet` extends with a
  one-question role detector.

## Operation

- Add `core/theories/agent.md` (compact, math-coding-instance
  style consistent with the 11 existing theories)
- Add an `agent-as-packet` reference in `core/coverage.yaml`
  (D32) and as a depends_on in `fast-track-as-packet`
- Extend `core/decision-modes.md` with a "Role declaration"
  line: `# role: <role>`

## Mapping (Phase D axes → first deliverables in this commit)

| Axis                              | This commit                              |
|-----------------------------------|------------------------------------------|
| 1. Agent theory (axis 0)          | `core/theories/agent.md` (new)          |
| 5. Role detection                 | `core/decision-modes.md` extended        |
| 8. Self-as-probe (axis 8)         | this commit applies the convention to itself |

Other axes are documented in `decision.md` and remain to be
opened as separate packets.

## Invariant preservation

- 60-line `AGENTS.md` cap unaffected (this commit only changes
  `core/decision-modes.md`, not `AGENTS.md`)
- All 22 packets pass `core/verify.sh`
- `applications[]` continues to default to `[]` for new
  packets; this packet authorises its own roadmap without
  listing applications yet (it is `lifecycle: sketch`)

## Test obligation

- `sh core/verify.sh` returns 0 errors after the additions
- `core/theories/agent.md` is a valid theory spec (it does
  not have a packet yet — flagged as orphan until
  `agent-as-packet` is opened)

## Runtime check

- Phase D axes trigger when their "until" condition is met.
  Until then they remain as paragraphs in
  `phase-d-roadmap-as-packet/decision.md`.

## Cross-reference

Canonical spec: this packet's `decision.md`. The trigger
phrases are the ordered list of Phase D axes. No theory file
governs the roadmap itself — it is meta-convention.

