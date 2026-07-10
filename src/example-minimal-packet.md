# Example: hello-world (minimal packet)

# Hello world — minimal math-coding packet

Demonstrates the smallest possible working packet. The packet
(intent) is **separate from the code** (implementation).

## Layout (v1.1.2+)

```
examples/minimal-packet/                  ← packet (intent)
├── README.md
├── packet.yaml                           ← manifest
├── task.md                               ← problem, outcome, constraints
├── assumptions.yaml                      ← epistemic context
├── refinement.md                         ← spec → impl mapping
├── verifier-output.yaml                  ← verdict artifact
├── test.sh                               ← smoke test (in this dir)
└── verify.sh                             ← local verifier (in this dir)

examples/minimal-packet-code/             ← code (separate)
└── src/feature.sh                        ← 5 lines of POSIX sh
```

The packet is the **intent before the code**. Code lives at
project level, in a sibling directory. The convention says:
"The packet is separate from code; the packet is the intent
before the code." v1.1.0/1.1.1 violated this by storing
`src/` inside the packet. v1.1.2 fixes the layout.

## Run

```sh
$ sh verify.sh
```

If the script prints "OK: hello-world" and writes a
`verifier-output.yaml` with verdict VERIFIED, the packet is
correct.

## What's in here

- `packet.yaml` — manifest (task_id hello-world, lifecycle verified)
- `task.md` — intent (print "hello world" to stdout)
- `assumptions.yaml` — 4 assumptions about /bin/sh availability
- `refinement.md` — spec state → impl state mapping
- `test.sh` — checks output matches and exit code is 0
- `verify.sh` — runs test.sh, writes verdict to verifier-output.yaml
- `verifier-output.yaml` — verdict artifact

Code is in `../minimal-packet-code/src/feature.sh` (sibling
directory). The path is computed by `test.sh` from its own
location so the verifier is robust to being invoked from
the project root.
