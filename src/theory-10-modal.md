# Modal Logic for FSM Lifecycles

**Rigor level:** temporal+ (not used for light)

Modal operators:
- □P — "necessarily P" (P in every reachable lifecycle state)
- ◇P — "possibly P" (P in some reachable lifecycle state)
- P ~> Q — "P leads to Q" (whenever P, then Q eventually)

A packet lifecycle FSM (sketch → working → verified →
deprecated → archived) has **safety** and **liveness**
properties:

| Property | Formula | Type |
|----------|---------|------|
| No skipping | ¬(sketch → verified) | safety |
| Verified persists | □(verified ⇒ ◇working) | liveness |
| Deprecated reaches archived | deprecated ~> archived | liveness |

**Used in:** `refinement.md` of packets with non-trivial
lifecycle. For simple CRUD packets, skip.

**Example:** webhook handler packet must guarantee that
"every `working` state eventually reaches `verified` or
`sketch`" — write this as `working ~> verified ∨ sketch` in
`refinement.md:§Liveness`.
