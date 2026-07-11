# agents-md-as-packet — protocol for AI agents

## Thesis

AI coding agents (Claude, GPT-4, opencode) routinely read and
write files. math-coding must have a contract for how agents
interact with the convention — what they read first, what they
write, what they never modify. Without such a contract, agents
will improvise based on incomplete README.md, producing
inconsistent results.

## Antithesis

A long agent protocol becomes a maintenance burden. Each rule
becomes a debate. Each version change requires protocol
review. The protocol becomes its own convention-without-fractal-
property. The opposite failure mode: too rigid, agents
spend their time interpreting the protocol rather than working.

## Synthesis

A short protocol (< 50 lines) at the repo root, named
agents.md. The protocol tells the agent what to read, what to
write, and what never to edit. The protocol grows only when
needed — adding a rule requires a decision-packet that
supersedes this one.

## What this packet commits to

- agents.md exists at repo root with < 50 lines
- It documents: read order, write protocol, brownfield mode,
  assumption fields, edit rules
- This packet authorizes agents.md as convention-OS

## What this packet does NOT commit to

- A long agent manual (this is not a handbook)
- Encoding of all possible agent behaviors
- External scripts (those go in tools/ when needed)

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/agents-md-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/agents-md-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/agents-md-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/agents-md-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/agents-md-as-packet/packet.yaml)

## Decision

## Thesis
AI coding agents (Claude, GPT-4, opencode) routinely read and
write files. math-coding must have a contract for how agents
interact with the convention — what they read first, what they
write, what they never modify. Without such a contract, agents
will improvise based on incomplete README.md, producing
inconsistent results.
## Antithesis
A long agent protocol becomes a maintenance burden. Each rule
becomes a debate. Each version change requires protocol
review. The protocol becomes its own convention-without-fractal-
property. The opposite failure mode: too rigid, agents
spend their time interpreting the protocol rather than working.
## Synthesis
A short protocol (< 50 lines) at the repo root, named
agents.md. The protocol tells the agent what to read, what to
write, and what never to edit. The protocol grows only when
needed — adding a rule requires a decision-packet that
supersedes this one.
## What this packet commits to
- agents.md exists at repo root with < 50 lines
- It documents: read order, write protocol, brownfield mode,
  assumption fields, edit rules
- This packet authorizes agents.md as convention-OS
## What this packet does NOT commit to
- A long agent manual (this is not a handbook)

## Task

# agents-md-as-packet — task

## Problem

AI coding agents need a contract to interact consistently with
math-coding repositories. Without one, agents improvise based on
incomplete README.md, producing inconsistent work across
different agent runs and different agents.

## Desired outcome

A short protocol (under 50 lines) at the repo root that tells
the agent: (1) what to read first, (2) when to create a packet,
(3) when to create a new packet vs edit existing, (4) what
fields to fill in, (5) what NOT to modify.

## Constraints

- Plain text, no scripts in the protocol itself
- Protocol grows only when needed (new rules → supersession)
- agents.md lives at repo root (not in math/, not in core/)
- This packet authorizes agents.md as convention-OS

## Assumptions

```yaml
task_id: agents-md-as-packet
assumptions:
  - id: A1
    statement: "Agents can read short files (under 50 lines) reliably"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Modern agents handle small context windows well.
      A 50-line file fits in any agent's first read.
      See: packet:math-coding-birth/assumptions.yaml#A1

  - id: A2
    statement: "agents.md is OS, not a packet — it is convention metadata, not a decision"
    status: judgment
    epistemology: judgment
    evidence: |
      agents.md describes how to interact with convention,
      not a decision about convention itself. Like LICENSE,
      README.md, and core/, it is convention-OS.
      See: packet:math-coding-birth/refinement.md#operating-system

  - id: A3
    statement: "Brownfield mode means most existing files are OS, not packets"
    status: judgment
    epistemology: judgment
    confidence: 1.0
    evidence: |
      When math-coding is applied to an existing project,
      convention only wraps decisions, not the whole codebase.
      Most files remain untouched. This is the agents.md
      Brownfield protocol section.
      See: agents.md (the file itself, "Brownfield protocol" section)

  - id: A4
    statement: "Direct edits to existing packets are forbidden (structural)"
    status: judgment
    epistemology: judgment
    evidence: |
      Convention says structural changes require a new packet
      with supersession. This prevents history rewriting and
      keeps the DAG of decisions valid.
      See: packet:math-coding-birth/refinement.md#edit-protocol

  - id: A5
    statement: "agents.md is currently 44 lines (well under 50-line invariant)"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      wc -l agents.md returns 44. The invariant in
      math-coding-birth/refinement.md requires ≤ 50.
      See: agents.md (the file itself)
```

## Refinement

# Refinement: agents-md-as-packet

## State

- **pre**: agents.md exists at root but no packet authorizes it
- **post**: agents.md is authorized as convention-OS by this packet

## Operation

- This packet records the decision to have an agents.md
- It does NOT modify agents.md
- It references core-as-packet (which authorizes core/)

## Invariant

- agents.md exists at repo root
- agents.md line count ≤ 50 (math-coding-birth invariant)
- This packet has 5 files (matching convention)
- agents.md is OS, not in math/, not in core/

## Convention axes affected

- **Brownfield mode (refinement.md §14):** agents.md
  establishes what agents do in projects where most files
  are OS, not packets.
- **Edit protocol (refinement.md §15):** agents.md
  states when direct edits are OK vs when supersession
  is required.

## OS files authorized (1)

1. `agents.md` at repo root — agent protocol

## Test obligation

- `wc -l agents.md` ≤ 50
- This packet is in math/agents-md-as-packet/ with 5 files
- `git log --oneline | head` shows birth → core-as-packet → agents-md-as-packet

## Runtime check

- None required yet

