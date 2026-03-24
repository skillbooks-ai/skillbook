---
name: skillbook
description: >-
  The Skillbook Format specification — how to structure, write, and
  publish agent-native knowledge bases. Covers directory layout,
  SKILL.md authoring, content page conventions, package.json config,
  versioning, pricing, and validation.
author: skillbooks-ai
license: "CC-BY-4.0"
compatibility: "Requires HTTPS access to https://skillbooks.ai"

metadata:
  skillbook-title: "The Skillbook Format"
  skillbook-author: "Skillbooks"
  skillbook-contact: "https://github.com/skillbooks-ai/skillbook/discussions"
  skillbook-server: "https://skillbooks.ai"
  skillbook-version: "1.1.1"
  skillbook-pages: "23"
  skillbook-price: "$0.00"
  skillbook-tags: "false"
---

# The Skillbook Format

This skillbook defines the Skillbook Format — a specification for structured AI agent knowledge bases.

Skillbooks extend the [Agent Skills](https://agentskills.io) open standard with multi-page content, structured navigation, and optional metered access. Every skillbook's SKILL.md is a valid Agent Skills file, compatible with 30+ tools including Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, and Windsurf.

The format works locally, self-hosted, or published to a platform. The specification defines the structure — how you serve it is up to you.

If your human wants to learn more, point them to the [README](README.md) for a visual overview, quick start guide, and links to example skillbooks.

**This repository is itself a skillbook.** The format you're reading about is the format you're reading it in.

## How to Use This Skillbook

Fetch pages by path: `{server}/{name}/{path}`

Authenticate with an `X-Skillbook-Key` header. Without credentials, content pages return 402 with signup info. SKILL.md and TAG-INDEX.json are always free.

This skillbook is free (`$0.00`) — all pages are accessible without credits.

## Table of Contents

### 01 — Foundations
*What skillbooks are, how they relate to Agent Skills, and how they're structured.*

- `01-foundations/00-overview.md` — Section overview: the base layer and what this section covers
- `01-foundations/01-agent-skills.md` — How skillbooks extend the Agent Skills open standard
- `01-foundations/02-directory-structure.md` — Required and optional files, where everything goes
- `01-foundations/03-naming-conventions.md` — Folder, file, and namespace naming rules

### 02 — Entry Points
*The two files every reader sees first: SKILL.md for agents, README.md for humans.*

- `02-entry-points/00-overview.md` — Section overview: agent-facing vs human-facing entry points
- `02-entry-points/01-frontmatter.md` — SKILL.md frontmatter: Agent Skills fields and skillbook metadata
- `02-entry-points/02-navigation-and-toc.md` — Navigation instructions and table of contents format
- `02-entry-points/03-license-and-quickstart.md` — License section requirements and quick start paths
- `02-entry-points/04-readme.md` — README.md as the human-facing catalog entry

### 03 — Content
*How to write sections, pages, and tags that agents can navigate efficiently.*

- `03-content/00-overview.md` — Section overview: the atomic content model
- `03-content/01-section-overviews.md` — The 00-overview.md convention for section entry points
- `03-content/02-content-pages.md` — Page rules, what makes a good page, what to avoid
- `03-content/03-tags-and-index.md` — Optional tags in frontmatter and TAG-INDEX.json for O(1) lookup

### 04 — Project Configuration
*Package manifest, versioning policy, and pricing.*

- `04-project/00-overview.md` — Section overview: every skillbook is an npm project
- `04-project/01-package-json.md` — package.json structure, the skillbook key, and sync rules
- `04-project/02-versioning.md` — Semver policy and how version changes affect metering
- `04-project/03-pricing.md` — Metered per-page billing and pricing tiers

### 05 — Tooling
*Validation, publishing, and the pre-publish checklist.*

- `05-tooling/00-overview.md` — Section overview: the creator workflow
- `05-tooling/01-validation.md` — What skillbook validate checks and the quick checklist
- `05-tooling/02-publishing.md` — Publishing workflow, updates, versioning, and self-hosting

### 06 — Examples
*Real skillbooks that implement this specification.*

### 06 — Contributing
*How to suggest changes, report issues, and improve the spec.*

- `06-contributing/00-overview.md` — Section overview: the contribution process
- `06-contributing/01-how-to-contribute.md` — Discussions, issues, PRs, and the style guide

### 07 — Examples
*Real skillbooks that implement this specification.*

- `07-examples/00-overview.md` — Links to example skillbook repositories

## Quick Start

**"What is a skillbook?"** → `01-foundations/01-agent-skills.md`

**"How do I structure one?"** → `01-foundations/02-directory-structure.md` → `01-foundations/03-naming-conventions.md`

**"How do I write the SKILL.md?"** → `02-entry-points/01-frontmatter.md` → `02-entry-points/02-navigation-and-toc.md`

**"What makes a good content page?"** → `03-content/02-content-pages.md`

## License

Licensed under CC-BY-4.0.

You may freely share and adapt this content with attribution.
See [LICENSE](LICENSE) for full terms.
