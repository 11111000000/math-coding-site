# 03-material

This packet realises [[docs/axioms.md#a3-material-basis-substrate|axiom Material Basis]].

## Thesis

The convention lives in plain text, in git, and runs on a
POSIX shell. No other substrate is required.

Three pillars:

  plain text — every artifact is a `.md`, `.yaml`, or `.sh`
  file. No binary blobs. No JSON-with-comments. No XML.
  Anyone with `cat` and an editor can read the convention.

  git — every change carries a SHA. History is
  append-only. Cloning the repository recreates the entire
  history on a new machine. Branches, tags, and reflog are
  all available without external services.

  POSIX — every script in `core/` runs on `dash`, `bash`,
  or `busybox sh`. No `bash` extensions. No Python. No JVM.
  No Node. A minimal Linux install with `git` and `sh` is
  sufficient.

These three pillars are independent but mutually
reinforcing. Plain text is readable across decades. Git
preserves the ledger across decades. POSIX runs across
decades.

## Antithesis

A convention that depends on a language, framework, IDE,
or vendor outlives its usefulness only as long as that
substrate survives.

A convention that depends on Python 3.12 dies when the
project moves to Python 3.13 and the dependency changes.
A convention that depends on a specific JSON library dies
when the library is deprecated. A convention that depends
on GitHub Actions dies when the project moves to GitLab.

The history of software is a graveyard of conventions
that depended on a single substrate. The cure is not to
find the right substrate. The cure is to depend on
substrates that are older than the convention itself.

Plain text (1960s), git (2005), POSIX (1988). These three
pillars are older than most projects that will adopt
math-coding. They will outlive the convention.

## Synthesis

A3 fixes the material basis of math-coding:

  packet.yaml      — plain text
  decision.md      — plain text
  task.md          — plain text
  assumptions.yaml — plain text (yaml subset)
  refinement.md    — plain text
  theories/*.md    — plain text
  core/*.sh        — POSIX shell
  core/ops/*.sh    — POSIX shell
  LICENSE          — plain text
  AGENTS.md        — plain text
  README.md        — plain text
  .git/            — git
  .gitignore       — plain text
  math-coding      — POSIX shell

Every file is one of: `.md`, `.yaml`, `.sh`. The convention
itself is a git repository. The history is git's history.

## A worked example: what breaks if A3 fails

Suppose a contributor commits a `.docx` file containing the
specification of one of the axioms. The file passes code
review because reviewers do not open it. Three years later,
a new contributor cannot read the file because the
contributor's `.docx` is from Office 365 and the new
contributor only has LibreOffice. The specification is now
inaccessible. The convention has lost one of its axioms
in practice, even though every commit was green.

This is the failure mode A3 forbids. The verifier
(`core/check/verify.sh`) would not catch a binary file —
verifiers check structure, not format — but the *convention*
catches it. The convention's `AGENTS.md` says: plain text
only. The next reviewer reads the convention before
reviewing the file, sees the rule, and rejects the binary
contribution. The rule catches what the verifier cannot.

Suppose a contributor writes a `core/install.sh` that
requires Python 3.12. The script is plain text; the rule
is satisfied. The script is in git; history is preserved.
But the script is not POSIX. On a host without Python
3.12 — a fresh container, an old server, a macOS system
where Homebrew has not been updated — the script fails.
The convention has lost its material basis in practice.
The `tests/run.sh` axiom-Self-Application self-application would
exit non-zero if the convention were installed on such a
host; the bug is caught the next time the convention runs
axiom Self-Application.

These two examples are not hypothetical. They are
failure modes of conventions that depended on
substrates. A3 forbids them by making the substrate
explicit.

## Surface impact

touches: file extensions (.md/.yaml/.sh), git history
(packet.yaml:applications[].sha), shell runtime (POSIX sh
in `core/*.sh`)

## Proof

The evidence is `tests/run.sh` which runs 8 self-tests
against the convention's own state. The 8/8 PASS
result is the witness that the three pillars (plain text,
git, POSIX) hold at this commit.

If a future commit introduces a binary file, a
non-POSIX script, or a non-git change, one or more of the
8 self-tests fails. The convention detects the drift and
exits non-zero. axiom Self-Application holds only as long as A3 holds.

## Packet files

- [decision.md](https://github.com/11111000000/math-coding/blob/main/math/03-material/decision.md)
- [task.md](https://github.com/11111000000/math-coding/blob/main/math/03-material/task.md)
- [assumptions.yaml](https://github.com/11111000000/math-coding/blob/main/math/03-material/assumptions.yaml)
- [refinement.md](https://github.com/11111000000/math-coding/blob/main/math/03-material/refinement.md)
- [packet.yaml](https://github.com/11111000000/math-coding/blob/main/math/03-material/packet.yaml)

## Decision

This packet realises [[docs/axioms.md#a3-material-basis-substrate|axiom Material Basis]].
## Thesis
The convention lives in plain text, in git, and runs on a
POSIX shell. No other substrate is required.
Three pillars:
  plain text — every artifact is a `.md`, `.yaml`, or `.sh`
  file. No binary blobs. No JSON-with-comments. No XML.
  Anyone with `cat` and an editor can read the convention.
  git — every change carries a SHA. History is
  append-only. Cloning the repository recreates the entire
  history on a new machine. Branches, tags, and reflog are
  all available without external services.
  POSIX — every script in `core/` runs on `dash`, `bash`,
  or `busybox sh`. No `bash` extensions. No Python. No JVM.
  No Node. A minimal Linux install with `git` and `sh` is
  sufficient.
These three pillars are independent but mutually
reinforcing. Plain text is readable across decades. Git
preserves the ledger across decades. POSIX runs across
decades.
## Antithesis
A convention that depends on a language, framework, IDE,
or vendor outlives its usefulness only as long as that
substrate survives.
A convention that depends on Python 3.12 dies when the
project moves to Python 3.13 and the dependency changes.
A convention that depends on a specific JSON library dies
when the library is deprecated. A convention that depends
on GitHub Actions dies when the project moves to GitLab.
The history of software is a graveyard of conventions
that depended on a single substrate. The cure is not to
find the right substrate. The cure is to depend on
substrates that are older than the convention itself.
Plain text (1960s), git (2005), POSIX (1988). These three
pillars are older than most projects that will adopt
math-coding. They will outlive the convention.
## Synthesis
A3 fixes the material basis of math-coding:
  packet.yaml      — plain text
  decision.md      — plain text
  task.md          — plain text
  assumptions.yaml — plain text (yaml subset)
  refinement.md    — plain text
  theories/*.md    — plain text
  core/*.sh        — POSIX shell
  core/ops/*.sh    — POSIX shell
  LICENSE          — plain text
  AGENTS.md        — plain text
  README.md        — plain text
  .git/            — git
  .gitignore       — plain text
  math-coding      — POSIX shell
Every file is one of: `.md`, `.yaml`, `.sh`. The convention
itself is a git repository. The history is git's history.
## A worked example: what breaks if A3 fails
Suppose a contributor commits a `.docx` file containing the
specification of one of the axioms. The file passes code
review because reviewers do not open it. Three years later,
a new contributor cannot read the file because the
contributor's `.docx` is from Office 365 and the new
contributor only has LibreOffice. The specification is now
inaccessible. The convention has lost one of its axioms
in practice, even though every commit was green.
This is the failure mode A3 forbids. The verifier
(`core/check/verify.sh`) would not catch a binary file —
verifiers check structure, not format — but the *convention*
catches it. The convention's `AGENTS.md` says: plain text
only. The next reviewer reads the convention before
reviewing the file, sees the rule, and rejects the binary
contribution. The rule catches what the verifier cannot.
Suppose a contributor writes a `core/install.sh` that
requires Python 3.12. The script is plain text; the rule
is satisfied. The script is in git; history is preserved.
But the script is not POSIX. On a host without Python
3.12 — a fresh container, an old server, a macOS system
where Homebrew has not been updated — the script fails.
The convention has lost its material basis in practice.
The `tests/run.sh` axiom-Self-Application self-application would
exit non-zero if the convention were installed on such a
host; the bug is caught the next time the convention runs
axiom Self-Application.
These two examples are not hypothetical. They are
failure modes of conventions that depended on
substrates. A3 forbids them by making the substrate
explicit.
## Surface impact
touches: file extensions (.md/.yaml/.sh), git history
(packet.yaml:applications[].sha), shell runtime (POSIX sh
in `core/*.sh`)
## Proof
The evidence is `tests/run.sh` which runs 8 self-tests
against the convention's own state. The 8/8 PASS
result is the witness that the three pillars (plain text,
git, POSIX) hold at this commit.
If a future commit introduces a binary file, a
non-POSIX script, or a non-git change, one or more of the

## Task

# 03-material

## Problem

On what substrate does the convention live? What runs
the verifier? What stores the history?

## Desired outcome

A substrate axiom — A3 — that fixes plain-text, git, and
POSIX as the three pillars of the convention's material
basis.

## Constraints

- Plain text only. No binary blobs.
- Append-only history. Git is sufficient; nothing else is
  needed.
- POSIX shell. The verifier must run on a minimal POSIX
  environment without external dependencies.
## Assumptions

```yaml
task_id: 03-material
assumptions:
  - id: A1
    statement: "plain-text files survive all tooling changes"
    status: user-confirmed
    epistemology: judgment
    evidence: |
      Text formats from the 1970s are still readable. JSON-with-
      comments from 2020 may not be. The convention bets on
      the older substrate.
  - id: A2
    statement: "git is sufficient as append-only ledger"
    status: user-confirmed
    epistemology: judgment
    evidence: |
      Every convention artifact carries a git SHA. History
      is preserved across machines by `git clone` alone.
  - id: A3
    statement: "POSIX shell is sufficient as runtime"
    status: agent-inferred
    epistemology: fact
    confidence: 0.97
    evidence: |
      Every core/ script uses only POSIX-defined utilities
      (test, awk, sed, grep, git, find, mktemp, printf).
      Verified to run on dash and busybox sh.```

## Refinement

# Refinement: 03-material

## State

- pre: convention artifacts scattered across formats and
  runtimes — unreadable in twenty years.
- post: convention artifacts in plain text, history in
  git, runtime in POSIX. All three pillars preserved.

## Operation

Enforce plain-text in every packet. Enforce git as the
only history mechanism. Enforce POSIX in every core/ script.

## Mapping

| concern | substrate |
|---------|-----------|
| packet artifacts | plain-text (.yaml, .md) |
| history | git (SHA, reflog, tag) |
| runtime | POSIX shell (dash, ash, busybox sh) |

## Invariant preservation

- No packet may include a binary blob.
- No core/ script may depend on bash, Python, or JVM.
- Every change must carry a git SHA in `applications:`.

## Test obligation

- shellcheck or POSIX-only check on every core/ script.

## Runtime check

- axiom Self-Application — convention verifies its own material basis.
