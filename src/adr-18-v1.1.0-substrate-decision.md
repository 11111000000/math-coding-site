# ADR — v1.1.0-substrate-decision


## Problem

v1.0.0 introduced `substrate` field in `packet.yaml` (one of
`none|shell|tla|typescript|pbt|alloy|coq|bpmn`). But how does
an agent choose which substrate for a given decision?

In v1.0.0, the choice was implicit — agent had to apply
judgment. This works for experienced users but is a **friction
point** for new users. The convention is **self-documenting**
in most areas (packet schema, theories, examples) but
**implicit** here.

## Desired outcome

Add an explicit **substrate decision tree** in
`core/packet-schema.md` (Section "Substrate decision tree")
and an **optional post-creation hint** in `init-packet.sh`
that scans `task.md` for keywords (concurrent, distributed,
security, financial) and recommends the appropriate substrate.

## Constraints

- must be **non-intrusive** — agent can ignore hints
- must be **machine-readable** (YAML, not just prose)
- must be **maintainable** — additions require editing one
  YAML block
- must not **force** formal methods on simple decisions

## Alternatives considered

- **Mandatory formal model for all packets:** rejected, too
  much overhead for simple CRUD endpoints
- **Separate document `substrate-decision.md`:** rejected,
  same content as packet-schema.md would be split
- **Decision tree in init-packet.sh prompt only:** rejected,
  init-packet.sh is for creation, not for reasoning
- **Machine-learning model that recommends substrate:** rejected,
  not LLM-parseable, requires training data

## Consequences

- v1.1.0+ has explicit substrate guidance
- v1.0.0 users unaffected (decision tree is additive)
- New users can choose substrate with less friction
- The convention is **more self-documenting** in this area
