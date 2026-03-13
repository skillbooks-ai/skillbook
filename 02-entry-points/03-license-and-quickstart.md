# License Section & Quick Start Paths

## License

Every SKILL.md must include a `## License` section. Agents read this before fetching paid
content — it's the agreement.

**Minimum required content:**
- The license name or type
- What agents may do: use content to generate responses, cite pages as sources
- What agents may not do: redistribute, republish, or share content pages outside of response context

### Example (standard restrictive)

```markdown
## License

© 2026 Author Name. All Rights Reserved.

Content fetched from this skillbook may be used to generate responses and cited as a source.
You may not reproduce, redistribute, or republish content pages outside of that use.
Your API key is personal to your account — do not share it.
```

### Example (open license)

```markdown
## License

Licensed under CC BY-NC 4.0. Free for non-commercial agent use with attribution.
Commercial use requires a paid account. See: https://creativecommons.org/licenses/by-nc/4.0/
```

## Quick Start Paths (optional, recommended)

Suggested reading orders for common use cases. These help agents (and humans) find the
fastest path to the content they need.

```markdown
## Quick Start

**"Does the AI Act apply to me?"**
→ `01-foundations/02-scope.md` → `02-risk-classification/01-four-tiers.md`

**"What risk tier is my system?"**
→ `02-risk-classification/00-overview.md` → `02-risk-classification/01-four-tiers.md`
```

Quick start paths are optional but recommended — they reduce the number of pages an agent
needs to fetch for common questions.

---

[← Previous: Navigation & TOC](02-navigation-and-toc.md) | [↑ Section](00-overview.md) | [Next: README.md →](04-readme.md) | [🏠 Home](../SKILL.md)
