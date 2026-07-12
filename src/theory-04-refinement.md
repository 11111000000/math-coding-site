# Theory: Refinement

**Rigor:** property

A refinement is a relation R ⊆ S_impl × S_spec such that every
implementation behaviour has a matching (possibly stuttering)
specification behaviour:

    R: S_impl → S_spec

`S_impl ⊨ R(S_spec)` means the implementation refines the spec.

## math-coding instance

In math-coding, the *packet* is the specification and the
*code* (or absent code) is the implementation. The
`refinement.md` of every packet must declare a State mapping,
an Operation mapping, an Invariant preservation, a Test
obligation, and a Runtime check — these five sections are
the refinement relation written out.

Used in math-coding:

- [[theory-refinement-as-packet|refinement-as-packet]] — 5-section
  pattern enforced across all packets
- [[theory-fsm-as-packet|fsm-as-packet]] — FSM is the spec half,
  packet is the implementation half of R
