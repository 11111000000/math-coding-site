# Deprecation (Supersession)

**Rigor level:** any

A deprecation is a relation P_old ⊥ P_new where P_new
supersedes P_old. Three properties:
- **Irreflexive**: ¬(P ⊥ P)
- **Asymmetric**: P₁ ⊥ P₂ ⇒ ¬(P₂ ⊥ P₁)
- **Transitive**: P₁ ⊥ P₂ ∧ P₂ ⊥ P₃ ⇒ P₁ ⊥ P₃

These make ⊥ a **strict partial order**. Packets form a DAG.

**Used in:** `packet.yaml:lifecycle = deprecated|archived`.
The next packet in the chain is the superseder.

**Example:** `login-v1 ⊥ login-v2` (replaced). When `login-v2`
ships, `login-v1` is marked `lifecycle: deprecated`.
