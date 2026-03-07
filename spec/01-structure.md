# Directory Structure

Skillbooks extend Agent Skills directory conventions. Skillbook directories MUST follow these rules.

## Full Directory Tree

```
my-book/
├── SKILL.md              ← required: agent entry point + TOC (served free)
├── README.md             ← required: human-readable overview (catalog content)
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

- Section folders MUST use `NN-topic-name/` where `NN` is a 2-digit zero-padded number and `topic-name` is lowercase kebab-case.
- Section overviews MUST be named `00-overview.md` and MUST be the first file in each section folder.
- Content pages MUST use `NN-page-name.md` where `NN` is a 2-digit zero-padded number from `01` onward.
- File and folder names MUST be lowercase and hyphen-separated. Spaces are not allowed.

## What Belongs Where

- Agent entry point and table of contents MUST be in `SKILL.md`.
- Human-readable catalog overview MUST be in `README.md`.
- Book metadata MUST be in `book.json`.
- Section overview and file index MUST be in `NN-section/00-overview.md`.
- Content pages MUST be in section folders as `01-page.md` through `NN-page.md`.
- Tag lookup MAY be provided in `TAG-INDEX.json`.
- Source documents MUST be in `sources/`.
- Generated verification artifacts in `.verify/` MUST NOT be authored manually.

## Book Namespace

Books are hosted at `skillbooks.ai/<name>/`. Names are first-come, first-served (similar to npm package names). Book names MUST NOT use author prefixes or namespace separators.
