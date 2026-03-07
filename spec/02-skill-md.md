# SKILL.md Specification

`SKILL.md` is the agent entry point for a skillbook. It is always free to fetch and MUST contain the metadata and navigation needed for agents to select and retrieve pages.
`SKILL.md` is also the single source of truth for navigation. A separate `SUMMARY.md` MUST NOT be used.

## Frontmatter

`SKILL.md` MUST begin with YAML frontmatter. Skillbook frontmatter is a strict superset of the Agent Skills open standard: base fields remain top-level, and Skillbook-specific fields live under `metadata` with a `skillbooks-` prefix.

All values in `metadata` MUST be strings. Parsers SHOULD coerce `skillbooks-pages` to an integer and `skillbooks-tags` to a boolean.

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

- `name` — REQUIRED. URL-safe identifier, max 64 chars, lowercase + hyphens, no leading/trailing/consecutive hyphens.
- `description` — REQUIRED. Description of coverage, max 1024 chars.
- `license` — REQUIRED. License identifier.
- `compatibility` — OPTIONAL. Environment requirements, max 500 chars.
- `metadata` — OPTIONAL. Key-value map for extension fields.

### Skillbooks Extension Fields

- `skillbooks-title` — REQUIRED. Human-readable display title.
- `skillbooks-server` — REQUIRED. Base URL for fetching pages.
- `skillbooks-version` — REQUIRED. Semver string (`major.minor.patch`).
- `skillbooks-pages` — REQUIRED. Total content page count including all `00-overview.md` files.
- `skillbooks-price` — REQUIRED. Display format (for example `"$12.00"`), not billing logic.
- `skillbooks-tags` — OPTIONAL. `"true"` when `TAG-INDEX.json` is present.

### Migration from v0 Frontmatter

Older skillbooks used top-level fields (`title`, `server`, `version`, `pages`, `price`, `tags`). New or updated books MUST use `metadata.skillbooks-*` fields. Validation tooling SHOULD warn on old-format frontmatter.

## Navigation Instructions

`SKILL.md` MUST include explicit navigation instructions covering:

- Page URL format: `{server}/{name}/{path}`
- Authentication: `X-Skillbook-Key` header
- Unauthorized behavior: `402` response with signup/upgrade guidance
- Access model: `SKILL.md` is free, content pages consume credits
- Optional tags: `TAG-INDEX.json` is free at `{server}/{name}/TAG-INDEX.json`

## Table of Contents

`SKILL.md` MUST include a table of contents that maps all pages.

### TOC Rules

- Pages MUST be grouped under section headers matching folder structure.
- Every page MUST include a one-line description.
- `00-overview.md` entries MUST be included.
- Section headers MAY include a brief italic scope line.

## License

Every `SKILL.md` MUST include a `## License` section.

The section MUST include:

- License name or type
- What agents MAY do (generate responses and cite pages)
- What agents MUST NOT do (redistribute/republish/share content pages outside response context)

Account/API key terms SHOULD also be included when applicable.

## Quick Start Paths

A `## Quick Start` section is OPTIONAL but RECOMMENDED. It SHOULD provide path-based reading sequences for common user intents.

## Validation

Skillbook `SKILL.md` files SHOULD pass `skills-ref validate` from the Agent Skills SDK. Authors SHOULD run `skillbook validate` before publishing.
