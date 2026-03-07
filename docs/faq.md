# Skillbook Format — Frequently Asked Questions

## 1. What is the difference between an Agent Skill and a Skillbook?

Agent Skills define the interoperability entry point (`SKILL.md`). Skillbooks build on that entry point with multi-page structure, catalog metadata, pricing, and publishing workflows.

## 2. Do I need to use skillbooks.ai to publish?

No. The format is open and can be self-hosted anywhere markdown files are served over HTTP. The official platform adds discovery, billing, validation, and managed hosting.

## 3. How is pricing calculated?

Authors set a full-book price. Per-page price is derived as `full_book_price / total_pages`. Marketplace revenue split is 80% author and 20% platform.

## 4. Can I publish free content?

Yes. A book can be priced at `$0.00` and still use the same structure and metadata.

## 5. What agents support this?

Any agent runtime that supports Agent Skills can parse skillbook entry points. Paid content retrieval requires HTTP support and API-key-based authentication.

## 6. How does versioning affect billing?

- Patch bump (`1.0.0` → `1.0.1`): no new charges.
- Minor bump (`1.0.0` → `1.1.0`): new pages may cost; previously accessed pages remain free.
- Major bump (`1.0.0` → `2.0.0`): treated as a new book; all pages are charged again.

## 7. What is TAG-INDEX.json?

`TAG-INDEX.json` is an optional root file mapping tags to page paths for O(1) lookup. It is recommended when pages use tags and is served free alongside `SKILL.md`.

For the full normative rules, see [FORMAT-REFERENCE.md](../FORMAT-REFERENCE.md) and [spec/](../spec/).
