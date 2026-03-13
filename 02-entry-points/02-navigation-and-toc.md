# Navigation Instructions & Table of Contents

After the frontmatter, the SKILL.md body tells agents how to use the book and lists every page.

## Navigation Instructions

Tell the agent:
- How to construct page URLs: `{server}/{name}/{path}`
- How to authenticate: `X-Skillbook-Key` header
- What happens without credentials: 402 with signup info
- That SKILL.md is always free; content pages MAY require authentication
- If tags are available: `TAG-INDEX.json` is served free at `{server}/{name}/TAG-INDEX.json`

## Table of Contents

Every page must be listed with its relative path and a one-line description. This is the map
agents use to decide which pages to fetch. **Write descriptive TOC entries** — the agent uses
these to pick pages without needing to fetch them first.

```markdown
## Table of Contents

### 01 — Foundations
*Legislative context, purpose, and scope of the regulation.*

- `01-foundations/00-overview.md` — Section overview: what the Act is, why it exists
- `01-foundations/01-purpose.md` — The Act's objectives and the problem it addresses
- `01-foundations/02-scope.md` — What falls under the regulation and what's excluded

### 02 — Risk Classification
*The four-tier risk framework that determines your compliance obligations.*

- `02-risk-classification/00-overview.md` — The risk-based approach and how to navigate it
- `02-risk-classification/01-four-tiers.md` — Unacceptable, high, limited, and minimal risk
- `02-risk-classification/02-unacceptable-risk.md` — The 8 prohibited AI practices (Art. 5)
```

## TOC Format Rules

- Group pages under section headers matching the folder structure
- Every page gets a one-line description — not just the filename
- Include `00-overview.md` entries — they're part of the book
- Section headers can include a brief italic description of the section's scope

The SKILL.md is the table of contents *and* the summary. There is no separate SUMMARY.md.
One source of truth.

---

[← Previous: Frontmatter](01-frontmatter.md) | [↑ Section](00-overview.md) | [Next: License & Quick Start →](03-license-and-quickstart.md) | [🏠 Home](../SKILL.md)
