# Content Pages

This section defines structure and quality requirements for section overviews and content pages.

## Section Overview (00-overview.md)

Every section folder MUST contain `00-overview.md` as its first file.

### Required Elements

- What the section covers (1-2 sentences)
- When to read the section (triggering questions/tasks)
- File index with every file and one-line description
- Reading-order guidance (sequential or independent)

### Length Guidance

Section overviews SHOULD target 20-40 lines. They are paid pages and SHOULD provide substantive orientation.

## Content Page Rules

Each content page MUST be a standalone markdown file.

- Length SHOULD target 40-100 lines.
- Each page SHOULD focus on one concept.
- Pages SHOULD be self-contained and understandable independently.
- Pages SHOULD use structure (headers, lists, examples) to avoid dense prose.
- Pages MUST use plain markdown (no HTML or custom syntax requirements).

## Cross-References

Pages SHOULD include cross-references to related pages using relative paths, typically near the end of the file.

```markdown
See also: [Terminology](../01-core/02-terminology.md)
```

## Tags (Optional)

Pages MAY include tags in YAML frontmatter:

```yaml
---
tags: [refrigerants, safety, high-pressure]
---
```

### Tag Rules

- Tags SHOULD be lowercase and hyphen-separated.
- Tag spelling SHOULD be consistent across the book.
- Tags SHOULD be meaningful to the domain.

## TAG-INDEX.json

If pages have tags, the book SHOULD include `TAG-INDEX.json` at the root.

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
- Paths MUST be relative to the book root and match TOC paths.
- The file is served free alongside `SKILL.md` for O(1) tag lookup.
- `TAG-INDEX.json` SHOULD be generated with `skillbook tag-index ./my-book`.
- Tag/index consistency SHOULD be validated with `skillbook validate ./my-book`.

## Quality Signals

Good pages usually:

- Open with one sentence explaining scope
- Deliver core material without filler
- End with cross-references
- Cite sources when applicable

Authors SHOULD avoid wall-of-prose pages, filler transitions, oversized pages, and orphan pages not represented in the TOC.
