# web-ui — read-only viewer for math-coding artifacts

#convention
## Thesis

The convention's artifacts (`math/*/*.md`, `core/coverage.yaml`,
`core/verifier-output.yaml`, `core/theories/*.md`) are plain
text and git-tracked. They are readable in any editor, but not
in a coherent way: a new contributor has to clone, navigate
directories, and piece together 25+ YAML structures. A viewer
that renders the same files as a navigable site lowers the
floor for non-developer contributors (PM, designer) without
changing the convention's primitives.

## Antithesis

Any web UI is one more layer of state. If the viewer keeps
its own copy of the data, drift appears (the site says X, the
repo says Y). If the viewer accepts edits, it competes with
git for source-of-truth authority. If the viewer depends on
a framework, it violates D02 (plain text + git, no
frameworks).

## Synthesis

math-coding's web UI is **read-only**:

- The viewer has no database. The repository is its only
  data source. Pages are generated at build time from the
  files in `math/` and `core/`.
- The viewer has no write endpoint. Edits go through git.
- The viewer has no auth beyond what the host provides.
- The viewer uses minimal tooling (static site generator,
  not a server). Stack choice is deferred; Jekyll or MkDocs
  are sensible defaults; the convention author picks.
- The viewer is itself an OS file under `core/web/`,
  authorised by this packet.

This packet records the design contract. Implementation
opens later, only if a real contributor persona needs it
(designer / PM adopting the convention).

## What this packet commits to

- A design contract: read-only, stateless, source-listed
  under `core/web/`.
- An 8-section UX plan (Home / Packets index / Packet detail /
  Coverage matrix / Theories index / Decision graph /
  Verifier dashboard / Drift report).
- A 3-variant stack comparison (zero-binary, small-binary,
  full-server) with Phase v0.618 default = "do not build
  until triggered".

## What this packet does NOT commit to

- A specific stack choice (Jekyll vs Hugo vs MkDocs) — that
  becomes its own decision-packet if/when triggered.
- A hosting target (gh-pages vs CloudFlare Pages vs
  self-hosted) — same as above.
- A write endpoint or authentication layer.
- A real-time verifier dashboard (could come later via
  GitHub Actions integration).
- Replacing `core/verify.sh` with a web-based verifier.

## Trigger conditions ("until…")

This packet moves from `lifecycle: sketch` to `lifecycle:
working` *only* when:

1. A non-developer role (designer, PM) actively uses the
   convention and reports that `git clone` is a barrier.
2. The Obsidian interop (Phase D axis D5) proves insufficient
   for that role.
3. A hosting target is decided (private vs public repo).

Until all three are true, the convention stays text-only.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/web-ui-as-packet/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/web-ui-as-packet/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/web-ui-as-packet/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/web-ui-as-packet/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/web-ui-as-packet/packet.yaml)

## Decision

#convention
## Thesis
The convention's artifacts (`math/*/*.md`, `core/coverage.yaml`,
`core/verifier-output.yaml`, `core/theories/*.md`) are plain
text and git-tracked. They are readable in any editor, but not
in a coherent way: a new contributor has to clone, navigate
directories, and piece together 25+ YAML structures. A viewer
that renders the same files as a navigable site lowers the
floor for non-developer contributors (PM, designer) without
changing the convention's primitives.
## Antithesis
Any web UI is one more layer of state. If the viewer keeps
its own copy of the data, drift appears (the site says X, the
repo says Y). If the viewer accepts edits, it competes with
git for source-of-truth authority. If the viewer depends on
a framework, it violates D02 (plain text + git, no
frameworks).
## Synthesis
math-coding's web UI is **read-only**:
- The viewer has no database. The repository is its only
  data source. Pages are generated at build time from the
  files in `math/` and `core/`.
- The viewer has no write endpoint. Edits go through git.
- The viewer has no auth beyond what the host provides.
- The viewer uses minimal tooling (static site generator,
  not a server). Stack choice is deferred; Jekyll or MkDocs
  are sensible defaults; the convention author picks.
- The viewer is itself an OS file under `core/web/`,
  authorised by this packet.
This packet records the design contract. Implementation
opens later, only if a real contributor persona needs it
(designer / PM adopting the convention).
## What this packet commits to
- A design contract: read-only, stateless, source-listed
  under `core/web/`.
- An 8-section UX plan (Home / Packets index / Packet detail /
  Coverage matrix / Theories index / Decision graph /
  Verifier dashboard / Drift report).
- A 3-variant stack comparison (zero-binary, small-binary,
  full-server) with Phase v0.618 default = "do not build
  until triggered".
## What this packet does NOT commit to
- A specific stack choice (Jekyll vs Hugo vs MkDocs) — that
  becomes its own decision-packet if/when triggered.
- A hosting target (gh-pages vs CloudFlare Pages vs
  self-hosted) — same as above.
- A write endpoint or authentication layer.
- A real-time verifier dashboard (could come later via
  GitHub Actions integration).
