# math-coding v1.0 documentation site

This repository hosts the rendered documentation site for
[math-coding v1.0](https://github.com/11111000000/math-coding).

The site is built by the OCaml runtime in the main math-coding
repository and pushed here on every commit to `main`.

## Build

```sh
# From the main math-coding repo:
dune build
./math-coding site
# This regenerates dist/ which is what gets deployed here.
```

## Source

The source content is the `math/<name>/packet.md` files in the
main math-coding repository. Each packet becomes one HTML page;
axiom packets get a colored row in the index.

The build tool reuses the canonical parser (`Math_coding_lib.Parse`)
so packet format is defined once.

## Layout

```
index.html          46-packet table with axiom rows highlighted
axioms.html        seven axioms in theorem blocks
installing.html    prerequisites, install, use
math/<name>.html   per-packet page
assets/tokens.css  paper-and-ink typography
```

No JavaScript. No CDN. No JS framework.
