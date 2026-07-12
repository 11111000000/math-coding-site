# Theory: Predicate and Invariant

**Rigor:** any (foundational)

A predicate over a state space S is a function:

    I: S → B

A state s satisfies I iff I(s) = true. The convention uses
predicates to express every binary check ("packet is verified",
"packet has 5 files", "agent believes P").

Used in math-coding:

- [[theory-predicate-as-packet|predicate-as-packet]] — applies
  this theory to per-packet invariants
- [[theory-assumption-as-packet|assumption-as-packet]] — Σ as
  set of assumption predicates

## math-coding instance

In math-coding, predicates appear at two scales:

1. Per-packet invariant — `I(packet) = (5 required files exist)`
   drives the structural check in `core/verify.sh`.
2. Convention-wide invariant — every claim in `decision.md`
   is reified as a predicate over the packet state space so
   that verdicts (VERIFIED / NEEDS_REVISION / UNVERIFIABLE:*)
   reduce to predicate satisfaction.
