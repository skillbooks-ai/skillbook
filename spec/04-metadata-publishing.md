# Metadata & Publishing

## book.json Specification

Every skillbook MUST include `book.json` at the repository root.

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

### Required Fields

- `id` — MUST be a URL-safe slug used in API paths and storage keys.
- `title` — MUST be the display title.
- `version` — MUST be a semver string.
- `language` — MUST be an ISO 639-1 code (for example `en`, `fr`).
- `verified` — MUST be a boolean and SHOULD be set by tooling, not hand-edited.
- `structure.readme` — MUST point to `README.md`.

### Recommended Fields

- `description` — SHOULD provide a catalog/search summary.
- `author` — SHOULD provide attribution.

### Conditional Fields

- `sources.enabled`, `sources.path`, and `sources.index` MUST be present when a `sources/` directory exists.
- `structure.tagIndex` SHOULD be present when tags are used and SHOULD be omitted otherwise.

## Versioning

Skillbooks MUST follow semver (`major.minor.patch`).

| Bump | Example | Billing Effect |
|------|---------|----------------|
| **Patch** | 1.0.0 → 1.0.1 | Typos, formatting, small fixes. No new charges; previously accessed pages remain free. |
| **Minor** | 1.0.0 → 1.1.0 | New pages or expanded content. New pages cost credits; previously accessed pages remain free. |
| **Major** | 1.0.0 → 2.0.0 | Significant rewrite/restructure. Treated as a new book; all pages cost credits again. |

## Pricing

Per-page price is derived from full-book price:

```
page_price = full_book_price / total_pages
```

| Tier | Full Book Price | Per-Page (80 pages) | Typical Content |
|------|-----------------|---------------------|-----------------|
| Micro | $2–5 | $0.03–0.06 | Quick references, cheat sheets |
| Standard | $5–15 | $0.06–0.19 | Methodologies, textbooks |
| Premium | $15–30 | $0.19–0.38 | Specialized professional content |
| Enterprise | $30+ | $0.38+ | Actively maintained, high-update |

Revenue split is 80% author / 20% platform. The platform absorbs Stripe fees.

## Publishing Workflow

```bash
skillbook login
skillbook validate ./my-book
skillbook publish ./my-book
skillbook stats my-book
```

## Validation Checks

`skillbook validate` checks:

- Structure (`SKILL.md` present, section `00-overview.md` files present, TOC paths resolve)
- Consistency (`00-overview.md` file indexes match folder contents)
- Tags (`TAG-INDEX.json` and page frontmatter alignment when tags exist)
- Pages (40-100 line target; minor deviations may warn)
- Security (virus scan and prompt-injection detection)
- Semver bump validity against prior publish
- Content hash integrity
