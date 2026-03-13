# Directory Structure

Every skillbook follows this layout:

```
eu-ai-act/
├── SKILL.md              ← required: agent entry point + TOC (served free)
├── README.md             ← required: human-readable overview (populates catalog)
├── package.json          ← required: project manifest + skillbook config
├── TAG-INDEX.json        ← optional: O(1) tag → pages lookup (served free)
├── sources/              ← optional, required for verified books
│   ├── SOURCES.md        ← index of source files
│   └── [source files]    ← .txt, .pdf, .md — authoritative materials
├── 01-foundations/
│   ├── 00-overview.md    ← section overview + file index
│   ├── 01-purpose.md     ← content page
│   └── 02-scope.md
├── 02-risk-classification/
│   ├── 00-overview.md
│   ├── 01-four-tiers.md
│   └── ...
└── .verify/              ← generated verification artifacts (do not author)
    ├── AUDIT-MANIFEST.md
    └── VERIFY-REPORT.md
```

## What Belongs Where

| Content type | Goes in |
|---|---|
| Agent entry point + TOC | `SKILL.md` |
| Human-readable overview (catalog content) | `README.md` |
| Project manifest + skillbook config | `package.json` |
| Section overview + file index | `NN-section/00-overview.md` |
| Content pages | `NN-section/01-page.md` through `NN-page.md` |
| Tag → pages lookup index | `TAG-INDEX.json` |
| Source documents (PDFs, regulations, papers) | `sources/` |
| Generated verification artifacts | `.verify/` |

Do not put source documents in content directories, and do not put content pages in `sources/`.

## Repo-Level Files

When a skillbook is published as a repository, standard repo files coexist alongside the
skillbook structure:

- `LICENSE` / `LICENSE-*` — repository license files
- `CONTRIBUTING.md` — contribution guidelines
- `CHANGELOG.md` — project changelog
- `.gitignore`, `.github/` — repo tooling

These are not part of the skillbook content. They're the same files any open-source project
would include. The skillbook format ignores them — `skillbook validate` only checks
skillbook-specific files.

---

[← Previous: Agent Skills](01-agent-skills.md) | [↑ Section](00-overview.md) | [Next: Naming Conventions →](03-naming-conventions.md) | [🏠 Home](../SKILL.md)
