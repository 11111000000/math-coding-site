# Onboarding math-coding into an existing project

This guide describes how to adopt math-coding in a production
project — a web service, a compiler, a kernel module, anything
with native code structure.

## Prerequisites

- A working project with code (in any language)
- `sh`, `awk`, `grep`, `sed`, `find`, `git` available
- No other tools required (math-coding is plain text + git)

## Step 1: Decide where packets live

Default: `specs/`. The choice matters because your team will type this path often.

Create `.mathcodingrc` at the project root:

```yaml
# .mathcodingrc
packets_dir: specs
convention_version: 1.2.0
```

If you do not create `.mathcodingrc`, math-coding uses `specs/` by default.

## Step 2: Install the convention tools

Copy the convention's tools into your project (or reference them from your tooling):

```sh
# Option A: vendor the tools in your repo
mkdir -p .mathcoding
cp /path/to/math-coding/core/init-packet.sh  .mathcoding/
cp /path/to/math-coding/core/verify.sh        .mathcoding/
cp /path/to/math-coding/core/packet-schema.md  .mathcoding/

# Option B: call the tools from a vendored or system path
# (your build system references the convention repo)
```

The `core/` directory contains the convention itself plus two tools: `init-packet.sh` (creates packets) and `verify.sh` (structural verification). Optionally, `specs/self-check/verify-structural.sh` provides recursive verification.

No other files are copied into your project. Your code stays untouched.

## Step 3: Create your first packet

```sh
sh .mathcoding/init-packet.sh hello-world
```

This creates `specs/hello-world/` with the three required files. Open them in your editor, fill in:

- `task.md` — Problem (what is missing?), Desired outcome (what success looks like), Constraints (what limits the solution)
- `assumptions.yaml` — at least one assumption with an epistemic marker (`fact`, `hypothesis`, `judgment`, `unknown`)
- `packet.yaml` — adjust `lifecycle`, `substrate`, `rigor`, `decision` fields

## Step 4: Run the verifier

```sh
# Structural check (fast)
sh .mathcoding/verify.sh

# Recursive check (slower, includes coverage gap detection)
sh /path/to/math-coding/specs/self-check/verify-structural.sh
```

The verifier exits 0 on success and prints VERIFIED, or exits 1 with the list of issues.

## Step 5: Promote lifecycle to `verified`

When the verifier returns `VERIFIED`:
1. Update `packet.yaml: lifecycle: verified`
2. Commit
3. (Optional) Run the verifier once more in CI

## Reference

- See [hello-world example](https://github.com/11111000000/math-coding/tree/main/examples/minimal-packet) — 5-line POSIX sh packet
- See [login-feature example](https://github.com/11111000000/math-coding/tree/main/examples/external-project) — bcrypt example in `specs/`
- Read [core/core.md](https://github.com/11111000000/math-coding/blob/main/core/core.md) for the full convention
- Read [Packet schema](./packet-schema.md) for the machine-readable schema

## When the convention version changes

The math-coding repo is versioned (e.g., `v1.1.0`, `v1.2.0`).
When the version changes:
1. Update `.mathcodingrc: convention_version`
2. Re-run `sh .mathcoding/verify.sh` and `sh .../specs/self-check/verify-structural.sh`
3. If new fields appear in `packet.yaml`, update affected packets

The convention-version change **does not automatically** migrate your packets. You stay on the version you pinned until you explicitly upgrade.
