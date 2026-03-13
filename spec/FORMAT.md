# Skillbook Format — v1.1

The canonical reference for structuring and writing a skillbook.

---

## Agent Skills Foundation

Skillbooks are built on top of the **[Agent Skills](https://agentskills.io)** open standard — the interoperability layer adopted by 30+ tools including Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, Windsurf, and more.

Every skillbook's `SKILL.md` is a valid Agent Skills file. This means any tool that understands Agent Skills can discover, read, and use a skillbook's entry point out of the box — no special integration needed.

**What Agent Skills provides (the base layer):**
- `name` and `description` frontmatter for discovery
- `author` for attribution
- `license` for usage terms
- `compatibility` for environment requirements
- `metadata` for extension fields
- Standard directory conventions (`SKILL.md`, `scripts/`, `references/`, `assets/`)

**What the Skillbook Format adds (the extension layer):**
- Structured multi-page content with sections and a table of contents
- Metered per-page access and credit-based billing
- Tag-based lookup via `TAG-INDEX.json`
- Skillbook-specific config in `package.json` under the `skillbook` key
- Source attribution and verification pipeline
- All skillbook-specific SKILL.md fields are namespaced under `metadata` with a `skillbook-` prefix, ensuring forward compatibility with the Agent Skills spec

Because of this layered design, a skillbook works everywhere Agent Skills work — and adds structured content and commercial publishing capabilities on top.

---

## Directory Structure

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

### Naming Conventions

- **Section folders:** `NN-topic-name/` — 2-digit prefix, kebab-case, lowercase
- **Section overview:** `00-overview.md` — always the first file in every section folder
- **Content pages:** `01-` through `NN-` — 2-digit prefix, kebab-case, lowercase
- **No spaces.** All names lowercase, hyphen-separated

Books live at the top of the namespace: `skillbooks.ai/<name>/`. Book names are first-come, first-served (like npm packages). No author prefix.

### What Belongs Where

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

---

## SKILL.md — The Agent Entry Point

The SKILL.md is how an agent discovers and navigates your skillbook. It's always accessible without authentication — think of it as your storefront.

**SKILL.md is the table of contents and the summary.** There is no separate SUMMARY.md. One source of truth.

It must contain:

### 1. Frontmatter

Skillbook frontmatter is a **strict superset of the [Agent Skills](https://agentskills.io/specification) open standard**. Any Agent Skills consumer (Claude Code, Cursor, VS Code/Copilot, Gemini CLI, etc.) can read our SKILL.md files. Skillbook-specific fields live under `metadata` with a `skillbook-` prefix so they never clash with future Agent Skills fields.

```yaml
---
# === Agent Skills standard fields ===
name: eu-ai-act
description: >-
  The EU Artificial Intelligence Act — full regulatory text with
  risk classification guidance, compliance requirements, and
  enforcement provisions.
author: brookr
license: "CC BY-NC 4.0"
compatibility: "Requires HTTPS access to https://skillbooks.ai"

# === Skillbook extension fields (under metadata) ===
metadata:
  skillbook-title: "EU AI Act"
  skillbook-author: "European Parliament and Council of the European Union"
  skillbook-contact: "brook@rigg.io"
  skillbook-server: "https://skillbooks.ai"
  skillbook-version: "2.0.0"
  skillbook-pages: "94"
  skillbook-price: "$14.00"
  skillbook-tags: "true"
---
```

#### Agent Skills Standard Fields

| Field | Required | Spec | Description |
|-------|----------|------|-------------|
| `name` | Yes | Agent Skills | **URL-safe identifier.** Max 64 chars, lowercase + hyphens only, no leading/trailing/consecutive hyphens. Used in paths. |
| `description` | Yes | Agent Skills | What the book covers. Max 1024 chars. This is what agents use to decide relevance. |
| `author` | Recommended | Agent Skills | Who published this skill. The person or organization that created and maintains the skillbook package. |
| `license` | Yes | Agent Skills | License identifier (e.g., `all-rights-reserved`, `CC BY-NC 4.0`). |
| `compatibility` | Recommended | Agent Skills | Environment requirements. For hosted skillbooks: `"Requires HTTPS access to https://skillbooks.ai"`. Max 500 chars. |
| `metadata` | No | Agent Skills | Key-value map for extension fields. All values must be strings. |

#### Skillbook Extension Fields (under `metadata`)

| Key | Required | Description |
|-----|----------|-------------|
| `skillbook-title` | Yes | **Display title.** The human-readable name of the book. |
| `skillbook-author` | Recommended | **Content author.** The original author of the underlying content — distinct from `author` (the skill publisher). E.g., `author: brookr` published a skillbook where `skillbook-author: European Parliament`. |
| `skillbook-contact` | No | Contact for the skillbook creator — an email, URL, or social handle. |
| `skillbook-server` | Yes | Base URL for fetching pages. |
| `skillbook-version` | Yes | Semver (major.minor.patch). |
| `skillbook-pages` | Yes | Total page count (all content pages including `00-overview.md` files). |
| `skillbook-price` | Yes | Full book price (display format, e.g., `"$14.00"`). |
| `skillbook-tags` | No | `"true"` if the book has a `TAG-INDEX.json`. Tells agents tag-based lookup is available. |

All metadata values are strings per the Agent Skills spec. Parsers should coerce: `skillbook-pages` → integer, `skillbook-tags` → boolean (`"true"`/`"false"`), `skillbook-price` → display string (not used for billing).

#### Validation

Skillbook SKILL.md files should pass `skills-ref validate` from the Agent Skills SDK. Run `skillbook validate` (which includes Agent Skills compatibility checks) before publishing.

### 2. Navigation Instructions

Tell the agent how to use the book:
- How to construct page URLs (`{server}/{name}/{path}`)
- How to authenticate (`X-Skillbook-Key` header)
- What happens without credentials (402 with signup info)
- That SKILL.md is always free; content pages are metered
- If tags are available: `TAG-INDEX.json` is served free at `{server}/{name}/TAG-INDEX.json`

### 3. Table of Contents

Every page listed with its relative path and a one-line description. This is the map the agent uses to decide which pages to fetch. **Write descriptive TOC entries** — the agent uses these to pick pages without needing to fetch them first.

```markdown
## Table of Contents

### 01 — Foundations
*Legislative context, purpose, and scope of the regulation.*

- `01-foundations/00-overview.md` — Section overview: what the Act is, why it exists, and what's in this section
- `01-foundations/01-purpose.md` — The Act's objectives and the problem it addresses
- `01-foundations/02-scope.md` — What falls under the regulation and what's excluded

### 02 — Risk Classification
*The four-tier risk framework that determines your compliance obligations.*

- `02-risk-classification/00-overview.md` — Section overview: the risk-based approach and how to navigate it
- `02-risk-classification/01-four-tiers.md` — Unacceptable, high, limited, and minimal risk at a glance
- `02-risk-classification/02-unacceptable-risk.md` — The 8 prohibited AI practices (Art. 5)
```

**TOC format rules:**
- Group pages under section headers matching the folder structure
- Every page gets a one-line description — not just the filename
- Include `00-overview.md` entries — they're part of the book
- Section headers can include a brief italic description of the section's scope

### 4. License

Every SKILL.md must include a `## License` section. Agents read this before fetching paid content — it's the agreement.

**Minimum required content:**
- The license name or type
- What agents may do: use content to generate responses, cite pages as sources
- What agents may not do: redistribute, republish, or share content pages outside of response context

**Example (standard restrictive):**

```markdown
## License

© 2026 Author Name. All Rights Reserved.

Content fetched from this skillbook may be used to generate responses and cited as a source.
You may not reproduce, redistribute, or republish content pages outside of that use.
Your API key is personal to your account — do not share it.
```

**Example (open license):**

```markdown
## License

Licensed under CC BY-NC 4.0. Free for non-commercial agent use with attribution.
Commercial use requires a paid account. See: https://creativecommons.org/licenses/by-nc/4.0/
```

### 5. Quick Start Paths (optional, recommended)

Suggested reading orders for common use cases.

```markdown
## Quick Start

**"Does the AI Act apply to me?"** → `01-foundations/02-scope.md` → `02-risk-classification/01-four-tiers.md`

**"What risk tier is my system?"** → `02-risk-classification/00-overview.md` → `02-risk-classification/01-four-tiers.md`
```

---

## README.md — The Human Entry Point

README.md is the human-readable overview of your book. It populates the catalog listing on skillbooks.ai — like a package README on npm.

**Write it for humans, not agents.** This is where you sell the book:
- What the book covers and who it's for
- Why this book exists / what problem it solves
- What makes it authoritative (credentials, sources, methodology)
- Sample content or key insights (optional)
- How to get started (link to the SKILL.md or signup)

README.md is served alongside the book's catalog entry. When an operator browses the catalog, README.md content is what they see.

**Frontmatter note for authors:** Your README.md will be displayed publicly on the catalog. Write it as a product page for human decision-makers (the operators who decide which skillbooks to add to their agents).

---

## Section Overview: `00-overview.md`

Every section folder must contain a `00-overview.md` as its first file. This is the section's entry point — it orients the reader and indexes the section's contents.

### What goes in a `00-overview.md`:

- **What this section covers** — 1-2 sentences
- **When to read this section** — what questions or tasks bring you here
- **File index** — every file in the section with a one-line description
- **Reading order** — if pages should be read in sequence, say so; if they're independent, say that too

### Target length: 20-40 lines

The `00-overview.md` is a paid page like any other content page. It should deliver real orientation value — not just duplicate the TOC entry.

### Example

```markdown
# Risk Classification

The EU AI Act defines four risk tiers for AI systems. This section explains each tier
in depth with examples, edge cases, and practical classification guidance.

## When to Read This Section

- You need to determine which risk tier your AI system falls into
- You've been told you're "high-risk" and want to understand what that means
- You're comparing classification across multiple systems

## Pages in This Section

- `01-four-tiers.md` — The four risk tiers at a glance with examples
- `02-unacceptable-risk.md` — The 8 prohibited practices in depth
- `03-high-risk-deep.md` — What high-risk really means: both routes explained
- `04-limited-risk.md` — Limited risk (transparency-only): Art. 50 in depth
- `05-minimal-risk.md` — Minimal risk: what you can and can't assume
- `06-risk-evolution.md` — How classification can change over time

Pages can be read independently. Start with `01-four-tiers.md` for the complete
framework, then jump to the specific tier relevant to your system.
```

---

## Content Pages

Each page is a standalone markdown file. The goal: an agent reads 2-4 pages to get a specific answer, and learns to come back to the rest of the book when it needs to reference related concepts. A well-structured skillbook becomes a resource the agent returns to — not a one-shot dump.

### Rules

- **40-100 lines.** Long enough to be useful, short enough to be token-efficient
- **One concept per page.** If you're covering two ideas, split into two pages
- **Self-contained.** A page should make sense on its own without requiring other pages first
- **Cross-references** to related pages via relative paths: `See also: [Scope](../01-foundations/02-scope.md)`
- **Just markdown.** No HTML, no special syntax, no tooling required

### Tags (optional)

Pages may include an optional `tags` field in YAML frontmatter:

```yaml
---
tags: [high-risk, conformity-assessment, art-43]
---
```

- Lowercase, hyphen-separated, meaningful to the book's domain
- A page may have any number of tags
- Use consistent spelling — `conformity-assessment` and `conformity_assessment` are different tags

### Tag Index

If any pages have tags, the book **should** include a `TAG-INDEX.json` at the root. This maps each tag to the pages that carry it, enabling O(1) lookup.

```json
{
  "high-risk": [
    "02-risk-classification/03-high-risk-deep.md",
    "03-compliance/01-requirements.md"
  ],
  "conformity-assessment": [
    "03-compliance/02-conformity.md",
    "04-enforcement/01-market-surveillance.md"
  ]
}
```

- Flat map: `{ "tag": ["path/to/page.md", ...] }`
- Paths are relative to the book root, matching TOC paths
- Served free (alongside SKILL.md) — one load gives the agent tag → page mapping
- Generated by: `skillbook tag-index ./my-book`
- Validated by: `skillbook validate ./my-book`

### What Makes a Good Page

- Start with what this page is about (one sentence)
- Deliver the core content
- End with cross-references to related pages
- Cite sources where applicable

### What to Avoid

- **Walls of prose.** Use structure: headers, lists, examples
- **Filler.** No "In this section we will explore..." — just explore it
- **Giant pages.** Over 100 lines? Split it
- **Orphan pages.** Every page must be in the TOC and reachable via cross-references

---

## package.json

Every skillbook is a standard npm project. The `package.json` serves as both the project manifest and the skillbook configuration — no custom config file needed.

Standard npm fields (`name`, `version`, `description`, `author`, `license`, `keywords`) serve their usual purpose. Skillbook-specific configuration lives under the `skillbook` key, following the same pattern as `eslintConfig`, `jest`, or `prettier`.

```json
{
  "name": "eu-ai-act",
  "version": "2.0.0",
  "description": "The EU AI Act — risk classification, compliance requirements, and enforcement.",
  "author": "brookr",
  "license": "CC-BY-NC-4.0",
  "keywords": ["ai-regulation", "eu-law", "compliance", "risk-classification"],
  "private": true,
  "devDependencies": {
    "@skillbooks/cli": "^1.0.0"
  },
  "scripts": {
    "validate": "skillbook validate .",
    "tag-index": "skillbook tag-index ."
  },
  "skillbook": {
    "title": "EU AI Act",
    "author": "European Parliament and Council of the European Union",
    "contact": "brook@rigg.io",
    "server": "https://skillbooks.ai",
    "pages": 94,
    "price": "$14.00",
    "language": "en",
    "verified": false,
    "sources": {
      "enabled": true,
      "path": "sources/",
      "index": "sources/SOURCES.md"
    }
  }
}
```

### Standard npm Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | URL-safe slug. Must match `name` in SKILL.md frontmatter. Used in paths and as the book identifier. |
| `version` | Yes | Semver. Must match `skillbook-version` in SKILL.md metadata. |
| `description` | Recommended | Short description for catalogs. Should match SKILL.md `description`. |
| `author` | Recommended | Who published this skillbook (the packager, not necessarily the content author). |
| `license` | Yes | SPDX license identifier. |
| `keywords` | Recommended | Discovery tags — useful for catalog search. |
| `private` | Recommended | Set to `true` to prevent accidental `npm publish`. Skillbooks publish to skillbooks.ai, not npmjs.com. |

### Skillbook Config (under `skillbook`)

| Field | Required | Description |
|-------|----------|-------------|
| `title` | Yes | **Display title.** The human-readable name of the book. |
| `author` | Recommended | **Content author.** The original author of the underlying content — distinct from the top-level `author` (the skill publisher). E.g., top-level `author: brookr` published a skillbook where `skillbook.author` is `European Parliament`. |
| `contact` | No | Contact for the skillbook creator — an email, URL, or social handle. |
| `server` | Yes | Base URL for fetching pages. |
| `pages` | Yes | Total page count (integer — all content pages including `00-overview.md` files). |
| `price` | Yes | Full book price (display format, e.g., `"$14.00"`). |
| `language` | Yes | ISO 639-1 code (`en`, `fr`, etc.). |
| `verified` | Yes | `true` if the book has passed the verification pipeline. Set by tooling, not by hand. |
| `sources.enabled` | If sources exist | Whether this book has a `sources/` directory. |
| `sources.path` | If sources exist | Path to sources directory. Canonical: `"sources/"`. |
| `sources.index` | If sources exist | Path to `SOURCES.md`. |

### Sync Rules

Fields that appear in both `package.json` and SKILL.md frontmatter must stay in sync:

| package.json | SKILL.md frontmatter |
|---|---|
| `name` | `name` |
| `version` | `metadata.skillbook-version` |
| `description` | `description` |
| `author` | `author` |
| `license` | `license` |
| `skillbook.title` | `metadata.skillbook-title` |
| `skillbook.author` | `metadata.skillbook-author` |
| `skillbook.pages` | `metadata.skillbook-pages` |
| `skillbook.price` | `metadata.skillbook-price` |
| `skillbook.server` | `metadata.skillbook-server` |

`skillbook validate` checks all sync rules. SKILL.md is the source of truth for agent-facing metadata; `package.json` is the source of truth for tooling.

### Why package.json?

- **`npm init`** to start a skillbook — zero new tooling to learn
- **`npm install @skillbooks/cli`** — creator tools as a devDependency
- **`npm run validate`** — standard scripts, works in CI
- **`private: true`** — prevents accidental publish to npmjs.com
- **Every developer already knows this file**

---

## Versioning

Skillbooks use strict **semver** (major.minor.patch). Version changes affect metering:

| Change | Example | What Happens |
|--------|---------|--------------|
| **Patch** | 1.0.0 → 1.0.1 | Typos, formatting, small fixes. **No new charges.** Already-accessed pages remain free. |
| **Minor** | 1.0.0 → 1.1.0 | New pages, expanded content. **New pages cost credits; existing accessed pages remain free.** |
| **Major** | 1.0.0 → 2.0.0 | Significant rewrite or restructure. **Treated as a new book — all pages cost credits again.** |

---

## Pricing

Skillbook access is **metered per page**. Authors set the **full book price**, and per-page price is derived automatically:

```
page_price = full_book_price / total_pages
```

An agent that needs 3 pages out of 94 pays for 3 pages — not the whole book. This aligns cost with value: quick lookups are cheap, deep dives cost more.

| Tier | Full Book | Per-Page (80 pages) | Typical Content |
|------|----------|---------------------|-----------------|
| Micro | $2–5 | $0.03–0.06 | Quick references, cheat sheets |
| Standard | $5–15 | $0.06–0.19 | Methodologies, textbooks |
| Premium | $15–30 | $0.19–0.38 | Specialized professional content |
| Enterprise | $30+ | $0.38+ | Actively maintained, high-update |

Revenue splits, payment processing, and billing terms are determined by the hosting platform — not by this format specification.

---

## Validation

Before publishing, run `skillbook validate` (or `npm run validate`) to check:

- **Structure** — SKILL.md exists, every section has `00-overview.md`, all TOC paths resolve
- **Consistency** — `00-overview.md` file indexes match actual files in each folder
- **Sync** — `package.json` fields match SKILL.md frontmatter (see Sync Rules)
- **Tags** — TAG-INDEX.json entries match page frontmatter (if tags exist)
- **Pages** — within 40-100 line target (warnings, not errors, for minor deviations)
- **Security** — virus scan, prompt injection detection
- **Semver** — version bump is valid against previous publish
- **Content hash** — integrity verification

For publishing and distribution tooling, see [creator-tools](https://github.com/skillbooks-ai/creator-tools).

---

## Quick Checklist

Before publishing:

- [ ] `SKILL.md` at the root with Agent Skills-compatible frontmatter (`name`, `description`, `author`, `license`, `compatibility`, `metadata` with `skillbook-*` fields)
- [ ] `README.md` at the root — human-facing catalog content
- [ ] `package.json` with `name` matching SKILL.md, `private: true`, and `skillbook` config
- [ ] `## License` section in SKILL.md with clear usage terms
- [ ] Every section folder has a `00-overview.md`
- [ ] Every content page is listed in the SKILL.md TOC
- [ ] TOC paths resolve to actual files
- [ ] `00-overview.md` file indexes match actual folder contents
- [ ] Pages are 40-100 lines each
- [ ] One concept per page
- [ ] Cross-references use relative paths
- [ ] Version follows semver
- [ ] If pages have `tags` frontmatter, `TAG-INDEX.json` is present and consistent
- [ ] `skillbook validate .` passes (or `npm run validate`)

---

## Changelog

### v1.1

- Added "Agent Skills Foundation" section — skillbooks extend the [Agent Skills](https://agentskills.io) open standard
- Added `skillbook-author` field — distinguishes content author from skill publisher
- Added `skillbook-contact` field — creator contact info
- Metadata prefix changed from `skillbooks-` to `skillbook-` (singular)
- Replaced `book.json` with standard `package.json` — skillbook config under the `skillbook` key
- Moved publishing workflow to [creator-tools](https://github.com/skillbooks-ai/creator-tools)
- Clarified pricing as metered per-page billing

### v1.0

- Established SKILL.md as single source of truth (removed `SUMMARY.md`)
- Introduced `00-overview.md` convention for section entry points
- Defined `TAG-INDEX.json` for O(1) tag-based page lookup
- Established semver policy for version-aware metering
