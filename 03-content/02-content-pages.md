# Content Pages

Each TOC page is a standalone markdown file. The goal: an agent reads a small number of pages to
support a capability, then returns only when it needs related concepts. Indexed resources follow
the bounded retrieval rules in [Resource Indexes & Delivery](04-resource-indexes-and-delivery.md)
and need not use this human-navigation format.

## Rules

- **Bounded context.** A fetched page SHOULD stay under roughly 2,000 tokens unless the task cannot
  be completed coherently when split. Measure serialized content, not Markdown line count.
- **One concept per page.** If you're covering two ideas, split into two pages
- **Self-contained.** A page should make sense on its own without requiring other pages first
- **Fit the capability.** A page MAY combine facts, procedure, criteria, examples, and templates
  when they serve one coherent outcome; do not classify the whole book by content purpose.
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
- **Oversized retrievals.** If an agent often needs only one part, split at that task boundary
- **Orphan resources.** Every resource must be discoverable through the TOC or declared index

## Cross-References

Link to related pages inline using relative markdown paths:

```markdown
For the full list of prohibited practices, see [Unacceptable Risk](../02-risk-classification/02-unacceptable-risk.md).

This builds on the concepts introduced in [Four Tiers](01-four-tiers.md).
```

Cross-references help agents discover related content without returning to the TOC.
Use them when a page mentions a concept covered in depth elsewhere — don't make the
reader guess where to go next.

If two resources are always fetched together to complete one thought, combine them. If they serve
different capabilities or can be selected independently, split them. The goal is the smallest
coherent evidence or instruction unit, not the smallest file.

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
