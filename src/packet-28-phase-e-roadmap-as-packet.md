# phase-e-roadmap — what's next after Phase D

## Thesis

Phase B (structural), Phase C (harmony + drift), Phase D
(semantic + agent + checklists + rigor: temporal) are
shipped. With Phase D done, the convention has:

- **Self-verification**: `core/probe.sh` runs verify +
  semantic + drift; axiom A4 is executable.
- **Friction-reduction**: `core/packet-filler.sh` deploys
  5 files from one YAML spec.
- **Visualization**: `core/dag-canvas.sh` produces
  `math/dag.canvas` (Obsidian Canvas JSON).
- **Navigation**: 3 MOC files + `core/obsidian.md` make the
  repo vault-ready.

Three sources of residual friction remain:

- **No round-trip**: edits to `.md` files break the
  packet.yaml-master intent if they're not regenerated
- **No inline diagrams**: FSM, LTL, modal, supersession
  theories have prose-only descriptions
- **No query layer**: 41 packets × 5 fields are not
  queryable in Obsidian's Dataview without frontmatter

These are Phase E+ axes, ordered by leverage.

## Antithesis

Each axis has a cost:

- Round-trip extract requires non-lossy parsing of
  bullet/markdown lists — fragile, especially for
  assumptions with multi-line evidence blocks
