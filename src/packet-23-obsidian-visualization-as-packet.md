# obsidian-visualization — Phase D+ strategy (sketch)

#convention
## Thesis

math-coding v0.618 ships 38 packets and 12 theories in
plain text + git + POSIX shell. Three evolution axes remain
deferred from Phase D, all addressing the same need: **make
the convention easier to enter, navigate, and grow**:

1. **Obsidian interop** — open the repo as an Obsidian vault
   without setup; navigation via `[[wikilinks]]` and Map of
   Content files
2. **Visualization** — embed Mermaid diagrams in core/theories/
   so the FSM, LTL, DAG, and supersession become inline
   diagrams Obsidian renders natively
3. **Friction reduction** — collapse the "5 files per
   packet" interaction model into **1 LLM-вызов + 1 tool-call**,
   keeping the 5-file convention internally

These three are independent in implementation but share a
trigger: a non-developer role (PM, designer, researcher, tech-
writer) actively adopting the convention.

## Antithesis

Three threads × "ship now" = premature commitments. The
convention has lived through Phase B → C → D with only
plain text + shell. Each new artifact risks:

- MOC files that nobody opens (dead navigation)
- Mermaid diagrams that become stale (rendered-evidence drift)
- A packet-filler that introduces LLM-inconsistent 5-file
  outputs (round-trip drift)

Convention accumulates a cost for every "we might need this"
artifact. Until trigger conditions are met, these cost more
than they save.

## Synthesis

This packet documents the strategy as a sketch (lifecycle:
sketch, decision: needed). Four deliverables are listed with
explicit **trigger conditions** — each becomes its own packet
when (and only when) a real adopter requires it.

### Deliverable 1: MOC README.md files

Three Map-of-Content files (additive only):

- `core/README.md` — root MOC with sections: Conventions,
  Theories, Tools, Packets
- `math/README.md` — 38-row packet catalog grouped by
  lifecycle and substrate, with wikilinks to each packet's
  `decision.md`
- `core/theories/README.md` — 12-row theory catalog with
  uses-this packet column

**Trigger**: at least one non-developer role opens the
project in Obsidian AND reports that `git clone` + `ls` is
a barrier.

### Deliverable 2: Wikilinks completion in 4 theories