- Replacing `core/verify.sh` with a web-based verifier.
## Trigger conditions ("until…")
This packet moves from `lifecycle: sketch` to `lifecycle:
working` *only* when:
1. A non-developer role (designer, PM) actively uses the
   convention and reports that `git clone` is a barrier.
2. The Obsidian interop (Phase D axis D5) proves insufficient
   for that role.

## Task

# web-ui — task

#convention
## Problem

The convention accumulates 25+ packets and 12+ theories. A new
contributor who has never used git may still want to browse
the convention's intent, lifecycle, and current state. The
question is: should math-coding ship a web UI, and if so,
what does it look like?

## Desired outcome

A decision-packet (`web-ui-as-packet`) that records:

1. The *design contract* — what the viewer may and may not do
2. The *UX plan* — which 8 views render which source files
3. The *stack comparison* — three stack variants with a
   default of "do not build yet"
4. The *trigger conditions* that move this packet from
   `lifecycle: sketch` to `lifecycle: working`

## Constraints

- This packet does NOT create a UI. It records the design
  contract that a future UI must satisfy.
- The viewer must be read-only. No writes through the UI.
- The viewer must be stateless. Repository is the only
  data source.
- The viewer must be source-listed under `core/web/` if and
  when implemented (and authorised by this packet).
- This packet has `decision: needed` until trigger conditions
  are met. It stays in `lifecycle: sketch`.

## Assumptions

```yaml
task_id: web-ui-as-packet
assumptions:
  - id: A1
    statement: "A read-only, stateless viewer is consistent with D02 (plain text + git, no frameworks) if implemented with a static site generator"
    status: agent-inferred
    epistemology: fact
    confidence: 0.9
    evidence: |
      Jekyll / MkDocs / Hugo / 11ty are generators that
      consume markdown and YAML at build time. Output is
      static HTML. No runtime framework is required of
      convention authors who only edit text.
      See: core/coverage.yaml D02

  - id: A2
    statement: "The viewer's only data source is the repository itself (no separate database)"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      Drift between repo and viewer is the most common failure
      mode for documentation sites. Eliminating the
      viewer's own state eliminates the failure mode.
      See: packet:phase-c-harmony-as-packet/decision.md

  - id: A3
    statement: "The viewer does NOT expose a write endpoint; edits go through git only"
    status: judgment
    epistemology: judgment
    confidence: 0.95
    evidence: |
      A web-based edit form competes with the verify.sh
      protocol for authority; if it's faster, contributors
      skip the convention. Without a write endpoint, the
      flow stays consistent.
      See: agents-md-as-packet/refinement.md#edit-protocol

  - id: A4
    statement: "8 views (Home, Packets, Packet detail, Coverage, Theories, Decision graph, Verifier dashboard, Drift) cover the convention's visible state without overload"
    status: judgment
    epistemology: judgment
    confidence: 0.85
    evidence: |
      Each view maps 1-to-1 onto a source file or set of
      files. Adding more views risks duplication; removing
      any one hides a distinct facet of the convention.
      See: packet:phase-d-development-as-packet/decision.md#D5

  - id: A5
    statement: "Trigger conditions (non-developer adoption + Obsidian insufficient + hosting decided) are necessary before moving to lifecycle: working"
    status: judgment
    epistemology: judgment
    confidence: 0.9
    evidence: |
      Building a UI without users is theatre. The
      convention's load-bearing principle is "epistemically
      honest", which means: don't claim need before need is
      proven.
      See: packet:math-coding-birth/refinement.md#epistemics
```

## Refinement

# Refinement: web-ui

#convention
## State

- **pre**: convention has 25 packets, 12 theories, 41
  decisions, 1 verifier. Artifacts are text files; navigation
  is `ls math/`, `cat core/coverage.yaml`, `git log`. No
  viewer.
- **post**: a packet records the design contract for a
  future web viewer. No viewer is built yet — this is the
  decision, not the implementation.

## Operation

- Created `math/web-ui-as-packet/` with 5 files
- No `core/web/` directory created (it stays empty until
  triggers met)

## Mapping (design contract → future impl)

| Contract clause          | Future artifact under `core/web/`       |
|--------------------------|------------------------------------------|
| Read-only                | viewer has no API key, no POST handler  |
| Stateless                | build step regenerates from `git pull`  |
| Source-listed            | viewer files commit-tracked             |
| Authorised by packet     | `math/web-ui-as-packet/` reference       |
| OS file authorised       | this packet records the authorisation   |

## Invariant preservation

- `AGENTS.md` ≤ 60 lines (this packet does not touch it)
- `sh core/verify.sh` returns VERIFIED, 0 errors
- No write to `core/verify.sh`, `core/coverage.yaml`, or
  any other shared file

## Test obligation

- 26 packets total pass the verifier (25 existing + this one)
- This packet is in `lifecycle: sketch` until triggers met

## Runtime check

- Future convention author re-reads this packet when a
  non-developer (PM, designer, researcher) reports that
  git-clone is a barrier.

## Cross-reference

Pairs with `phase-d-development-as-packet` (which mentions
"no web UI for Phase D"). This packet formalises the
"until when" of that deferral.

