# Theory: Curry-Howard Correspondence

**Rigor:** proof

Curry-Howard says: types are propositions, programs are
proofs. More precisely:

    Type ⇔ Proposition
    Program ⇔ Proof term
    Program type-checks ⇔ Proof is valid

## math-coding instance

In math-coding:

- the proposition (P) is the claim of `decision.md`
- the context (Γ) is `assumptions.yaml`
- the proof term is the packet itself
- type-checking is the verifier run
- a "proof accepted" outcome is lifecycle: verified with
  verdict: VERIFIED

[[math/math-coding-birth/refinement.md#axiom-A4|the math-coding-birth axiom A4]] frames the
correspondence as the convention's recursive-observability
guarantee: every packet is its own evidence.
