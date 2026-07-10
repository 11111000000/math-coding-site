# ADR — decision-enum


## Problem

A packet can be in two epistemic states:
- The author has **not yet decided** what the implementation is
  (brainstorming, sketching, open question)
- The author **has decided** and the packet reflects that decision

Without an explicit marker, agents can't tell if a packet's
content is a proposal or a settled decision.

## Desired outcome

A packet's `decision` field has one of 2 values:
- `needed` — the decision is still open; `task.md` and `assumptions.yaml`
  describe a problem space, but no specific outcome is locked in
- `made` — the decision is locked; the packet describes a chosen
  outcome with documented alternatives

`init-packet.sh` creates packets with `decision: needed` by
default. After the author fills in `task.md:§Desired outcome`
with a concrete choice and at least one alternative considered,
they update to `decision: made`.

## Constraints

- Enum (string), parsed by `core/verify.sh`
- Default = `needed` (init-packet.sh)
- A `decision: made` packet is **immutable in spirit** but
  not enforced — authors can edit, but should record changes in
  `task.md:##Changelog` or use lifecycle:superseded + new packet

## Alternatives considered

- **No decision field:** rejected — agents can't distinguish
  proposals from commitments
- **3 values (`needed|considering|made`):** rejected — the middle
  state is not a stable point of packets
- **Boolean `decided: true|false`:** rejected — convention uses
  enums for state fields, not booleans; ambiguous tense
- **Separate `draft` and `proposed` states:** rejected — conflates
  with lifecycle (sketch, working)

## Consequences

- One decision vocabulary across all packets
- Spec readers know whether to argue or implement
- Verifier can find undecided packets for sprint planning
- `decision: needed` packets are explicitly **incomplete** by design
