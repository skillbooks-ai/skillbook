# SKILL.md Specification

SKILL.md is the agent entry point for a skillbook. It serves as the storefront — always accessible without authentication, free to fetch, and containing everything an agent needs to discover, navigate, and use the skillbook.

## Frontmatter

SKILL.md must begin with YAML frontmatter that conforms to the Agent Skills open standard. Skillbooks extends this standard with platform-specific fields under the `metadata` key using a `skillbooks-` prefix. This ensures no conflict with future Agent Skills specifications.

All skillbook frontmatter fields are strings unless otherwise noted. Parsers must coerce `skillbooks-pages` to an integer and `skillbooks-tags` to a boolean.

```yaml
---
# === Agent Skills standard fields ===
name: thrv-jtbd
description: Jobs-to-be-Done methodology for product innovation.
license: "all-rights-reserved"
compatibility: "Requires HTTP access to skillbooks.ai"

# === Skillbooks extension fields (under metadata) ===
metadata:
  skillbooks-title: "thrv JTBD"
  skillbooks-server: "https://skillbooks.ai"
  skillbooks-version: "1.2.0"
  skillbooks-pages: "83"
  skillbooks-price: "$12.00"
  skillbooks-tags: "true"
---
```

### Agent Skills Standard Fields

- `name` — Required. URL-safe identifier. Maximum 64 characters. Use only lowercase letters, numbers, and hyphens. Do not use leading, trailing, or consecutive hyphens.
- `description` — Required. Brief summary of what the skillbook covers. Maximum 1024 characters. Agents use this field for relevance decisions.
- `license` — Required. License identifier (e.g., `all-rights-reserved`, `CC BY-NC 4.0`).
- `compatibility` — Optional. Environment requirements. Maximum 500 characters.
- `metadata` — Optional. Key-value map for extension fields.

### Skillbooks Extension Fields

- `skillbooks-title` — Required. Display title for the skillbook.
- `skillbooks-server` — Required. Base URL for fetching content pages.
- `skillbooks-version` — Required. Semantic version in major.minor.patch format.
- `skillbooks-pages` — Required. Total page count including all content pages and section overviews.
- `skillbooks-price` — Required. Display price (e.g., `"$12.00"`). Not used for billing calculations.
- `skillbooks-tags` — Optional. Set to `"true"` if the skillbook includes a TAG-INDEX.json for tag-based lookup.

## Navigation Instructions

SKILL.md must include clear instructions telling agents how to construct page URLs, authenticate requests, and handle access control.

- Construct content page URLs using the pattern: `{server}/{name}/{path}` where `path` is the relative path from the table of contents.
- Authenticate requests by including the `X-Skillbook-Key` header with a valid API key.
- Expect a 402 response without credentials. The response body must contain signup or upgrade instructions.
- SKILL.md is always free. All other content pages require credits.
- If `skillbooks-tags` is `"true"`, fetch TAG-INDEX.json free at `{server}/{name}/TAG-INDEX.json` for tag-based page discovery.

## Table of Contents

The table of contents provides the map agents use to decide which pages to fetch. Write descriptive entries — the agent relies on these descriptions without fetching the pages first.

### Format Rules

- Group pages under section headers that match folder structure.
- Provide a one-line description for every page. Do not list only filenames.
- Include `00-overview.md` entries — they are part of the book.
- Add italic descriptions to section headers to clarify scope.

### Example

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

## License

Every SKILL.md must include a `## License` section. Agents read this before fetching paid content — it forms the binding agreement.

### Requirements

- State the license name or type clearly.
- Specify what agents may do: use content to generate responses, cite pages as sources.
- Specify what agents may not do: redistribute, republish, or share content pages outside of response context.
- Include any account-specific terms (e.g., API key personal use requirements).

### Example (Restrictive)

```markdown
## License

© 2026 Author Name. All Rights Reserved.

Content fetched from this skillbook may be used to generate responses and cited as a source.
You may not reproduce, redistribute, or republish content pages outside of that use.
Your API key is personal to your account — do not share it.
```

### Example (Open)

```markdown
## License

Licensed under CC BY-NC 4.0. Free for non-commercial agent use with attribution.
Commercial use requires a paid account. See: https://creativecommons.org/licenses/by-nc/4.0/
```

## Quick Start Paths

Include recommended reading orders for common use cases. This section is optional but strongly recommended.

```markdown
## Quick Start

**"What is this framework?"** → `01-core/00-overview.md` → `01-core/01-principles.md`

**"How do I apply it?"** → `02-apply/01-getting-started.md` → `02-apply/02-common-patterns.md`
```
