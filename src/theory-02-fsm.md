# Finite State Machine (FSM)

**Rigor level:** any

A FSM is a tuple M = ⟨S, s₀, A, →, I⟩ where:
- S is a finite set of states
- s₀ ∈ S is the initial state
- A is a set of actions
- → ⊆ S × A × S is the transition relation
- I: S → B is the invariant

**Used in:** `packet.yaml:lifecycle` is an FSM with states
`{sketch, working, verified, deprecated, archived}`.

**Example:** webhook handler with states `{idle, processing,
done, error}` and transition `process → done` or
`process → error`.
