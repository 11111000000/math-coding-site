# Theory: Verdict

**Rigor:** any (foundational)

A verification verdict is the outcome of evaluating the
proof obligation:

    Spec ⊨ P

The standard convention outcomes are:

    VERIFIED                 — proof holds under test
    NEEDS_REVISION           — counterexample found
    UNVERIFIABLE:TOOL_MISSING     — tool unavailable
    UNVERIFIABLE:OUT_OF_SCOPE     — human review required
    UNVERIFIABLE:DEFERRED         — data not yet available

## math-coding instance

In math-coding, the structural verifier
`core/verify.sh` produces one of these verdicts at the repo
level. Per-packet verdicts are recorded in
`packet.yaml:verifier` and back to `lifecycle`.

See [[math/theory-verdict-as-packet/refinement.md|the verdict→FSM-transition mapping]] for the
verdict→FSM-transition mapping.
