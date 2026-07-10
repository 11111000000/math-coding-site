# ADR — substrate-enum


## Problem

A packet's `substrate` field tells the verifier which formal
tooling (if any) is expected for that packet. Without a fixed
enum, agents invent values (`tla-plus`, `TLA`, `TLAPS`,
`typecheck`) and the verifier can't validate the choice.

v1.0.0 introduced 9 values. v1.1.0 added a substrate **decision
tree** in `core/packet-schema.md` to make selection explicit. But
neither was documented as its own decision-packet.

## Desired outcome

A packet's `substrate` field has one of these 9 values:

| Value | Tool | Use case |
|---|---|---|
| `none` | no formal tool | small decisions, <3 states, no concurrency |
| `shell` | POSIX sh + tests | 3-10 states, sequential |
| `tla` | TLA+ + TLC | concurrent, distributed, >10 states |
| `typescript` | TypeScript types | when code is TS-first |
| `pbt` | jqwik / fast-check (or PRISM) | property-based, probabilistic |
| `alloy` | Alloy Analyzer | relational schema, >5 entity types |
| `coq` | Coq | security/financial/safety-critical |
| `bpmn` | BPMN | business process, multi-step workflow |
| `pbt-prism` | PRISM | probabilistic model checking |

(Substrate enum lives in `core/packet-schema.md`. Tools catalog
lives in `theories/formal-tools.md`.)

Selection follows the **substrate decision tree** in
`core/packet-schema.md#substrate-decision-tree` (see also
`specs/v1.1.0-substrate-decision/` for the meta-decision to
make selection explicit). `core/init-packet.sh` provides
post-creation hints based on keywords in `task.md`.

## Constraints

- Enum (string), parsed by `core/verify.sh`
- Each value maps to a documented tool in `theories/formal-tools.md`
- Agents apply judgment when the tree recommends multiple substrates

## Alternatives considered

- **Free-form string:** rejected — verification impossible
- **No substrate field:** rejected — agents don't know which tool
  to apply; convention becomes fragile
- **Tool-name as value (`tla-plus` instead of `tla`):** rejected —
  ties enum to specific implementation; loses abstraction
- **Separate fields per tool:** rejected — adds 4+ fields per packet

## Consequences

- One substrate vocabulary across all packets
- Decision tree is a single source of truth for selection
- `init-packet.sh` can suggest substrate from task.md keywords
- Future new substrates: add to enum, update decision tree, document
  in `theories/formal-tools.md`; no packet needed (a new `substrate`
  is a typo-fix or a tool addition, not a convention-decision)
