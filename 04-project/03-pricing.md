# Pricing

Skillbook access MAY be **metered per page**. When metering is enabled, authors set the
**full book price**, and per-page price is derived automatically:

```
page_price = full_book_price / total_pages
```

An agent that needs 3 pages out of 94 pays for 3 pages — not the whole book. This aligns cost
with value: quick lookups are cheap, deep dives cost more.

## Pricing Tiers

| Tier | Full Book | Per-Page (80 pages) | Typical Content |
|------|----------|---------------------|-----------------|
| Free | $0.00 | $0.00 | Open specifications, public domain content |
| Micro | $2–5 | $0.03–0.06 | Quick references, cheat sheets |
| Standard | $5–15 | $0.06–0.19 | Methodologies, textbooks |
| Premium | $15–30 | $0.19–0.38 | Specialized professional content |
| Enterprise | $30+ | $0.38+ | Actively maintained, high-update |

## Free Skillbooks

Set `skillbook-price: "$0.00"` (SKILL.md) and `"price": "$0.00"` (package.json) for free content.
All pages are accessible without credits. This is appropriate for open specifications,
public domain material, and community resources.

## Platform Terms

Revenue splits, payment processing, and billing terms are determined by the hosting
platform — not by this format specification. The format defines *what* is metered (pages)
and *how* pricing is expressed (full book price, derived per-page). The platform handles
the rest.

---

[← Previous: Versioning](02-versioning.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
