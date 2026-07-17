# package.json

Every Skillbook is a standard npm project. `package.json` is the tooling and distribution
manifest; the `skillbook` object declares catalog data, capabilities, and optional resource
delivery. Agents continue to use ordinary `SKILL.md` entry points.

## Example

```json
{
  "$schema": "https://skillbooks.ai/spec/v2/skillbook.schema.json",
  "name": "customer-method",
  "version": "2.0.0",
  "description": "Apply an expert customer-research method to product decisions.",
  "author": "publisher-org",
  "license": "SEE LICENSE IN LICENSE",
  "keywords": ["customer-research", "strategy"],
  "private": true,
  "skillbook": {
    "title": "Customer Method",
    "author": "Domain Expert",
    "contact": "https://example.com/contact",
    "server": "https://api.example.com",
    "pages": 77,
    "price": "$20.00",
    "language": "en",
    "verified": false,
    "capabilities": [
      {
        "id": "frame-market",
        "when": "Defining a customer and market from research evidence",
        "outcome": "An evidence-qualified market frame and customer-role map",
        "entry": "skills/frame-market/SKILL.md",
        "evals": ["eval/cases.jsonl#frame-market"]
      }
    ],
    "resources": {
      "index": "knowledge/index.sqlite",
      "search": "scripts/search_resources.py",
      "fetch": "scripts/fetch_resource.py",
      "delivery": {
        "default": "local-first",
        "local": { "root": "knowledge/source", "optional": true },
        "hosted": {
          "pathPrefix": "knowledge/source",
          "auth": { "scheme": "bearer", "environment": "SKILLBOOKS_API_KEY" },
          "versionHeader": "X-Skillbook-Version"
        }
      }
    },
    "sources": {
      "enabled": true,
      "path": "sources/",
      "index": "sources/SOURCES.md"
    }
  }
}
```

## The `skillbook` Object

| Field | Required | Description |
|---|---|---|
| `title` | Yes | Human-readable catalog title. |
| `author` | Recommended | Domain-content author, distinct from top-level npm `author` publisher. |
| `contact` | No | Creator contact. |
| `server` | When hosted | Base URL for hosted pages and resources. |
| `pages` | No | Count of hosted content-page objects. |
| `price` | No | Full book price display value. |
| `language` | Recommended | ISO 639-1 language code. |
| `verified` | No | Whether the source-verification pipeline has passed. |
| `capabilities` | Yes | One or more outcome-based capability declarations. |
| `resources` | No | Pointer index, search/fetch programs, and delivery modes. |
| `sources` | When verification sources exist | Author/source-verification configuration. |

`skillbook.capabilities` follows the contract in
[Capabilities](../01-foundations/04-capabilities.md). `skillbook.resources` follows
[Resource Indexes & Delivery](../03-content/04-resource-indexes-and-delivery.md).

The v1 `skillbook.type` field is removed. Existing `reference` or `guide` values MAY be retained
during migration as ignored legacy metadata, but v2 tooling MUST NOT require or interpret them.

## Migrating from v1

1. Remove `skillbook.type` and `metadata.skillbook-type`.
2. Declare at least one capability with an outcome boundary and an Agent Skills entry.
3. Move a non-standard top-level SKILL.md `author` to `metadata.skillbook-publisher`.
4. Keep a bounded TOC, or declare `skillbook.resources` when exact indexed retrieval is useful.
5. Treat `price` as optional per-book catalog metadata, not a per-page runtime meter.

## Sync Rules

Fields exposed in both `package.json` and root `SKILL.md` MUST stay in sync:

| package.json | SKILL.md |
|---|---|
| `name` | `name` |
| `version` | `metadata.skillbook-version` |
| `description` | `description` |
| `license` | `license` or referenced license file |
| `author` or `author.name` | `metadata.skillbook-publisher` |
| `skillbook.title` | `metadata.skillbook-title` |
| `skillbook.author` | `metadata.skillbook-author` |
| `skillbook.pages` | `metadata.skillbook-pages` (when exposed) |
| `skillbook.price` | `metadata.skillbook-price` (when exposed) |
| `skillbook.server` | `metadata.skillbook-server` (when exposed) |
| `skillbook.capabilities[*]` | Root `## Capabilities` section |

`skillbook validate` checks these rules. `package.json` is the structured source of truth for
tooling; root and nested `SKILL.md` files are the runtime source of truth for agents.

## Why package.json?

- Standard project manifest and semver workflow
- Structured arrays and objects without abusing string-only SKILL metadata
- Existing npm scripts and CI conventions
- `private: true` prevents accidental npm publication
- One distribution manifest instead of a parallel custom Skillbook manifest

---

[↑ Section](00-overview.md) | [Next: Versioning →](02-versioning.md) | [🏠 Home](../SKILL.md)
