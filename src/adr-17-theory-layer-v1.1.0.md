# ADR — theory-layer-v1.1.0


## Problem

v1.0.0 introduced the `substrate` enum in `packet.yaml`
(one of `none|shell|tla|typescript|pbt|alloy|coq|bpmn`),
but did not explain **when** to choose which substrate.
The 11 v1.0.0 theories (predicate, FSM, LTL, refinement,
etc.) talk about *expressing* intent, but they do not
talk about *verifying* it externally.

In v1.0.0, the choice of substrate was implicit — the
agent applied judgment. This works for experienced users
but creates friction for new users who discover the
`substrate:` field without guidance.

## Desired outcome

Add `theories/formal-tools.md` — a catalog of the external
formal verification tools that math-coding **integrates
with** (TLA+, Coq, Alloy, PRISM, BPMN) — each with
when-to-use and when-NOT-to-use sections. The catalog
is a single markdown document under `theories/`, with its
decision packet documented here.

Decision packet follows the same pattern as the rest of
the convention: `theories/<name>.md` is documentation,
this packet in `self-application/specs/` records the
decision to add it.

## Constraints

- must be **0 dependencies** (do not bundle TLA+ tools,
  TLAPS, Isabelle, CoqIDE — these live in external
  projects)
- must be **opt-in** — agents at `rigor: light` skip it
- must be **machine-readable** (single markdown table,
  no proprietary tool formats)
- must be **maintainable** — additions require editing
  one section, not the whole file
- must not **force** formal tools on simple decisions

## What is added

`theories/formal-tools.md` (new in v1.1.0):

| Tool | Substrate | Use case |
|---|---|---|
| TLA+ | `tla` | Concurrent, distributed, state machines |
| Coq | `coq` | Security-critical, financial, safety |
| Alloy | `alloy` | >5 entity types with relational constraints |
| PRISM | `pbt` | Probabilistic behavior, randomized sampling |
| BPMN | `bpmn` | Business process, multi-step workflow |

Each tool has `When to use`, `When NOT to use`, `Files`,
`Tools` (external tooling), `Example` sections.

## Alternatives considered

- **Bundle TLA+ toolchain + TLAPS in the convention:** rejected.
  Adds 90MB+ of Java/Isabelle dependencies. Violates
  "plain text + git, no external dependencies".
- **One markdown file per tool:** rejected. Splits related
  information across 5 files; harder to compare.
- **Document tools inline in `core/packet-schema.md`:**
  rejected. Mixes schema spec with catalog; the catalog
  belongs in the theory layer.
- **Link to external documentation (TLA+ homepage, Coq docs):**
  rejected. Links rot; offline agents cannot follow them.
- **No formal-tools catalog:** rejected. Leaves agents
  without guidance on substrate selection.

## Consequences

- agents can **discover** substrate choice without reading
  external documentation
- the convention is **more self-documenting** — beginners
  see the catalog next to the theories they already read
- v1.0.0 substrate enum is **unchanged** (no breaking change)
- the theory layer is now: 11 foundational theories
  (v1.0.0) + 1 external tools catalog (v1.1.0) = 12 docs
- the existing `core/packet-schema.md#substrate-decision-tree`
  references `theories/formal-tools.md` for the full catalog

## Cross-references

- `core/packet-schema.md` — Substrate decision tree (uses this catalog)
- `core/init-packet.sh` — post-creation hints (referenced by
  this catalog's keywords)
- `self-application/specs/v1.1.0-substrate-decision/` —
  broader v1.1.0 decision to make substrate choice explicit
- `self-application/specs/theory-layer-foundation/` —
  the v1.0.0 theory layer this v1.1.0 addition extends
