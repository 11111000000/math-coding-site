# Example: login-feature (external project)

# Login feature — math-coding packet in an external project

Demonstrates how to apply math-coding in a foreign project.
The project has its own structure (e.g., `src/`, `tests/`,
`lib/`). math-coding is a **layer on top**, not a replacement.

## Layout (v1.1.2+)

```
examples/external-project/                 ← project root
├── .mathcodingrc                          ← convention config
├── README.md
├── src/                                   ← code (project root level)
│   └── login.sh
├── specs/                                 ← packets
│   └── login-feature/
│       ├── README.md
│       ├── packet.yaml                    ← manifest
│       ├── task.md                        ← problem, outcome, constraints
│       ├── assumptions.yaml               ← epistemic context
│       ├── refinement.md                  ← spec → impl mapping
│       ├── verifier-output.yaml           ← verdict artifact
│       ├── test.sh                        ← smoke test (in this dir)
│       └── verify.sh                      ← local verifier (in this dir)
```

The packet (`specs/login-feature/`) holds **only intent**.
Code lives at the project root in `src/`. `test.sh` and
`verify.sh` are tools that live with the packet because they
operate on the packet's verifier-output.yaml.

This matches the convention's documented guidance:
> 1. `mkdir -p specs/my-feature` — packet in `specs/`
> 2. Edit the 3 required files
> 3. `sh /path/to/math-coding/core/verify.sh`
> 4. Write code in `src/` — **separate from specs/**

v1.1.0 had `specs/login-feature/src/login.sh` (code inside
packet). v1.1.2 fixes the layout.

## Apply to your project

```sh
# In your project root
$ cat > .mathcodingrc <<EOF
packets_dir: specs
convention_version: 1.0.0
rigor: light
EOF

$ mkdir -p specs/my-feature
$ # Copy from math-coding/examples/minimal-packet/
$ # Edit the 3 required files
$ # Write code in src/
$ sh /path/to/math-coding/core/verify.sh
```

The convention-repo (`math-coding`) and your project are
**separate** repositories. Your project has `.mathcodingrc`
pointing to `specs/`, the convention-repo is referenced for
tools.

## Why src/ outside specs/

- **Intent vs implementation:** the packet documents *what*
  and *why*; code is *how*. Mixing them muddies both.
- **Multiple packets can share code:** a `src/utils.sh` can be
  referenced by many `specs/<feature>/` packets without
  duplicating the implementation.
- **Convention says so:** the convention's README and
  `core/core.md` both state "code lives in `src/`, separate
  from specs/". The examples just hadn't caught up.
