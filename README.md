# skillbook

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE-APACHE)
[![Spec Version](https://img.shields.io/badge/spec-v1.1-green.svg)](SKILL.md)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-orange.svg)](https://agentskills.io)

> The Skillbook Format — specification for structured, commercial-grade AI agent knowledge bases

Skillbooks extend the [Agent Skills](https://agentskills.io) open standard with multi-page content, metered per-page access, and commercial publishing capabilities. Every skillbook's `SKILL.md` is a valid Agent Skills file — compatible with 30+ tools including Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, and Windsurf.

**This repository is itself a skillbook.** The format you're reading about is the format it's written in.

## What's a Skillbook?

A skillbook is a structured knowledge base designed for AI agents. Content is organized into sections and pages — each page covers one concept in 40-100 lines of markdown. Agents fetch only the pages they need, paying per page accessed.

Think of it as an ebook for agents: a `SKILL.md` serves as the storefront (free to browse), content pages are gated behind metered access, and a `package.json` handles project configuration.

## Key Features

- **Agent Skills compatible** — every SKILL.md works with existing Agent Skills tooling
- **Multi-page content** — structured sections with explicit table of contents
- **Metered access** — per-page pricing; agents pay only for what they read
- **Standard tooling** — `npm init`, `package.json`, familiar developer workflow
- **Tag-based lookup** — optional `TAG-INDEX.json` for O(1) page discovery
- **Verification pipeline** — source attribution and content integrity checks

## Quick Start

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

Specification and code: [Apache 2.0](LICENSE-APACHE). Documentation: [CC-BY-4.0](LICENSE-CC-BY).
