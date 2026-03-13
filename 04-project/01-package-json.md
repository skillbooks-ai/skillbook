# package.json

Every skillbook is a standard npm project. The `package.json` serves as both the project
manifest and the skillbook configuration — no custom config file needed.

Standard npm fields (`name`, `version`, `description`, `author`, `license`, `keywords`) serve
their usual purpose. Skillbook-specific configuration lives under the `skillbook` key, following
the same pattern as `eslintConfig`, `jest`, or `prettier`.

## Example

```json
{
  "name": "eu-ai-act",
  "version": "2.0.0",
  "description": "The EU AI Act — risk classification, compliance, and enforcement.",
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
    "contact": "https://x.com/skillbooks",
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

## The `skillbook` Key

| Field | Required | Description |
|-------|----------|-------------|
| `title` | Yes | Display title — the human-readable name of the book. |
| `author` | Recommended | Content author — distinct from top-level `author` (the publisher). |
| `contact` | No | Creator contact — email, URL, or social handle. |
| `server` | Yes | Base URL for fetching pages. |
| `pages` | Yes | Total page count (integer). |
| `price` | Yes | Full book price (e.g., `"$14.00"` or `"$0.00"` for free). |
| `language` | Yes | ISO 639-1 code (`en`, `fr`, etc.). |
| `verified` | Yes | `true` if verification pipeline has passed. Set by tooling. |
| `sources.enabled` | If sources exist | Whether this book has a `sources/` directory. |
| `sources.path` | If sources exist | Path to sources directory. |
| `sources.index` | If sources exist | Path to `SOURCES.md`. |

## Sync Rules

Fields in both `package.json` and SKILL.md frontmatter must stay in sync:

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

`skillbook validate` checks all sync rules. SKILL.md is the source of truth for agent-facing
metadata; `package.json` is the source of truth for tooling.

## Getting Started

```bash
npm i -g @skillbooks/cli
skillbook init
```

`skillbook init` handles the setup:
1. Prompts for name, description, author, license (like `npm init`)
2. Prompts for skillbook-specific fields (title, content author, price, server)
3. Writes `package.json` with the `skillbook` key, scripts, and `private: true`
4. Adds `@skillbooks/cli` as a devDependency
5. Scaffolds `SKILL.md` and `README.md` templates with matching metadata
6. Creates a starter section with `00-overview.md`

No hand-wiring, no template copying, no sync issues on day one.

## Why package.json?

- Standard npm project — every developer already knows this file
- `npm run validate` — standard scripts, works in CI
- `private: true` prevents accidental `npm publish` (you publish to skillbooks.ai)
- devDependencies track the exact CLI version used to build

---

[↑ Section](00-overview.md) | [Next: Versioning →](02-versioning.md) | [🏠 Home](../SKILL.md)
