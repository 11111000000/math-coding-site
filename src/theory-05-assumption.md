# Theory: Assumption Set (Hoare)

**Rigor:** property

Hoare logic reasons about partial correctness of programs:

    {Pre} C {Post}

reads: if `Pre` holds before executing `C`, then `Post`
holds after. The assertion logic extends naturally to a
context-sequent reading:

    Σ ⊢ Spec

where Σ is a set of assumption statements and Spec is the
claim they support.

## math-coding instance

In math-coding, the `assumptions.yaml` file lists Σ (with
status, epistemology, confidence, evidence per entry).
`decision.md` declares Spec. The reading "Σ ⊢ Spec" is the
convention's load-bearing sentence: a packet is justified
exactly when its assumption set justifies its claim.

Used in math-coding:

- [[theory-assumption-as-packet|assumption-as-packet]] — applies
  Σ ⊢ Spec to every packet's claim
- [[theory-verdict-as-packet|verdict-as-packet]] — verdict = result
  of resolving Spec against the assumption set
