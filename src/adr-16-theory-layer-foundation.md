# ADR — theory-layer-foundation


## Problem

A packet records a decision with intent. To make intent
**expressive** — to talk about invariants, operations,
epistemic states, lifecycle properties — the convention
needs a small library of foundational theories. Without
them, every packet ends up reinventing predicate logic
or FSM notation ad-hoc, and discussions across packets
cannot share vocabulary.

## Desired outcome

Introduce a `theories/` layer with 11 foundational
theories, each opt-in by rigor level. Each theory is a
single markdown document under `theories/<name>.md`
plus a **decision packet** documenting why the theory
is part of the convention. This packet covers the v1.0.0
introduction of the layer as a whole; per-theory decision
packets are not created (the 11 theories were introduced
as one curated set, not as 11 individual decisions).

## Constraints

- must be **plain text + git** (no external tools)
- must be **opt-in by rigor** — `rigor: light` should not
  require reading `curry-howard.md` or `modal.md`
- must be **LLM-parseable** (YAML frontmatter or pure MD)
- must work **offline** (no network calls)
- must not **force** formal apparatus on simple CRUD packets

## Theories introduced in v1.0.0

| Theory | File | Rigor level |
|---|---|---|
| Predicate | `theories/predicate.md` | any |
| Finite State Machine | `theories/fsm.md` | any |
| Linear-time Temporal Logic | `theories/ltl.md` | temporal+ |
| Modal Logic for FSM | `theories/modal.md` | temporal+ |
| Refinement | `theories/refinement.md` | any |
| Assumption Set (Hoare) | `theories/assumption.md` | any |
| Verdict | `theories/verdict.md` | any |
| Epistemic State | `theories/epistemic.md` | any |
| Deprecation (Supersession) | `theories/deprecation.md` | any |
| Curry-Howard | `theories/curry-howard.md` | proof+ |
| Confidence as Information | `theories/confidence.md` | any |

## Alternatives considered

- **No theory layer:** rejected. Packets would reinvent
  predicate logic and FSM notation per-feature; cross-packet
  vocabulary would diverge.
- **One unified theory:** rejected. Tries to subsume
  predicate + FSM + LTL + modal + refinement under a
  single formalism; over-generalized, hard to teach.
- **Full MathCodingFractal tooling (TLA+, Coq, TLAPS):**
  rejected. Adds heavy dependencies (Java + Isabelle)
  that violate the plain-text + git constraint. math-coding
  is a **lightweight** convention; heavy formal tools
  belong in external projects.
- **11 separate decision packets (one per theory):**
  rejected for v1.0.0. The 11 theories were introduced as
  one curated set, not as 11 independent decisions. A
  single packet documents the layer; per-theory rationale
  lives inside each `theories/<name>.md`.

## Consequences

- math-coding has a **shared vocabulary** across packets
- agents at `rigor: light` skip `curry-howard.md` and
  `modal.md` — opt-in by level, not all-or-nothing
- the convention is **extendable** — adding a theory is
  a single new markdown file plus a CHANGELOG entry
- the convention documents its own theory layer in
  `core/packet-schema.md#theories` (cross-reference)
- v1.1.0+ adds `theories/formal-tools.md` (catalog of
  external verification tools); see
  `self-application/specs/theory-layer-v1.1.0/`
