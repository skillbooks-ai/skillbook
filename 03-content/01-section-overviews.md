# Section Overviews: `00-overview.md`

Every numbered TOC section folder MUST contain a `00-overview.md` as its first file. This is the
section's entry point — it orients the reader and indexes the section's contents. Indexed resource
directories do not need this convention.

## What Goes in a `00-overview.md`

- **What this section covers** — 1-2 sentences
- **When to read this section** — what questions or tasks bring you here
- **File index** — every file in the section with a one-line description
- **Reading order** — if pages should be read in sequence, say so; if they're independent, say that too

## Keep It Concise

The `00-overview.md` is a resource like any other content page. It should deliver real orientation
value — not just duplicate the TOC entry. Include the smallest map that lets an agent choose the
next resource without reading the section itself.

## Example

```markdown
# Risk Classification

The EU AI Act defines four risk tiers for AI systems. This section explains each tier
in depth with examples, edge cases, and practical classification guidance.

## When to Read This Section

- You need to determine which risk tier your AI system falls into
- You've been told you're "high-risk" and want to understand what that means
- You're comparing classification across multiple systems

## Pages in This Section

- `01-four-tiers.md` — The four risk tiers at a glance with examples
- `02-unacceptable-risk.md` — The 8 prohibited practices in depth
- `03-high-risk-deep.md` — What high-risk really means: both routes explained
- `04-limited-risk.md` — Limited risk (transparency-only): Art. 50 in depth
- `05-minimal-risk.md` — Minimal risk: what you can and can't assume
- `06-risk-evolution.md` — How classification can change over time

Pages can be read independently. Start with `01-four-tiers.md` for the complete
framework, then jump to the specific tier relevant to your system.
```

---

[↑ Section](00-overview.md) | [Next: Content Pages →](02-content-pages.md) | [🏠 Home](../SKILL.md)
