# What is math-coding?

math-coding is a **convention** for AI coding agents and the developers who work with them. It is grounded on one observation: a *proposition* and its *implementation* are different kinds of thing, and the gap between them is the place where bugs grow.

The convention fixes that gap by making every non-trivial decision a **packet** — a directory with exactly five files. The packet is the proposition. The verifier is the type-check. The convention applies to itself.

## Why a convention at all?

Code does not explain itself. A function `add(a, b)` is correct in arithmetic and wrong in string concatenation. The implementation carries no hint which one. The proposition must come from somewhere. Without a separate place for it, the developer guesses, the reviewer guesses, the user discovers.

math-coding gives the proposition its own home. It lives in `decision.md`, distinct from the code, and the convention guarantees this distinction by structure — not by policy, not by convention, but by the verifier.

## The five files of a packet

```
math/<NN-name>/
├── packet.yaml       manifest (lifecycle, substrate, applications)
├── decision.md       the proposition (thesis / antithesis / synthesis)
├── task.md           intent (problem / outcome / constraints)
├── assumptions.yaml  epistemic context (5 markers)
└── refinement.md     state / operation / invariant / test
```

- **packet.yaml** is the type signature. It says what the packet claims, what it depends on, who has applied it.
- **decision.md** is the proposition. The thesis is what the packet commits to. The antithesis is the strongest objection. The synthesis is the resolution.
- **task.md** is the goal. What problem the packet solves, what success looks like, what constraints apply.
- **assumptions.yaml** is the context. Five epistemic markers — *fact*, *hypothesis*, *judgment*, *unknown*, *proven* — keep knowledge honest.
- **refinement.md** is the elaboration. State, operation, mapping, invariant, test. How the claim unfolds.

The five files are the parts of a proof term. axiom Curry-Howard says so. The verifier enforces it.

## Seven axioms

The convention rests on seven axioms. They are not aspirational — they are real constraints that the verifier checks.

- **A0 Difference** — proposition and implementation are different kinds of thing.
- **A1 Care** — a developer cares whether the code does what it claims.
- **A2 Curry-Howard** — a packet is a proof term, the verifier is a type-check.
- **A3 Material Basis** — the convention lives in plain text, in git, and runs on POSIX.
- **A4 Process** — every packet traverses a six-state lifecycle; `sketch → verified` is forbidden.
- **A5 Accounting** — knowledge is marked, verdicts are named, changes are witnessed.
- **A6 Self-Application** — the convention applies to itself. Every axiom above is realised as a packet.

The axioms are themselves packets. `math/00-difference/` is a five-file packet that proves A0. The probe that verifies the convention is the subject of a packet. axiom Self-Application closes the loop.

## Eight theories

Eight mathematical theories ground the axioms. Each theory is a compact runtime spec for an LLM agent.

| Theory | Axiom | Statement |
|--------|-------|-----------|
| curry-howard | A2 | Types ⇔ Propositions, Programs ⇔ Proofs |
| predicate | A4 | I : S → Bool, every check is a predicate |
| fsm | A4 | M = ⟨S, s₀, A, →, I⟩, six-state lifecycle |
| refinement | A4 | R ⊆ S_impl × S_spec, packet ↔ implementation |
| verdict | A5 | Spec ⊨ P, five outcomes |
| epistemic | A5 | B : Prop × Agent → [0, 1], five markers |
| deprecation | A5 | ⊥ strict partial order, supersession DAG |
| agent | A6 | S = (chat, files, mode, role) |

## How a packet evolves

A packet is born in `sketch`. The convention holds the proposition first; code is the last step. The packet moves through `working` (proposition fully elaborated) to `verified` (at least one SHA in `applications[]`). From there it can be `deprecated` (newer packet supersedes it), `archived` (no longer used), or `superseded` (named successor exists).

The forbidden transition is `sketch → verified`. A proposition that has never been elaborated cannot be proven. The verifier enforces this: a packet with `lifecycle: verified` and no SHA in `applications[]` fails the check.

## What the verifier does

`sh math-coding verify` runs structural checks across the project: every packet has five files, every axiom packet is in `math/`, every SHA in `applications[]` resolves. `sh math-coding probe` runs six predicates that together are axiom Self-Application. Exit 0 means the convention is internally consistent.

## How to read this site

The navigation on top opens the eight sections of the rendered convention:

- **Axioms** — the seven axiom packets, each with a statement and a link to its packet.
- **Theories** — the eight mathematical theories that ground the convention.
- **Packets** — every packet in the project, with lifecycle badges and links.
- **Graph** — the dependency graph between packets, axioms, and theories.
- **FSM** — the six-state lifecycle machine, with each packet's current position.
- **Skills** — opencode skills and reference material under `extensions/agents/`. Each skill has a SKILL.md entry point and lazy-loaded reference files.
- **Obsidian** — compatibility notes for opening the same vault in Obsidian.

The keyboard works too. `/` opens search. `j` and `k` move between packets. `g f` jumps to the FSM. `g g` to the graph. `Esc` closes the search.

## Get started

The convention runs in any POSIX shell. To install it in a project:

```sh
sh /path/to/math-coding/math-coding install /path/to/project
```

To verify a project:

```sh
cd /path/to/project
sh ./.math-coding/math-coding probe
```

If the probe exits 0, the convention is internally consistent. axiom Self-Application holds.
