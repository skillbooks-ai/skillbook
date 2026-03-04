# Content Pages

This section defines the structure and requirements for individual content pages within a Skillbook.

## Section Overview (00-overview.md)

Every section folder MUST contain a `00-overview.md` as its first file. This file serves as the section's entry point and provides orientation.

### Required Elements

- **What this section covers** — 1-2 sentences describing the section's scope
- **When to read this section** — use cases or questions that bring readers here
- **File index** — every file in the section with a one-line description
- **Reading order** — specify if pages should be read sequentially or independently

### Target Length

Section overviews MUST be 20-40 lines. They deliver real orientation value and are paid pages like any content page.

### Example

```markdown
# Risk Classification

The EU AI Act defines four risk tiers for AI systems. This section explains each tier in depth
with examples, edge cases, and practical classification guidance.

## When to Read This Section

- You need to determine which risk tier your AI system falls into
- You've been told you're "high-risk" and want to understand what that means

## Pages in This Section

- `01-four-tiers.md` — The four risk tiers at a glance with examples
- `02-unacceptable-risk.md` — The 8 prohibited practices in depth

Pages can be read independently. Start with `01-four-tiers.md` for an overview.
```

## Content Page Rules

Each content page MUST be a standalone markdown file. Pages follow these rules:

- **Length**: 40-100 lines. Long enough to be useful, short enough to be token-efficient.
- **One concept per page**: If covering two ideas, split into two pages.
- **Self-contained**: A page MUST make sense without requiring other pages first.
- **Structure**: Use headers, lists, and examples. Avoid walls of prose.

## Cross-References

Link to related pages using relative paths. Place cross-references at the end of the page.

```
See also: [Terminology](../01-core/02-terminology.md)
```

## Tags (Optional)

Pages MAY include tags in YAML frontmatter for categorization:

```yaml
---
tags: [refrigerants, safety, high-pressure]
---
```

### Tag Rules

- Lowercase, hyphen-separated: `high-pressure` (not `high_pressure`)
- Consistent spelling across all pages
- Meaningful to the book's domain

## TAG-INDEX.json

If any page includes tags, the book MUST include a `TAG-INDEX.json` at the root directory.

### Format

```json
{
  "refrigerants": [
    "02-refrigerants/01-types.md",
    "04-recovery/01-basics.md"
  ],
  "safety": [
    "01-introduction/02-safety.md",
    "04-recovery/01-basics.md"
  ]
}
```

### Requirements

- Flat map: `{ "tag": ["path/to/page.md", ...] }`
- Paths relative to book root, matching TOC paths
- Enables O(1) lookup for tag-based queries
- Served free alongside SKILL.md

## What Makes a Good Page

- Start with one sentence stating what the page covers
- Deliver the core content immediately
- Use headers, lists, and examples for structure
- End with cross-references to related pages
- Cite sources where applicable

## What to Avoid

- **Walls of prose**: Use structure (headers, lists, examples)
- **Filler phrases**: Do not write "In this section we will explore..." — just explore it
- **Giant pages**: If over 100 lines, split into multiple pages
- **Orphan pages**: Every page MUST be in the TOC and reachable via cross-references
