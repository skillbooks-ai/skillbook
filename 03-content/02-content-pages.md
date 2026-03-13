# Content Pages

Each page is a standalone markdown file. The goal: an agent reads 2-4 pages to get a specific
answer, and learns to come back to the rest of the book when it needs to reference related
concepts. A well-structured skillbook becomes a resource the agent returns to — not a one-shot dump.

## Rules

- **40-100 lines.** Long enough to be useful, short enough to be token-efficient
- **One concept per page.** If you're covering two ideas, split into two pages
- **Self-contained.** A page should make sense on its own without requiring other pages first
- **Cross-references** to related pages via relative paths: `See also: [Scope](../01-foundations/02-scope.md)`
- **Just markdown.** No HTML, no special syntax, no tooling required

## What Makes a Good Page

- Start with what this page is about (one sentence)
- Deliver the core content
- End with cross-references to related pages
- Cite sources where applicable

## What to Avoid

- **Walls of prose.** Use structure: headers, lists, examples
- **Filler.** No "In this section we will explore..." — just explore it
- **Giant pages.** Over 100 lines? Split it
- **Orphan pages.** Every page must be in the TOC and reachable via cross-references

## Cross-References

Link to related pages inline using relative markdown paths:

```markdown
For the full list of prohibited practices, see [Unacceptable Risk](../02-risk-classification/02-unacceptable-risk.md).

This builds on the concepts introduced in [Four Tiers](01-four-tiers.md).
```

Cross-references help agents discover related content without returning to the TOC.
Use them when a page mentions a concept covered in depth elsewhere — don't make the
reader guess where to go next.

## Navigation Links

Pages should include sequential navigation links at the bottom:

```markdown
---

[← Previous: Page Title](prev-page.md) | [↑ Section](00-overview.md) | [Next: Page Title →](next-page.md) | [🏠 Home](../SKILL.md)
```

These render as clickable links on GitHub and help agents traverse the book linearly
when needed. First pages in a section omit the "Previous" link; last pages omit "Next".

---

[← Previous: Section Overviews](01-section-overviews.md) | [↑ Section](00-overview.md) | [Next: Tags & Index →](03-tags-and-index.md) | [🏠 Home](../SKILL.md)
