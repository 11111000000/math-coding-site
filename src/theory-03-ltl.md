# Linear-time Temporal Logic (LTL)

**Rigor level:** temporal+

LTL operators:
- □P — "always P" (P holds in every state)
- ◇P — "eventually P" (P holds in some state)
- P ~> Q — "P leads to Q" (whenever P, then Q eventually)
- WF_a — weak fairness: if a is always enabled, it eventually fires
- SF_a — strong fairness: if a is infinitely often enabled, it eventually fires

**Used in:** `refinement.md` (when stating properties of impl).
For liveness, write `P ~> Q` in `refinement.md`.

**Example:** `idle ~> processing` (every idle state eventually
becomes processing).
