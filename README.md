# math-coding site

This is the rendered documentation site for [math-coding](https://github.com/11111000000/math-coding).

The site is generated with [mdBook](https://rust-lang.github.io/mdBook/) — a single Rust binary, similar in spirit to math-coding's own Daō ethos. The source of truth is the main repository; this site is just a surface.

## How content is sourced

Content is automatically synced from the [main math-coding repository](https://github.com/11111000000/math-coding) on every push to `main`. The sync script lives in `scripts/sync-from-main.sh` and:

- Pulls the latest markdown from the main repo
- Strips frontmatter (mdBook does not need it)
- Renames files to match the structure defined in `src/SUMMARY.md`
- Stages everything in `src/` for mdBook

If you edit content in the main repo, this site updates automatically. You should **not** edit files in `src/` directly — they will be overwritten on the next sync.

## Local development

mdBook is a single Rust binary. Install it with `cargo install mdbook` or download from [GitHub releases](https://github.com/rust-lang/mdBook/releases).

```sh
# One-time: clone the theme dependencies (none — mdbook is self-contained)
git clone https://github.com/11111000000/math-coding-site.git
cd math-coding-site

# Build
mdbook build

# Serve locally with live reload
mdbook serve --port 1313
```

Open `http://localhost:1313/` to see the site.

To preview with the latest content from the main repo:

```sh
sh scripts/sync-from-main.sh
mdbook serve
```

## Structure

- `book.toml` — mdBook configuration
- `src/SUMMARY.md` — table of contents (defines navigation)
- `src/` — chapter content (one file per chapter; content is synced from main repo)
- `theme/custom.css` — academic-monospace styling overlay
- `scripts/sync-from-main.sh` — content sync from main repo
- `.github/workflows/deploy.yml` — CI: sync → build → deploy to Pages

## Design

The visual design follows an academic-monospace aesthetic:

- **Type**: IBM Plex Serif for body, JetBrains Mono for display
- **Color**: single accent (terracotta `#c7472b`), neutrals otherwise
- **Math**: MathJax for inline and display LaTeX
- **Search**: built-in mdBook search

The design reflects the convention's ethos: formalism, restraint, mathematical clarity.

## License

The site content is under [CC-BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), same as the main repository. The site infrastructure (book.toml, theme/, scripts/) is part of the same license.