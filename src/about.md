# About this site

This site is the rendered documentation for [math-coding](https://github.com/11111000000/math-coding).

## How it is built

The site is generated with [mdBook](https://rust-lang.github.io/mdBook/) — a static site generator written in Rust, distributed as a single binary. It was created for the Rust language documentation and is now used by Solana, the Rust Async Book, and many other Rust-language documentation projects.

Content is sourced from the [main math-coding repository](https://github.com/11111000000/math-coding). A CI workflow on this repository:

1. Pulls the markdown from the main repository
2. Generates the static site with `mdbook build`
3. Deploys to GitHub Pages

The source of truth is **always the main repository**. This site is just a rendered surface.

## Design

The visual design follows an academic-monospace aesthetic:

- **Type**: IBM Plex Serif for body, JetBrains Mono for display
- **Color**: single accent (terracotta `#c7472b`), neutrals otherwise
- **Math**: MathJax for inline and display LaTeX
- **Search**: built-in mdBook search

The design reflects the convention's ethos: formalism, restraint, mathematical clarity.

## Source

- Repository: [github.com/11111000000/math-coding](https://github.com/11111000000/math-coding)
- This site: [github.com/11111000000/math-coding-site](https://github.com/11111000000/math-coding-site)
- License: [License for the Benefit of All Living Beings](./license.html) — free for the benefit of all living beings, attribution to Petr Kosov <11111000000@email.com>