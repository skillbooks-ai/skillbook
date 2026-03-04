# Metadata & Publishing

## book.json Specification

Every skillbook MUST contain a `book.json` file at its root directory. This file serves as the authoritative source of metadata for the skillbook.

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

**Required fields:**

- `id` — URL-safe slug. MUST be unique. Used in API paths and storage keys.
- `title` — Display title for the skillbook.
- `version` — Semantic version string (major.minor.patch). MUST comply with semver.
- `language` — ISO 639-1 code (e.g., "en", "fr").
- `verified` — Boolean. Set to `false` initially; tooling updates this after verification.
- `structure.readme` — Path to the README.md file.

**Recommended fields:**

- `description` — One-sentence summary for catalogs and search.
- `author` — Attribution string.

**Conditional fields:**

- `sources.enabled` — MUST be present if the book includes a sources directory.
- `sources.path` — Path to sources directory. Canonical value: `"sources/"`.
- `sources.index` — Path to SOURCES.md within the sources directory.
- `structure.tagIndex` — Path to TAG-INDEX.json. OMIT if no pages contain tags.

## Versioning

Skillbooks MUST follow strict semantic versioning (semver): **major.minor.patch**.

| Bump | Example | Billing Effect |
|------|---------|----------------|
| **Patch** | 1.0.0 → 1.0.1 | Typos, formatting, small fixes. NO new charges. Already-accessed pages remain free. |
| **Minor** | 1.0.0 → 1.1.0 | New pages, expanded content. NEW pages cost credits; existing accessed pages remain free. |
| **Major** | 1.0.0 → 2.0.0 | Significant rewrite or restructure. ALL pages treated as new — all cost credits again. |

## Pricing

Authors set the **full book price**. The per-page price is derived automatically:

```
page_price = full_book_price / total_pages
```

| Tier | Full Book Price | Per-Page (80 pages) | Typical Content |
|------|-----------------|---------------------|-----------------|
| Micro | $2–5 | $0.03–0.06 | Quick references, cheat sheets |
| Standard | $5–15 | $0.06–0.19 | Methodologies, textbooks |
| Premium | $15–30 | $0.19–0.38 | Specialized professional content |
| Enterprise | $30+ | $0.38+ | Actively maintained, high-update |

**Revenue split:** 80% to author, 20% to platform. Platform absorbs Stripe fees.

## Publishing Workflow

```bash
skillbook login              # Authenticate with your author API token
skillbook validate ./my-book # Check structure before publishing
skillbook publish ./my-book  # Publish or update the skillbook
skillbook stats my-book      # View views, revenue, and top pages
```

## Validation Checks

`skillbook validate` MUST perform the following checks:

- **Structure** — SKILL.md exists, every section has `00-overview.md`, all TOC paths resolve
- **Consistency** — `00-overview.md` file indexes match actual files in each folder
- **Tags** — TAG-INDEX.json entries match page frontmatter (if tags exist)
- **Pages** — within 40-100 line target (warnings, not errors, for minor deviations)
- **Security** — virus scan, prompt injection detection
- **Semver** — version bump is valid against previous publish
- **Content hash** — integrity verification
