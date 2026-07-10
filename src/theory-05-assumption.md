# Assumption Set (Hoare Logic)

**Rigor level:** any

A specification is a pair (Pre, Post) where Pre is the
precondition and Post is the postcondition. A program P
satisfies Spec under assumptions Σ iff:

∀s: Pre(s) ⇒ (∧_{a∈Σ} a(s)) ⇒ Post(P(s))

This is written: Σ ⊢ Spec.

**Used in:** `assumptions.yaml`. Each entry is an assumption
in Σ. The packet's `task.md:§Constraints` is the Pre; the
`task.md:§Desired outcome` is the Post.

**Example:** `Σ = {user is authenticated, request has body}`
precondition `request is valid`; outcome `response is 200`.
Program P: only valid under both assumptions in Σ.
