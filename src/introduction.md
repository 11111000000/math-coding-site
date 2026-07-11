# math-coding

**A convention for mathematically grounded software artifacts.**

Plain text + git. No external dependencies.

# math-coding

A convention for mathematically grounded software artifacts.

Plain text + git. No external dependencies. No frameworks. No
boilerplate. Just three files per packet.

## What is this

math-coding is a **convention** for capturing **intent** before
code is written. Every decision is a **packet** — a directory
with three required files:

- `packet.yaml` — manifest (what is this packet)
- `task.md` — intent (why is this being made)
- `assumptions.yaml` — epistemic context (what we assume)

The packet is **separate from code**. Code lives in `src/`,
`lib/`, or wherever the project's convention dictates. The
packet is the **intent before the code**.

## How to use

```
$ sh core/init-packet.sh my-feature
$ # Edit the 3 created files
$ sh core/verify.sh
$ # Write code in src/
```

That's it. The packet is the documentation of *why* this code
exists. If someone asks "what does this code do?" a year from
now, they can read the packet instead of guessing.

For a working example with code, tests, and verifier, see
`examples/minimal-packet/`. For how to apply in an external
project, see `examples/external-project/`.

## What goes in a packet

Three required files:

### `packet.yaml`

```yaml
task_id: my-feature          # unique identifier
title: My feature           # human-readable name
lifecycle: sketch           # sketch|working|verified|deprecated|archived
substrate: shell             # none|shell|tla|typescript|pbt|alloy|coq|bpmn
rigor: light                # light|property|temporal|proof
decision: needed            # needed|made
created: "2026-07-04"       # ISO date
verifier: null              # null (self-applied) or {command, verdict_file}
depends_on: []              # list of other task_ids
```

### `task.md`

Three sections, each ≥10 words:

```markdown
# my-feature

## Problem

What problem does this packet address?

## Desired outcome

What success looks like.

## Constraints

- must be testable
```

### `assumptions.yaml`

```yaml
task_id: my-feature
assumptions:
  - id: A1
    statement: "<your first assumption>"
    status: agent-inferred
    epistemology: hypothesis
    confidence: 0.5
```

Each assumption has 4 markers (`fact` / `hypothesis` /
`judgment` / `unknown`) and optional confidence 0-1.

## Audience

- **AI agents**: read packet before writing code. Apply
  epistemic protocol to each assumption.
- **Engineers**: write packet before code. Treat packet as
  decision record.
- **Tech leads**: review packets in PRs. Each packet is a
  "why" document for the code that follows.

## When NOT to use

math-coding is for **decisions with intent**. It's overkill for:

- Throwaway scripts (1-2 lines, deleted same day)
- Prototypes (≤1 day, never expected to ship)
- Pure data transformations (no business logic)

For these, write the code directly and add a packet later if
the code survives.

## Philosophy

**Why does this exist?** Vibe coding captures no intent. Code
is a black box. When something breaks, the developer asks
"why was this written this way?" and gets no answer.

math-coding makes intent **explicit** before code is written.
The packet answers "why" before the code answers "how".

**Why three files?** Three is the minimum that captures the
three epistemic dimensions: *what* (manifest), *why* (intent),
*what we assume* (epistemic context). One file collapses these.
Six or more files adds bureaucracy without adding information.

**Why separate packet from code?** Because code is implementation
and intent is design. Separating them lets you change one
without rewriting the other. The packet is the contract; the
code is the implementation.

## Rigor levels

| Rigor | Add | When |
|-------|-----|------|
| light | (default) | any project |
| property | + `refinement.md` (state mapping) | bugs in transitions |
| temporal | + `Model.tla` (or .als) | concurrency, distributed |
| proof | + formal proof (Coq, Lean) | cryptographic, financial, safety-critical |

Rigor is **opt-in by level**. Stage 1 (this README) for any
project. Stage 2 (theories) when complexity demands. Stage 3
(formal proof) when correctness is critical.

The 11 theory documents in `theories/` are **opt-in** by
rigor level — agents at `rigor: light` skip `curry-howard.md`
and `modal.md`. Each theory file states its rigor level at the
top.

Theory files are **documentation, not packets**. The decision
to include each theory (or the layer as a whole) lives as a
packet in `self-application/specs/theory-layer-*/`. This
separates "the math" (knowledge) from "the decision to use
the math" (intent). See
`core/packet-schema.md#theory-layer-pattern-v111`.

## Theories (opt-in by rigor)

| Theory | File | Rigor |
|---------|------|-------|
| Predicate | `theories/predicate.md` | any |
| Finite State Machine | `theories/fsm.md` | any |
| Linear-time Temporal Logic | `theories/ltl.md` | temporal+ |
| Refinement | `theories/refinement.md` | any |
| Assumption Set (Hoare) | `theories/assumption.md` | any |
| Verdict (5 outcomes) | `theories/verdict.md` | any |
| Epistemic State | `theories/epistemic.md` | any |
| Deprecation (Supersession) | `theories/deprecation.md` | any |
| Curry-Howard | `theories/curry-howard.md` | proof+ |
| Modal Logic for FSM | `theories/modal.md` | temporal+ |
| Confidence as Information | `theories/confidence.md` | any |

## Examples

- `examples/minimal-packet/` — working hello-world in 5 lines
  of bash, with test and verifier
- `examples/external-project/` — how to apply in a foreign
  project (login feature with bcrypt)

## Comparison with ADRs

ADRs (Michael Nygard) record **architectural decisions** in
a single file. math-coding records **per-feature decisions**
in a directory. They overlap but differ:

| | ADRs | math-coding |
|---|------|--------------|
| Scope | per architecture | per feature |
| Format | one file | directory with 3 files |
| Epistemic | none (free-form) | 4 markers + confidence |
| Verification | none (manual) | `verify.sh` (structural) |
| Audit | by humans | by humans + `verify.sh` |

**When to use both:** use math-coding for **feature decisions**
(login, payments, etc.), use ADRs for **architecture decisions**
(monorepo, framework choice, etc.). They complement each other.

## Self-application

This convention-repo applies math-coding to itself: every
directory with a `packet.yaml` is a packet. But some files are
**operating-system**, not packets (LICENSE, README, etc.) —
they're listed in `core/meta.yaml`. The fractal property applies
to **decisions with intent**, not to **every file**.

## License

CC-BY-SA 4.0


