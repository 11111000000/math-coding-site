# skill-packaging — math-coding as OpenCode skill

## Thesis

math-coding's value is **realized through AI agents**, not
just humans. Agents need a discoverable, machine-readable
manifest of the convention: what is it, when to apply it,
what tools it has, what files structure it requires.

OpenCode skills (like `~/.config/opencode/skills/humanize-writer`)
follow a standard format: `SKILL.md` with YAML frontmatter +
Markdown body, located at `~/.config/opencode/skills/<name>/`.

## Antithesis

Two failure modes:

- **Hidden convention**: agents discover math-coding through
  README.md only after exhausting other options. By then,
  the agent has already invented its own packet format and
  the convention's value is lost.
- **Mega-skill**: an exhaustive skill with 500+ lines
  duplicates the convention's docs. Agent never reads it.

## Synthesis

math-coding ships a **single-file skill** (~150 lines):

```
.opencode/skills/math-coding/SKILL.md   # yaml frontmatter + body
.opencode/AGENTS.md                     # project-local hint
```

The skill uses the standard `compatibility: opencode, pi, claude-code`
frontmatter field, so it loads in any agent that follows the
OpenCode skill convention.

**Three install paths** documented in the skill itself:

1. **Global**: `cp -r math-coding/.opencode/skills/math-coding ~/.config/opencode/skills/`
2. **Symlink**: `ln -s ...` for live updates from git pull
3. **Per-project bootstrap**: `sh core/install.sh /path/to/project` (already
   exists in v0.618 via commit 5f34f21)

KISS principle: one file, three install paths, multi-agent
support via standard frontmatter. No references/ subdir,
no commands/ subdir, no separate install.md — all content
lives in the single SKILL.md.

## What this packet commits to

- `.opencode/skills/math-coding/SKILL.md` exists with proper YAML frontmatter
- `.opencode/AGENTS.md` exists as project-local agent hint
- Skill body documents: 5-file structure, epistemic protocol,
  13 shell tools, think-before-Do, install instructions
- Standard frontmatter makes it compatible with opencode,
  pi, claude-code

## What this packet does NOT commit to

- `references/` subdir with linked knowledge — not needed
  (skill body has summary; agent reads `core/theories/*.md`
  for full content)
- `commands/` subdir — not needed (agents already know how to
  invoke `sh core/verify.sh` etc.)
- Separate `install.md` — install instructions live in the
  skill body
- Per-agent code paths — standard YAML frontmatter makes
  the skill multi-agent compatible

## What we don't claim

- This skill **does not** substitute for the convention's
  internal documentation (`core/theories/*.md`, `math/*/decision.md`).
  It's a discoverability layer for agents who don't know
  math-coding exists yet.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/skill-packaging-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/skill-packaging-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/skill-packaging-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/skill-packaging-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/skill-packaging-as-packet/packet.yaml)

## Decision

## Thesis
math-coding's value is **realized through AI agents**, not
just humans. Agents need a discoverable, machine-readable
manifest of the convention: what is it, when to apply it,
what tools it has, what files structure it requires.
OpenCode skills (like `~/.config/opencode/skills/humanize-writer`)
follow a standard format: `SKILL.md` with YAML frontmatter +
Markdown body, located at `~/.config/opencode/skills/<name>/`.
## Antithesis
Two failure modes:
- **Hidden convention**: agents discover math-coding through
  README.md only after exhausting other options. By then,
  the agent has already invented its own packet format and
  the convention's value is lost.
- **Mega-skill**: an exhaustive skill with 500+ lines
  duplicates the convention's docs. Agent never reads it.
## Synthesis
math-coding ships a **single-file skill** (~150 lines):
```
.opencode/skills/math-coding/SKILL.md   # yaml frontmatter + body
.opencode/AGENTS.md                     # project-local hint
```
The skill uses the standard `compatibility: opencode, pi, claude-code`
frontmatter field, so it loads in any agent that follows the
OpenCode skill convention.
**Three install paths** documented in the skill itself:
1. **Global**: `cp -r math-coding/.opencode/skills/math-coding ~/.config/opencode/skills/`
2. **Symlink**: `ln -s ...` for live updates from git pull
3. **Per-project bootstrap**: `sh core/install.sh /path/to/project` (already
   exists in v0.618 via commit 5f34f21)
KISS principle: one file, three install paths, multi-agent
support via standard frontmatter. No references/ subdir,
no commands/ subdir, no separate install.md — all content
lives in the single SKILL.md.
## What this packet commits to
- `.opencode/skills/math-coding/SKILL.md` exists with proper YAML frontmatter
- `.opencode/AGENTS.md` exists as project-local agent hint
- Skill body documents: 5-file structure, epistemic protocol,
  13 shell tools, think-before-Do, install instructions
- Standard frontmatter makes it compatible with opencode,
  pi, claude-code
## What this packet does NOT commit to
- `references/` subdir with linked knowledge — not needed
  (skill body has summary; agent reads `core/theories/*.md`
  for full content)
- `commands/` subdir — not needed (agents already know how to
  invoke `sh core/verify.sh` etc.)
- Separate `install.md` — install instructions live in the
  skill body
- Per-agent code paths — standard YAML frontmatter makes
  the skill multi-agent compatible
