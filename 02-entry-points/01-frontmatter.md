# SKILL.md Frontmatter

Skillbook frontmatter is a **strict superset of the [Agent Skills](https://agentskills.io/specification)
open standard**. Any Agent Skills consumer (Claude Code, Cursor, VS Code/Copilot, Gemini CLI, etc.)
can read skillbook SKILL.md files. Skillbook-specific fields live under `metadata` with a
`skillbook-` prefix so they never clash with future Agent Skills fields.

## Example

```yaml
---
name: eu-ai-act
description: >-
  The EU Artificial Intelligence Act — full regulatory text with
  risk classification guidance, compliance requirements, and
  enforcement provisions.
author: brookr
license: "CC BY-NC 4.0"
compatibility: "Requires HTTPS access to https://skillbooks.ai"

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

## Agent Skills Standard Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | URL-safe identifier. Max 64 chars, lowercase + hyphens only. Used in paths. |
| `description` | Yes | What the book covers. Max 1024 chars. Agents use this to decide relevance. |
| `author` | Recommended | Who published this skill — the person or org that maintains the skillbook package. |
| `license` | Yes | License identifier (e.g., `all-rights-reserved`, `CC BY-NC 4.0`). |
| `compatibility` | Recommended | Environment requirements. For hosted skillbooks: `"Requires HTTPS access to https://skillbooks.ai"`. |
| `metadata` | No | Key-value map for extension fields. All values must be strings. |

## Skillbook Extension Fields (under `metadata`)

| Key | Required | Description |
|-----|----------|-------------|
| `skillbook-title` | Yes | Display title — the human-readable name of the book. |
| `skillbook-author` | Recommended | Content author — distinct from `author` (the publisher). E.g., `author: brookr` published a skillbook where `skillbook-author: European Parliament`. |
| `skillbook-contact` | No | Creator contact — an email, URL, or social handle. |
| `skillbook-server` | Yes | Base URL for fetching pages. |
| `skillbook-version` | Yes | Semver (major.minor.patch). |
| `skillbook-pages` | Yes | Total page count (all content pages including `00-overview.md` files). |
| `skillbook-price` | Yes | Full book price (display format, e.g., `"$14.00"` or `"$0.00"` for free). |
| `skillbook-tags` | No | `"true"` if the book has a `TAG-INDEX.json`. |

All metadata values are strings per the Agent Skills spec. Parsers should coerce:
`skillbook-pages` → integer, `skillbook-tags` → boolean, `skillbook-price` → display string.

SKILL.md files should pass `skills-ref validate` from the Agent Skills SDK.

---

[↑ Section](00-overview.md) | [Next: Navigation & TOC →](02-navigation-and-toc.md) | [🏠 Home](../SKILL.md)