Currently 8 of 12 core/theories/*.md files have `[[wikilinks]]`
applied. The remaining 4 — `predicate.md`, `refinement.md`,
`assumption.md`, `agent.md` — need the same treatment.

**Trigger**: any new theory file gets wikilinks from day one.
Adopt policy: every new theory file has at least 1 wikilink.

### Deliverable 3: `core/obsidian.md` — vault-opening manifest

~40 lines describing:

- Vault root = repo root
- Optional plugins: Dataview, Mermaid (built-in)
- How to read `[[…]]` (bidirectional)
- Tag policy: `#convention` minimum (see Deliverable 4)
- "Don't edit .md packet files through Obsidian — edits go
  through git/agents.md"

**Trigger**: Deliverable 1 ships OR a user asks for Obsidian
interop documentation.

### Deliverable 4: `core/packet-filler.sh` + master+derived protocol

A POSIX shell tool the agent calls:

```bash
sh core/packet-filler.sh <packet-id> --from-file <spec.yaml>
```

`spec.yaml` carries the 4 sections (decision, task,
assumptions, refinement). The script writes 5 files into
`math/<packet-id>/` and updates `packet.yaml`.

**One LLM call → one tool call → one packet exists.** The
agent's `core/agent.sh` (D7) integrates this as its
packet-creation step.

`packet.yaml` stays as the source of truth; the .md files
become derived human/Obsidian-friendly projections.
`core/packet-schema.md` gains a "source-of-truth declaration"
section.

The schema for `spec.yaml` lives in
`core/packet-spec-schema.md` (separate OS file for clarity).

**Trigger**: 3+ new packets authored via LLM in a single
session OR the user asks for friction reduction explicitly.

### Tag policy (Deliverable 4's tag subsystem)

Once Deliverables 1-3 ship, add `#convention` to every
packet's 4 `.md` files (148 insertions across 37 packets).
The tag is **literal** in markdown — no plugin parsing; an
agent or human can filter via Obsidian's tag panel.

## What this packet commits to

- The 4 deliverables are listed with explicit trigger
  conditions
- This packet itself is **sketch** — its existence is the
  decision, not its materialisation
- When a trigger fires, a new packet is opened, not this
  one promoted to working

## What this packet does NOT commit to

- Web UI for non-Obsidian users (handled by `math/web-ui-as-packet/`)
- Dataview SQL queries on packet metadata (Phase E+)
- Canvas-generation from depends_on DAG (Phase E+)
- A specific LLM API for `core/packet-filler.sh` (the script
  is API-agnostic; the LLM lives in the agent, not in
  convention)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/obsidian-visualization-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/obsidian-visualization-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/obsidian-visualization-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/obsidian-visualization-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/obsidian-visualization-as-packet/packet.yaml)

## Decision

#convention
## Thesis
math-coding v0.618 ships 38 packets and 12 theories in
plain text + git + POSIX shell. Three evolution axes remain
deferred from Phase D, all addressing the same need: **make
the convention easier to enter, navigate, and grow**:
1. **Obsidian interop** — open the repo as an Obsidian vault
   without setup; navigation via `[[wikilinks]]` and Map of
   Content files
2. **Visualization** — embed Mermaid diagrams in core/theories/
   so the FSM, LTL, DAG, and supersession become inline
   diagrams Obsidian renders natively
3. **Friction reduction** — collapse the "5 files per
   packet" interaction model into **1 LLM-вызов + 1 tool-call**,
   keeping the 5-file convention internally
These three are independent in implementation but share a
trigger: a non-developer role (PM, designer, researcher, tech-
writer) actively adopting the convention.
## Antithesis
Three threads × "ship now" = premature commitments. The
convention has lived through Phase B → C → D with only
plain text + shell. Each new artifact risks:
- MOC files that nobody opens (dead navigation)
- Mermaid diagrams that become stale (rendered-evidence drift)
- A packet-filler that introduces LLM-inconsistent 5-file
  outputs (round-trip drift)
Convention accumulates a cost for every "we might need this"
artifact. Until trigger conditions are met, these cost more
than they save.
## Synthesis
This packet documents the strategy as a sketch (lifecycle:
sketch, decision: needed). Four deliverables are listed with
explicit **trigger conditions** — each becomes its own packet
when (and only when) a real adopter requires it.
### Deliverable 1: MOC README.md files
Three Map-of-Content files (additive only):
- `core/README.md` — root MOC with sections: Conventions,
  Theories, Tools, Packets
- `math/README.md` — 38-row packet catalog grouped by
  lifecycle and substrate, with wikilinks to each packet's
  `decision.md`
- `core/theories/README.md` — 12-row theory catalog with
  uses-this packet column
**Trigger**: at least one non-developer role opens the
project in Obsidian AND reports that `git clone` + `ls` is
a barrier.
### Deliverable 2: Wikilinks completion in 4 theories
Currently 8 of 12 core/theories/*.md files have `[[wikilinks]]`
applied. The remaining 4 — `predicate.md`, `refinement.md`,
`assumption.md`, `agent.md` — need the same treatment.
**Trigger**: any new theory file gets wikilinks from day one.
Adopt policy: every new theory file has at least 1 wikilink.
### Deliverable 3: `core/obsidian.md` — vault-opening manifest
~40 lines describing:
- Vault root = repo root
- Optional plugins: Dataview, Mermaid (built-in)
- How to read `[[…]]` (bidirectional)
- Tag policy: `#convention` minimum (see Deliverable 4)
- "Don't edit .md packet files through Obsidian — edits go
  through git/agents.md"
**Trigger**: Deliverable 1 ships OR a user asks for Obsidian
interop documentation.
### Deliverable 4: `core/packet-filler.sh` + master+derived protocol
A POSIX shell tool the agent calls:
```bash
sh core/packet-filler.sh <packet-id> --from-file <spec.yaml>
```
`spec.yaml` carries the 4 sections (decision, task,
assumptions, refinement). The script writes 5 files into
`math/<packet-id>/` and updates `packet.yaml`.
**One LLM call → one tool call → one packet exists.** The
agent's `core/agent.sh` (D7) integrates this as its
packet-creation step.
`packet.yaml` stays as the source of truth; the .md files
become derived human/Obsidian-friendly projections.
`core/packet-schema.md` gains a "source-of-truth declaration"
section.
The schema for `spec.yaml` lives in
`core/packet-spec-schema.md` (separate OS file for clarity).
**Trigger**: 3+ new packets authored via LLM in a single
session OR the user asks for friction reduction explicitly.
### Tag policy (Deliverable 4's tag subsystem)
Once Deliverables 1-3 ship, add `#convention` to every
packet's 4 `.md` files (148 insertions across 37 packets).
The tag is **literal** in markdown — no plugin parsing; an
agent or human can filter via Obsidian's tag panel.
## What this packet commits to
- The 4 deliverables are listed with explicit trigger
  conditions
- This packet itself is **sketch** — its existence is the
  decision, not its materialisation
- When a trigger fires, a new packet is opened, not this
  one promoted to working
## What this packet does NOT commit to
- Web UI for non-Obsidian users (handled by `math/web-ui-as-packet/`)
- Dataview SQL queries on packet metadata (Phase E+)
- Canvas-generation from depends_on DAG (Phase E+)
- A specific LLM API for `core/packet-filler.sh` (the script

## Task

# obsidian-visualization — task

#convention
## Problem

Convention is 38 packets of plain text + git + POSIX shell.
Three quality-of-life improvements are deferred:

1. **Vault-ready Obsidian** — `git clone && open-in-obsidian`
   should yield navigable content without manual setup
2. **Inline diagrams** — Mermaid in core/theories/*.md makes
   FSM, LTL, modal, supersession visual at a glance
3. **Friction-reduction** — 5 files × packet = 5 manual
   edits; the LLM agent should produce a packet in 1 call

Until now, none of these is materialized. Convention grows
towards 50+ packets; without navigation, the convention
becomes harder to enter — exactly the failure mode Phase B
warned against.

## Desired outcome

- This packet (sketch) records the strategy
- Each deliverable has explicit trigger conditions
- No deliverable ships before trigger fires

## Constraints

- This packet stays at `lifecycle: sketch`, `decision: needed`
- Materialisation is via separate packets (D5, D7, D10+, etc.)
- No commits past the strategy-recording commit until a
  trigger fires

## Assumptions

```yaml
task_id: obsidian-visualization
assumptions:
  - id: A1
    statement: "Obsidian as a reader is a strict superset of plain-text editors for the convention's existing markdown"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Obsidian renders markdown with [[wikilinks]], Mermaid,
      code blocks, YAML frontmatter. Every file in math/
      and core/ is plain text already; no transformations.
      See: agents-md-as-packet/refinement.md

  - id: A2
    statement: "Mermaid is the de-facto standard for inline diagrams in markdown; Obsidian renders it without plugins"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Mermaid ships with Obsidian's core renderer since
      2021; code blocks with `mermaid` language render
      stateDiagram, flowchart, sequenceDiagram, etc.
      See: https://mermaid.js.org/

  - id: A3
    statement: "The '#convention' tag is safe to add without drift risk: it's a literal string, not a semantic claim"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      Tags have no semantic meaning in math-coding; Obsidian
      reads them as filter keys. Plugin-free interpretation
      is the safe default.
      See: phase-d-continuation-as-packet/decision.md

  - id: A4
    statement: "master+derived is safe when spec is fully expressed in YAML and the .md projection is purely textual"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      packet.yaml already has all structured fields. The
      4 .md files are projection targets; round-trip is
      text-preserving as long as the script is non-lossy.
      See: theory-refinement-as-packet/refinement.md

  - id: A5
    statement: "core/packet-filler.sh does NOT need an LLM API key because the agent already has the LLM"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      The agent (opencode session) generates YAML spec in
      one LLM call and pipes it to the shell tool. The
      tool itself is a passive deployer, not an LLM caller.
      See: agent-as-packet/decision.md
```

## Refinement

# Refinement: obsidian-visualization

#convention
## State

- **pre**: 38 packets, 12 theories, 1 verifier. Plain text +
  git + POSIX shell. No Obsidian-specific structure, no
  Mermaid, no LLM-tool integration for packet creation.
- **post**: this packet records the strategy with explicit
  triggers. Materialisation deferred until trigger fires.

## Operation

This packet is documentation of strategy only. No code, no
schema, no manifest written by this commit. Future packets
(D5-completion, MOC-ship, packet-filler-ship) materialise
each deliverable when its trigger fires.

## Mapping (deliverables → convention axes / triggers)

| Deliverable                      | Convention axis       | Trigger                                  |
|----------------------------------|------------------------|-------------------------------------------|
| MOC README.md files              | D5 (wikilinks) / D12 (LTL) | non-developer opens vault, reports barrier |
| Wikilinks in 4 theories          | D5 (wikilinks)        | new theory file gets wikilinks from day 1 |
| `core/obsidian.md` manifest      | D5 + D42 (web-ui)     | user asks for Obsidian documentation     |
| `core/packet-filler.sh`         | D7 (agent)            | 3+ LLM-authored packets in one session   |
| `#convention` tags               | tag policy subsystem   | any of Deliverables 1-3 ships           |

## Invariant preservation

- 37 existing packets still pass `core/verify.sh` after
  this commit
- `AGENTS.md` ≤ 60 lines (this packet does not touch it)
- `core/coverage.yaml` not modified (this packet is
  documented in `decision.md`, not in coverage)

## Test obligation

- `sh core/verify.sh` returns VERIFIED, 0 errors after
  adding this packet
- 38 packets total
- This packet has 5 files matching the convention

## Runtime check

- A convention author re-reads this packet when a trigger
  fires (new role uses the convention, request for Obsidian
  doc, LLM-authoring becomes routine)
- The trigger opens a **separate packet**, not promotes
  this one

## Cross-reference

Pairs with:

- `math/web-ui-as-packet/` (D42) — web UI for non-Obsidian users
- `math/fast-track-as-packet/` (D30/D31) — modes × roles, the
  role-detection this packet activates
- `math/agent-as-packet/` (D32) — the LLM-as-runtime; this
  packet adds the packet-creation tool to it
- `math/phase-d-continuation-as-packet/` (D7 protocol) — D7
  agent bootstrap needs packet-filler to be useful
- `math/phase-d-development-as-packet/` — Phase D narrative
  index mentioning wikilinks and visualization