## What we don't claim
- This skill **does not** substitute for the convention's
  internal documentation (`core/theories/*.md`, `math/*/decision.md`).

## Task

# skill-packaging — task

## Problem

math-coding is invisible to AI agents who don't know it
exists. They invent their own packet format, miss the
5-file convention, and apply the convention's epistemic
markers without understanding their protocol.

## Desired outcome

A single, well-formed OpenCode skill that:
- Loads automatically when an agent session mentions
  packets, math-coding, or structured decision-tracking
- Tells the agent: where things live, what tools exist,
  what protocol to apply
- Is multi-agent compatible (opencode, pi, claude-code)
- Is one file, ~150 lines, KISS

## Constraints

- One file (`SKILL.md`), no subdirs (no references/, commands/)
- POSIX shell throughout (no external deps)
- Standard YAML frontmatter with `compatibility:` field
  for multi-agent support
- Install paths documented in skill body itself
- End-to-end test: `cp -r math-coding/.opencode/skills/math-coding
  ~/.config/opencode/skills/`
  followed by opencode session restart loads the skill
## Assumptions

```yaml
task_id: skill-packaging
assumptions:
  - id: A1
    statement: "OpenCode skill format (yaml frontmatter + body) is multi-agent compatible"
    status: agent-inferred
    epistemology: fact
    confidence: 0.95
    evidence: |
      Existing skills at ~/.config/opencode/skills/ all use
      `compatibility: opencode, pi, claude-code`. The field is
      standard; agents that don't recognize it ignore the skill.
      See: ~/.config/opencode/skills/humanize-writer/SKILL.md

  - id: A2
    statement: "One SKILL.md (~150 lines) is sufficient discoverability layer"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Long skills (~500 lines) are rarely read end-to-end by
      agents; they skim. A short, focused skill with clear
      links to detailed docs works better. Convention's full
      docs live in core/ and math/ — skill points to them.

  - id: A3
    statement: "Three install paths (cp, symlink, install.sh) cover all user scenarios"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      - cp: simple, works without git
      - symlink: live updates from upstream changes
      - install.sh: integrated with project's bootstrap
      Each path serves different user needs.

  - id: A4
    statement: "Project-local .opencode/AGENTS.md is sufficient for hint layer"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      AGENTS.md is read by opencode automatically when
      present in .opencode/. Convention already has agents.md
      at root; .opencode/AGENTS.md is the project-local
      extension with skill loading hint.

  - id: A5
    statement: "Skill body should NOT duplicate content that already exists in core/ and math/"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Single-source-of-truth principle. Skill summarizes and
      points; convention docs are authoritative. Drift between
      two copies is worse than no copy.

  - id: A6
    statement: "epistemology: proven marker (commit b7a0faa) applies to axiom A4 specifically"
    status: agent-inferred
    epistemology: fact
    confidence: 1.0
    evidence: |
      math-coding-birth/assumptions.yaml A4 has been updated
      to status: user-confirmed, epistemology: proven. Skill
      reflects this for AI agent consumption.
      See: math/math-coding-birth/assumptions.yaml```

## Refinement

# Refinement: skill-packaging

## State

- **pre**: math-coding is invisible to AI agents who don't
  know it exists. Skills at `~/.config/opencode/skills/`
  (humanize-writer, emacs-*, etc.) load automatically; math-coding
  doesn't ship a skill.
- **post**: math-coding ships an OpenCode skill (single SKILL.md,
  ~150 lines) + project-local AGENTS.md. Skill loads automatically
  for any opencode session that mentions math-coding.

## Operation

- Created `.opencode/skills/math-coding/SKILL.md` (one file,
  YAML frontmatter + Markdown body)
- Created `.opencode/AGENTS.md` (project-local hint)
- Created `math/skill-packaging-as-packet/` (5 files documenting
  the decision)
- Smoke-tested: `cp -r` to `/tmp/test-skill-install` works
- Frontmatter parses with python yaml regex

## Mapping (artifact → convention axis)

| Artifact | Axis |
|----------|------|
| `.opencode/skills/math-coding/SKILL.md` | D55 (this packet) |
| `.opencode/AGENTS.md` | D56 (project-local hint) |
| `math/skill-packaging-as-packet/` | D55 owner |

## Invariant preservation

- 47 existing packets still pass `core/verify.sh` after
  addition
- `agents.md` ≤ 60 lines (not touched)
- One file added (`SKILL.md`) + one file added (`AGENTS.md`)
- No new external dependencies

## Test obligation

- `sh core/verify.sh` returns VERIFIED, 0 errors
- SKILL.md frontmatter parses (regex test)
- `cp -r .opencode/skills/math-coding /tmp/test/` works
- After install, the skill is discoverable by opencode

## Runtime check

- After this commit, the skill ships in the math-coding repo
- User can copy to `~/.config/opencode/skills/` to enable
  globally
- Convention's own agents (this codebase's opencode session)
  load the skill automatically via `.opencode/AGENTS.md`

## Cross-reference

Pairs with:

- `core/install.sh` (D50) — already provides project bootstrap
- `math/install-as-packet/` (D50 owner) — install protocol
- `math/math-coding-birth/assumptions.yaml` A4 — proven axiom
- `~/.config/opencode/skills/humanize-writer/SKILL.md` — reference
  for skill format
