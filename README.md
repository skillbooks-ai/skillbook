# skillbook

[![License](https://img.shields.io/badge/license-CC--BY--4.0-blue.svg)](LICENSE)
[![Spec Version](https://img.shields.io/badge/spec-v1.1-green.svg)](SKILL.md)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-orange.svg)](https://agentskills.io)

> The Skillbook Format — a specification for structured AI agent knowledge bases

Skillbooks extend the [Agent Skills](https://agentskills.io) open standard with multi-page content, structured navigation, and optional metered access. Every skillbook's `SKILL.md` is a valid Agent Skills file — compatible with 30+ tools including Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, and Windsurf.

**This repository is itself a skillbook.** The format you're reading about is the format it's written in.

## What's a Skillbook?

A skillbook is a structured knowledge base designed for AI agents. Content is organized into sections and pages — each page covers one concept in 40-100 lines of markdown. Agents navigate via the table of contents in `SKILL.md` and fetch only the pages they need.

The format works anywhere: locally with your own tools, self-hosted, or published to a platform like [skillbooks.ai](https://skillbooks.ai) that adds metered access and commercial distribution. The specification defines the structure — how you serve it is up to you.

## Key Features

- **Agent Skills compatible** — every SKILL.md works with existing Agent Skills tooling
- **Multi-page content** — structured sections with explicit table of contents
- **Standard tooling** — `package.json`, familiar developer workflow
- **Tag-based lookup** — optional `TAG-INDEX.json` for O(1) page discovery
- **Verification pipeline** — source attribution and content integrity checks
- **Metering-ready** — per-page pricing MAY be configured for commercial distribution

## Quick Start

```bash
npm i -g @skillbooks/cli
skillbook init
```

Browse the specification by reading the [SKILL.md](SKILL.md) — it's the table of contents for this skillbook.

Or jump directly to:
- [Agent Skills Foundation](01-foundations/01-agent-skills.md) — how skillbooks relate to Agent Skills
- [Directory Structure](01-foundations/02-directory-structure.md) — how a skillbook is laid out
- [Frontmatter](02-entry-points/01-frontmatter.md) — SKILL.md metadata format
- [Content Pages](03-content/02-content-pages.md) — rules for writing good pages
- [package.json](04-project/01-package-json.md) — project configuration

## Example Skillbooks

| Book | Content | Repo |
|------|---------|------|
| EU AI Act | Regulatory text + compliance guidance | [skillbook-eu-ai-act](https://github.com/skillbooks-ai/skillbook-eu-ai-act) |
| EPA 608 | Certification exam prep | [skillbook-epa-608](https://github.com/skillbooks-ai/skillbook-epa-608) |
| Shakespeare | Complete works (725 scenes) | [skillbook-shakespeare-complete](https://github.com/skillbooks-ai/skillbook-shakespeare-complete) |
| thrv JTBD | Product innovation methodology | [skillbook-thrv-jtbd](https://github.com/skillbooks-ai/skillbook-thrv-jtbd) |

## License

Licensed under [CC-BY-4.0](LICENSE).
