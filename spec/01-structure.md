# Directory Structure

Skillbooks extend the Agent Skills directory conventions. All Skillbook directories MUST follow these structural rules to ensure compatibility with agent tooling and catalog systems.

## Full Directory Tree

```
my-book/
├── SKILL.md              ← required: agent entry point + TOC (served free)
├── README.md             ← required: human-readable overview (populates catalog)
├── book.json             ← required: book metadata
├── TAG-INDEX.json        ← optional: O(1) tag → pages lookup (served free)
├── sources/              ← optional, required for verified books
│   ├── SOURCES.md        ← index of source files
│   └── [source files]    ← .txt, .pdf, .md — authoritative materials
├── 01-introduction/
│   ├── 00-overview.md    ← section overview + file index
│   ├── 01-welcome.md     ← content page
│   └── 02-getting-started.md
├── 02-core-concepts/
│   ├── 00-overview.md
│   ├── 01-principles.md
│   └── ...
└── .verify/              ← generated verification artifacts (do not author)
    ├── AUDIT-MANIFEST.md
    └── VERIFY-REPORT.md
```

## Naming Conventions

- **Section folders** MUST use the format `NN-topic-name/` where `NN` is a 2-digit zero-padded number, followed by kebab-case lowercase text.
- **Section overviews** MUST be named `00-overview.md` and placed as the first file in every section folder.
- **Content pages** MUST be named `01-` through `99-topic-name.md`, using a 2-digit zero-padded prefix followed by kebab-case lowercase text.
- **No spaces permitted.** All folder and file names MUST be lowercase with hyphens as word separators.

## What Belongs Where

- The agent entry point and table of contents MUST go in `SKILL.md`.
- Human-readable overview for catalog display MUST go in `README.md`.
- Book metadata (title, author, version, tags) MUST go in `book.json`.
- Section overview with file index for each section MUST go in `NN-section/00-overview.md`.
- Content pages MUST go in their respective section folders as `01-page.md` through `NN-page.md`.
- Tag-to-pages lookup index for fast querying MAY go in `TAG-INDEX.json`.
- Source documents such as PDFs, regulations, and reference papers MUST go in the `sources/` directory.
- Generated verification artifacts MUST NOT be authored manually; they reside in `.verify/`.

## Book Namespace

Books are hosted at the top level of the namespace: `skillbooks.ai/<name>/`. Book names are allocated first-come, first-served, following the npm package model. Authors MUST NOT use a prefix or namespace separator to claim names; the first valid submission for a given name obtains ownership.
