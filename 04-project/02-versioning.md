# Versioning

Skillbooks use strict **semver** (major.minor.patch). Version bumps aren't just labels —
they determine what gets metered.

## How Version Changes Affect Metering

| Change | Example | What Happens |
|--------|---------|--------------|
| **Patch** | 1.0.0 → 1.0.1 | Typos, formatting, small fixes. **No new charges.** Already-accessed pages remain free. |
| **Minor** | 1.0.0 → 1.1.0 | New pages, expanded content. **New pages cost credits; existing accessed pages remain free.** |
| **Major** | 1.0.0 → 2.0.0 | Significant rewrite or restructure. **Treated as a new book — all pages cost credits again.** |

## What This Means for Authors

- **Fix typos freely.** Patch bumps never charge readers again. Ship corrections without guilt.
- **Add content incrementally.** Minor bumps let you grow the book over time. Existing readers
  only pay for new pages they access.
- **Major rewrites reset the meter.** Use this when content has changed so fundamentally that
  prior access doesn't represent the current book.

## What This Means for Operators

- **Patches are free updates.** Subscribe to a book once, get all fixes automatically.
- **Minor versions are predictable.** You only pay when your agent accesses genuinely new content.
- **Major versions are explicit.** A major bump signals significant change — you can choose
  whether to upgrade.

## Sync

The version must match in both `package.json` (`version`) and SKILL.md frontmatter
(`metadata.skillbook-version`). `skillbook validate` checks this.

---

[← Previous: package.json](01-package-json.md) | [↑ Section](00-overview.md) | [Next: Pricing →](03-pricing.md) | [🏠 Home](../SKILL.md)