- Mermaid in core/theories/*.md duplicates the textual
  description; convention risk is rendering-evidence drift
- Frontmatter requires extracting from packet.yaml **and**
  keeping in sync with the actual structure; lint required

Without triggers each axis risks being premature.

## Synthesis

**E1: `core/extract-packet.sh`** — md → spec.yaml round-trip.
**E2: Mermaid in 4 theories** (fsm, ltl, modal, deprecation).
**E3: Dataview frontmatter** (5 required fields per packet).
**E4: `core/lint-extract.sh`** — verify round-trip idempotence.

Order: E1 → E2 → E3 → E4. Each axis ships as its own packet.
This packet records the ordering and the trigger conditions.

## What this packet commits to

- The 4 axes order
- Trigger conditions per axis
- Each axis becomes its own packet when triggered

## What this packet does NOT commit to

- Web UI (Phase F+)
- Multi-agent protocol (Phase G+)
- LLM-as-filler (out of scope — filler is passive deployer)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/phase-e-roadmap-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/phase-e-roadmap-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-e-roadmap-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/phase-e-roadmap-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/phase-e-roadmap-as-packet/packet.yaml)

## Decision

## Thesis
Phase B (structural), Phase C (harmony + drift), Phase D
(semantic + agent + checklists + rigor: temporal) are
shipped. With Phase D done, the convention has:
- **Self-verification**: `core/probe.sh` runs verify +
  semantic + drift; axiom A4 is executable.
- **Friction-reduction**: `core/packet-filler.sh` deploys
  5 files from one YAML spec.
- **Visualization**: `core/dag-canvas.sh` produces
  `math/dag.canvas` (Obsidian Canvas JSON).
- **Navigation**: 3 MOC files + `core/obsidian.md` make the
  repo vault-ready.
Three sources of residual friction remain:
- **No round-trip**: edits to `.md` files break the
  packet.yaml-master intent if they're not regenerated
- **No inline diagrams**: FSM, LTL, modal, supersession
  theories have prose-only descriptions
- **No query layer**: 41 packets × 5 fields are not
  queryable in Obsidian's Dataview without frontmatter
These are Phase E+ axes, ordered by leverage.
## Antithesis
Each axis has a cost:
- Round-trip extract requires non-lossy parsing of
  bullet/markdown lists — fragile, especially for
  assumptions with multi-line evidence blocks
- Mermaid in core/theories/*.md duplicates the textual
  description; convention risk is rendering-evidence drift
- Frontmatter requires extracting from packet.yaml **and**
  keeping in sync with the actual structure; lint required
Without triggers each axis risks being premature.
## Synthesis
**E1: `core/extract-packet.sh`** — md → spec.yaml round-trip.
**E2: Mermaid in 4 theories** (fsm, ltl, modal, deprecation).
**E3: Dataview frontmatter** (5 required fields per packet).
**E4: `core/lint-extract.sh`** — verify round-trip idempotence.
Order: E1 → E2 → E3 → E4. Each axis ships as its own packet.
This packet records the ordering and the trigger conditions.
## What this packet commits to
- The 4 axes order
- Trigger conditions per axis
- Each axis becomes its own packet when triggered
## What this packet does NOT commit to
- Web UI (Phase F+)

## Task

# phase-e-roadmap — task

## Problem

Phase D shipped. The convention is vault-ready and
friction-reduced. Three residual sources of friction
remain documented but not shipped.

## Desired outcome

This packet records the next 4 axes with trigger conditions.
Each axis ships when a real adopter requires it.

## Constraints

- Each axis has its own packet, not inlined
- Trigger conditions are recorded, not guessed
- Convention does NOT add new external dependencies

## Assumptions

```yaml
task_id: phase-e-roadmap
assumptions:
  - id: A1
    statement: "Round-trip (md → spec.yaml) is non-trivial because .md files have heterogeneous structure"
    status: agent-inferred
    epistemology: fact
    confidence: 0.85
    evidence: |
      decision.md has Thesis/Antithesis/Synthesis/What this
      packet commits to/What this packet does NOT commit
      to. assumptions.yaml has id/statement/status/etc.
      Different structures → parsing-fragile.
      See: core/packet-schema.md

  - id: A2
    statement: "Mermaid in core/theories/*.md does not duplicate content — it adds inline rendering to existing prose"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Mermaid code block at the end of a section is
      additive; the prose remains. Obsidian renders the
      block alongside the prose.
      See: obsidian-visualization-as-packet/decision.md

  - id: A3
    statement: "Dataview frontmatter duplication is safe if lint enforces sync with packet.yaml"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Without lint, drift is certain. With lint, any
      in-place edit triggers a violation, forcing a
      packet-filler rerun.
      See: core/packet-spec-schema.md

  - id: A4
    statement: "Lint-idempotence (filler → extract → compare) is the natural round-trip verification"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Same spec → same files → same spec; if not, drift.
      Lint-compare catches the drift.
      See: phase-d-roadmap-as-packet/decision.md

  - id: A5
    statement: "Phase E+ explicit ordering prevents premature commitment"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      This packet has lifecycle: working, decision: made —
      the ordering is committed, not the implementation.
      See: phase-d-roadmap-as-packet/refinement.md
```

## Refinement

# Refinement: phase-e-roadmap

## State

- **pre**: Phase D's deliverables all shipped (probe, agent,
  filler, dag-canvas, MOCs, manifest, wikilinks, tags).
- **post**: Phase E+ axes are ordered and trigger-gated.

## Operation

This packet is documentation of strategy only. Each axis
opens its own packet when triggered.

## Mapping (Phase E axes)

| Axis | Description | Trigger |
|------|-------------|---------|
| E1: extract | `core/extract-packet.sh` md → spec.yaml | user edits .md manually + asks for round-trip |
| E2: Mermaid | inline `\`\`\`mermaid` in 4 theories | user views core/theories/*.md in Obsidian canvas |
| E3: Dataview | frontmatter `---` blocks in 4 .md per packet | user asks for Dataview SQL queries |
| E4: lint | `core/lint-extract.sh` round-trip test | E1 + E3 shipped |

## Invariant preservation

- 40 existing packets still pass `core/verify.sh`
- `AGENTS.md` ≤ 60 lines (none of these axes touch it)
- `core/coverage.yaml` accumulates D-rows only when axes land

## Test obligation

- `sh core/verify.sh` returns VERIFIED, 0 errors after this
  packet is added
- 41 packets total
- Phase E+ axes have explicit triggers

## Runtime check

- A convention author re-reads this packet when one of the
  triggers fires
- The triggered axis opens its own packet (e.g.
  `math/extract-as-packet/`)

## Cross-reference

Pairs with `phase-d-development-as-packet` (Phase D
narrative). This packet extends the roadmap into Phase E+
with the friction-reduction trail.

