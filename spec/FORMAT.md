# Skillbook Format — v1.1

The canonical reference for structuring, writing, and publishing a skillbook.

---

## Agent Skills Foundation

Skillbooks are built on top of the **[Agent Skills](https://agentskills.io)** open standard — the interoperability layer adopted by 30+ tools including Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, Windsurf, and more.

Every skillbook's `SKILL.md` is a valid Agent Skills file. This means any tool that understands Agent Skills can discover, read, and use a skillbook's entry point out of the box — no special integration needed.

**What Agent Skills provides (the base layer):**
- `name` and `description` frontmatter for discovery
- `license` for usage terms
- `compatibility` for environment requirements
- `metadata` for extension fields
- Standard directory conventions (`SKILL.md`, `scripts/`, `references/`, `assets/`)

**What Skillbooks adds (the extension layer):**
- Structured multi-page content with sections and a table of contents
- Per-page pricing and credit-based access
- `book.json` for catalog metadata
- Tag-based lookup via `TAG-INDEX.json`
- Verification pipeline and source attribution
- All Skillbook-specific fields are namespaced under `metadata` with a `skillbooks-` prefix, ensuring forward compatibility with the Agent Skills spec

Because of this layered design, a skillbook works everywhere Agent Skills work — and adds commercial publishing capabilities on top.

---

## Directory Structure

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
| Book metadata | `book.json` |
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

Skillbook frontmatter is a **strict superset of the [Agent Skills](https://agentskills.io/specification) open standard**. Any Agent Skills consumer (Claude Code, Cursor, VS Code/Copilot, Gemini CLI, etc.) can read our SKILL.md files. Our platform-specific fields live under `metadata` with a `skillbooks-` prefix so they never clash with future Agent Skills fields.

```yaml
---
# === Agent Skills standard fields ===
name: thrv-jtbd                           # max 64 chars, lowercase+hyphens, no leading/trailing/consecutive hyphens
description: Jobs-to-be-Done methodology for product innovation.  # max 1024 chars
license: "all-rights-reserved"            # short license identifier
compatibility: "Requires HTTP access to skillbooks.ai"

# === Skillbooks extension fields (under metadata) ===
metadata:
  skillbooks-title: "thrv JTBD"
  skillbooks-server: "https://skillbooks.ai"
  skillbooks-version: "1.2.0"
  skillbooks-pages: "83"
  skillbooks-price: "$12.00"
  skillbooks-tags: "true"                 # optional: "true" if TAG-INDEX.json exists
---
```

#### Agent Skills Standard Fields

| Field | Required | Spec | Description |
|-------|----------|------|-------------|
| `name` | Yes | Agent Skills | **URL-safe identifier.** Max 64 chars, lowercase + hyphens only, no leading/trailing/consecutive hyphens. Used in paths. |
| `description` | Yes | Agent Skills | What the book covers. Max 1024 chars. This is what agents use to decide relevance. |
| `license` | Yes | Agent Skills | License identifier (e.g., `all-rights-reserved`, `CC BY-NC 4.0`). |
| `compatibility` | No | Agent Skills | Environment requirements (e.g., `"Requires HTTP access to skillbooks.ai"`). Max 500 chars. |
| `metadata` | No | Agent Skills | Key-value map for extension fields. All values must be strings. |

#### Skillbooks Extension Fields (under `metadata`)

| Key | Required | Description |
|-----|----------|-------------|
| `skillbooks-title` | Yes | **Display title.** The human-readable name of the book. |
| `skillbooks-server` | Yes | Base URL for fetching pages. |
| `skillbooks-version` | Yes | Semver (major.minor.patch). |
| `skillbooks-pages` | Yes | Total page count (all content pages including `00-overview.md` files). |
| `skillbooks-price` | Yes | Full book price (display format, e.g., `"$12.00"`). |
| `skillbooks-tags` | No | `"true"` if the book has a `TAG-INDEX.json`. Tells agents tag-based lookup is available. |

#### Migration from v0 Frontmatter

Prior to Agent Skills alignment, skillbooks used top-level fields (`title`, `server`, `version`, `pages`, `price`, `tags`). The platform currently serves SKILL.md files from R2 as-is, so both old and new frontmatter work for content delivery. However, new and updated books **must** use the `metadata`-namespaced format above. The `skillbook validate` CLI will warn on old-format frontmatter.

All metadata values are strings per the Agent Skills spec. Parsers should coerce: `skillbooks-pages` → integer, `skillbooks-tags` → boolean (`"true"`/`"false"`), `skillbooks-price` → display string (not used for billing).

#### Validation

Skillbook SKILL.md files should pass `skills-ref validate` from the Agent Skills SDK. Run `skillbook validate` (which includes Agent Skills compatibility checks) before publishing.

### 2. Navigation Instructions

Tell the agent how to use the book:
- How to construct page URLs (`{server}/{name}/{path}`)
- How to authenticate (`X-Skillbook-Key` header)
- What happens without credentials (402 with signup info)
- That SKILL.md is always free; content pages cost credits
- If tags are available: `TAG-INDEX.json` is served free at `{server}/{name}/TAG-INDEX.json`

### 3. Table of Contents

Every page listed with its relative path and a one-line description. This is the map the agent uses to decide which pages to fetch. **Write descriptive TOC entries** — the agent uses these to pick pages without needing to fetch them first.

```markdown
## Table of Contents

### 01 — Core Concepts
*The foundational framework — start here if you're new.*

- `01-core/00-overview.md` — Section overview: what the framework is, when to use it, and what's in this section
- `01-core/01-principles.md` — The three foundational principles with examples
- `01-core/02-terminology.md` — Key terms and definitions used throughout the book

### 02 — Application
*Putting theory into practice.*

- `02-apply/00-overview.md` — Section overview: implementation approaches and reading order
- `02-apply/01-getting-started.md` — Step-by-step first implementation
- `02-apply/02-common-patterns.md` — Patterns that work across domains
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

**"What is this framework?"** → `01-core/00-overview.md` → `01-core/01-principles.md`

**"How do I apply it?"** → `02-apply/01-getting-started.md` → `02-apply/02-common-patterns.md`
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

The EU AI Act defines four risk tiers for AI systems. This section explains each tier in depth
with examples, edge cases, and practical classification guidance.

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

Pages can be read independently. Start with `01-four-tiers.md` for an overview,
then jump to the specific tier relevant to your system.
```

---

## Content Pages

Each page is a standalone markdown file. The goal: an agent reads 3-6 pages per question and gets what it needs.

### Rules

- **40-100 lines.** Long enough to be useful, short enough to be token-efficient
- **One concept per page.** If you're covering two ideas, split into two pages
- **Self-contained.** A page should make sense on its own without requiring other pages first
- **Cross-references** to related pages via relative paths: `See also: [Terminology](../01-core/02-terminology.md)`
- **Just markdown.** No HTML, no special syntax, no tooling required

### Tags (optional)

Pages may include an optional `tags` field in YAML frontmatter:

```yaml
---
tags: [refrigerants, safety, high-pressure]
---
```

- Lowercase, hyphen-separated, meaningful to the book's domain
- A page may have any number of tags
- Use consistent spelling — `high-pressure` and `high_pressure` are different tags

### Tag Index

If any pages have tags, the book **should** include a `TAG-INDEX.json` at the root. This maps each tag to the pages that carry it, enabling O(1) lookup.

```json
{
  "refrigerants": [
    "02-refrigerants/01-types.md",
    "04-recovery/01-basics.md"
  ],
  "safety": [
    "01-introduction/02-safety.md",
    "04-recovery/01-basics.md"
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

## book.json

Every book requires a `book.json` at the root.

```json
{
  "id": "book-slug",
  "title": "Book Title",
  "description": "One-sentence description for catalogs and search.",
  "version": "1.0.0",
  "author": "Author or source attribution",
  "language": "en",
  "verified": false,
  "sources": {
    "enabled": true,
    "path": "sources/",
    "index": "sources/SOURCES.md"
  },
  "structure": {
    "readme": "README.md",
    "tagIndex": "TAG-INDEX.json"
  }
}
```

| Field | Required | Description |
|-------|----------|-------------|
| `id` | Yes | URL-safe slug. Used in API paths and storage keys. |
| `title` | Yes | Display title. |
| `description` | Recommended | Short description for catalogs. |
| `version` | Yes | Semver. Bump on significant content changes. |
| `author` | Recommended | Attribution string. |
| `language` | Yes | ISO 639-1 code (`en`, `fr`, etc.). |
| `verified` | Yes | `true` if the book has passed the verification pipeline. Set by tooling, not by hand. |
| `sources.enabled` | If sources exist | Whether this book has a `sources/` directory. |
| `sources.path` | If sources exist | Path to sources directory. Canonical: `"sources/"`. |
| `sources.index` | If sources exist | Path to `SOURCES.md`. |
| `structure.readme` | Yes | Path to `README.md`. |
| `structure.tagIndex` | No | Path to `TAG-INDEX.json`. Omit if no pages have tags. |

---

## Versioning

Skillbooks use strict **semver** (major.minor.patch). Version changes affect what operators pay:

| Change | Example | What Happens |
|--------|---------|--------------|
| **Patch** | 1.0.0 → 1.0.1 | Typos, formatting, small fixes. **No new charges.** Already-accessed pages remain free. |
| **Minor** | 1.0.0 → 1.1.0 | New pages, expanded content. **New pages cost credits; existing accessed pages remain free.** |
| **Major** | 1.0.0 → 2.0.0 | Significant rewrite or restructure. **Treated as a new book — all pages cost credits again.** |

---

## Pricing

Authors set the **full book price**. Per-page price is derived automatically:

```
page_price = full_book_price / total_pages
```

| Tier | Full Book | Per-Page (80 pages) | Typical Content |
|------|----------|---------------------|-----------------|
| Micro | $2–5 | $0.03–0.06 | Quick references, cheat sheets |
| Standard | $5–15 | $0.06–0.19 | Methodologies, textbooks |
| Premium | $15–30 | $0.19–0.38 | Specialized professional content |
| Enterprise | $30+ | $0.38+ | Actively maintained, high-update |

Revenue split: **80% author, 20% platform.** Platform absorbs Stripe fees. (Compare: Kindle takes 30-65%, Apple Books takes 30%.)

---

## Publishing

```bash
skillbook login                      # Authenticate with your author API token
skillbook validate ./my-book         # Check structure before publishing
skillbook publish ./my-book          # Publish (or update)
skillbook stats my-book              # Views, revenue, top pages
```

### Validation Checks

`skillbook validate` checks:

- **Structure** — SKILL.md exists, every section has `00-overview.md`, all TOC paths resolve
- **Consistency** — `00-overview.md` file indexes match actual files in each folder
- **Tags** — TAG-INDEX.json entries match page frontmatter (if tags exist)
- **Pages** — within 40-100 line target (warnings, not errors, for minor deviations)
- **Security** — virus scan, prompt injection detection
- **Semver** — version bump is valid against previous publish
- **Content hash** — integrity verification

---

## Quick Checklist

Before publishing:

- [ ] `SKILL.md` at the root with Agent Skills-compatible frontmatter (name, description, license, compatibility, metadata with skillbooks-* fields)
- [ ] `README.md` at the root — human-facing catalog content
- [ ] `book.json` at the root with required fields
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
- [ ] `skillbook validate ./my-book` passes

---

## Changelog

### v1.1

| Change | Detail |
|--------|--------|
| Agent Skills as base layer | Added "Agent Skills Foundation" section documenting that Skillbooks are built on the [Agent Skills](https://agentskills.io) open standard, compatible with 30+ tools. |

### v1.0 (changes from pre-1.0)

| Before | v1.0 | Reason |
|--------|------|--------|
| `SUMMARY.md` required | Removed | SKILL.md TOC is the single source of truth |
| Folder `README.md` files | Replaced by `00-overview.md` | Consistent convention, no ambiguity |
| Content starts at `01-` | `00-overview.md` + content at `01-`+ | Clear separation: `00-` = section meta, `01-`+ = content |
| Revenue split 90/10 | 80/20 | Locked 2026-03-09. Platform absorbs Stripe fees. |
| `structure.summary` in book.json | Removed | No more SUMMARY.md |
