# Glossary

| Term | Meaning |
|------|---------|
| **Artifact** | A file in the repository |
| **Convention** | A set of rules (`core/core.md`) |
| **Packet** | A directory with 3 required files: `packet.yaml`, `task.md`, `assumptions.yaml` |
| **Fractal property** | Convention applies to itself; every key decision has a packet in `specs/` |
| **FSM** | Finite state machine |
| **LTL** | Linear-time temporal logic |
| **TLA+** | Temporal Logic of Actions — formal specification language |
| **Verifier** | A shell script that checks invariants; produces `verifier-output.yaml` |
| **Verdict** | Result of verification: VERIFIED / NEEDS_REVISION / UNVERIFIABLE:* |
| **Epistemic marker** | `fact` / `hypothesis` / `judgment` / `unknown` |
| **Action protocol** | What the agent does based on the marker |
| **Liveness** | "Eventually happens" (`□`, `◇`, `↝`) |
| **Safety** | "Never happens" (invariant) |
| **Refinement** | Mapping `R : S_impl → S_spec` |
| **Supersession** | `P_old ⊥ P_new` (deprecation) |
| **Self-application** | Convention describes its own development |
| **Rigor** | Level of formal verification (`light` → `proof`, 4 levels) |
| **Substrate** | Formal tool: `none|shell|tla|typescript|pbt|alloy|coq|bpmn|pbt-prism` (9 values) |
| **Lifecycle** | 6 states: `sketch|working|verified|deprecated|archived|superseded` |
| **`.mathcodingrc`** | Project config: `packets_dir: specs` (default) |
| **Recursive verifier** | `specs/self-check/verify-structural.sh` — mechanically checks convention adherence |
| **Coverage** | `specs/coverage/coverage.yaml` — inventory of all decisions |
| **Two modes** | Self-application (this repo) vs external project (your code) |
| **Decision-packet** | A packet in `specs/<name>/` documenting a key convention decision |
| **Coverage gap** | A decision in `coverage.yaml` with `packet: null` — fails CI if `severity: critical` |
