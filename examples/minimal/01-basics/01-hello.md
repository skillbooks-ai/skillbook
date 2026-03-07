# Getting Started

This page explains how to navigate a minimal skillbook and use its metadata correctly.

## What to Check First

- Confirm `SKILL.md` exists at the repository root.
- Confirm `book.json` exists with required fields.
- Confirm this section includes `00-overview.md` and at least one content page.

## Navigation Basics

- Use the `SKILL.md` table of contents to choose pages.
- Resolve paths relative to the book root.
- Fetch only the pages needed for the current task.

## Frontmatter Basics

A valid skillbook frontmatter block includes Agent Skills base fields plus `metadata.skillbooks-*` fields.
All metadata values are strings, including `skillbooks-pages` and `skillbooks-price`.

## Practical Workflow

1. Read `SKILL.md` to identify relevant page paths.
2. Open `00-overview.md` for section-level orientation.
3. Read the target content page.
4. Follow cross-references for adjacent topics.

## Common Mistakes

- Using flat chapter files instead of section folders.
- Omitting `00-overview.md` from a section.
- Leaving TOC entries without one-line descriptions.

## Validation Reminder

Before publishing, run `skillbook validate ./my-book` and address structural errors first.
Line-length warnings can be handled after correctness checks pass.

## See Also

- [Basics Overview](./00-overview.md)
