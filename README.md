# skillbook

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Spec Version](https://img.shields.io/badge/spec-v1.1-green.svg)](spec/)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-v1.0+-orange.svg)](https://agentskills.io)

> Specification and tooling for deep, commercial-grade AI agent knowledge bases

Skillbooks are an extension of the Agent Skills open standard that enable textbook-depth content for AI agents. They provide structured multi-page knowledge bases with per-page micropayment pricing, credit-based access control, and commercial publishing capabilities.

## Relationship to Agent Skills

Every skillbook's `SKILL.md` is a valid Agent Skills file. Any tool that understands the Agent Skills standard can discover and read a skillbook's entry point. Skillbooks extend this foundation with additional metadata, multi-page structure, and commercial features while maintaining backward compatibility.

## Key Features

- **Multi-page content** — Structured section/page layout with explicit table-of-contents entries
- **Micropayment support** — Per-page pricing and credit-based access control
- **Commercial publishing** — Built-in monetization primitives for content creators
- **Verification pipeline** — Source attribution and content verification system
- **Catalog metadata** — `book.json` for discovery and search
- **Tag-based lookup** — optional `TAG-INDEX.json` for efficient page selection

## Quick Example

```
my-skillbook/
├── SKILL.md
├── README.md
├── book.json
├── TAG-INDEX.json                # optional
├── 01-foundations/
│   ├── 00-overview.md
│   ├── 01-core-concepts.md
│   └── 02-common-pitfalls.md
└── 02-application/
    ├── 00-overview.md
    └── 01-first-implementation.md
```

## Documentation

The full specification is in [spec/](spec/) with working references in [examples/](examples/). For the base standard that Skillbooks extend, see [Agent Skills](https://agentskills.io).

## License

Specification code is licensed under **Apache 2.0**. Documentation is licensed under **CC-BY-4.0**.
