# Directory Structure

Every Skillbook has a portable root skill and project manifest. It MAY add independent
capability entries, human-navigable pages, indexed resources, or any combination.

```text
thrv-jtbd/
├── SKILL.md                 ← required: agent entry point and capability routing
├── README.md                ← required: human-readable catalog overview
├── package.json             ← required: project manifest and structured config
├── skills/                  ← optional: independently activatable capabilities
│   ├── frame-market/
│   │   └── SKILL.md
│   └── map-job/
│       └── SKILL.md
├── scripts/                 ← optional: deterministic search, fetch, or workflow tools
│   ├── search_resources.py
│   └── fetch_resource.py
├── knowledge/               ← optional: author-defined indexed resource layout
│   ├── index.sqlite
│   └── source/              ← optional in a thin hosted installation
├── 01-foundations/          ← optional: human-navigable page sections
│   ├── 00-overview.md
│   └── 01-purpose.md
├── TAG-INDEX.json           ← optional: simple tag → page lookup (served free)
├── eval/                    ← optional: capability evidence (summary served free)
│   ├── EVAL.md
│   ├── eval-report.json
│   └── raw/                 ← raw model responses (not necessarily served)
├── sources/                 ← optional: verification sources for authors/tooling
│   ├── SOURCES.md
│   └── [source files]
└── .verify/                 ← generated verification artifacts
```

## What Belongs Where

| Content | Goes in |
|---|---|
| Root agent discovery, shared rules, capability routing | `SKILL.md` |
| Structured capability, resource, delivery, and catalog config | `package.json` (`skillbook`) |
| Independently activatable task procedures | `skills/<capability>/SKILL.md` |
| Deterministic executable operations | `scripts/` |
| Detailed on-demand references for a capability | Its Agent Skills `references/` directory |
| Large indexed corpus and pointer index | Author-declared path such as `knowledge/` |
| Human-navigable book pages | Numbered section directories |
| Human-readable product overview | `README.md` |
| Simple tag → page lookup | `TAG-INDEX.json` |
| Capability eval summaries and records | `eval/` |
| Source documents used for verification | `sources/` |
| Generated verification artifacts | `.verify/` |

Do not duplicate the same material across capability entries, pages, and indexed resources.
Keep procedures in capability entry points and load detailed material only when needed.

## Navigation Patterns

A Skillbook MAY use either or both patterns:

1. **TOC navigation** — best for a bounded set of human-readable pages. Numbered section folders
   use `00-overview.md` and descriptive entries in the root TOC.
2. **Indexed retrieval** — best for large or agent-optimized corpora. The root explains how to
   search pointers and fetch exact resources; the full corpus does not need to appear in SKILL.md.

Every resource needed by a capability MUST be discoverable through at least one declared pattern.

## Repo-Level Files

Standard repository files such as `LICENSE`, `CONTRIBUTING.md`, `CHANGELOG.md`, `.gitignore`,
and `.github/` MAY coexist with the Skillbook. Validation ignores them unless another declared
contract references them.

---

[← Previous: Agent Skills](01-agent-skills.md) | [↑ Section](00-overview.md) | [Next: Naming Conventions →](03-naming-conventions.md) | [🏠 Home](../SKILL.md)
