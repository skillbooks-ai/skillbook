# Agent Skills Compatibility

## Overview

Skillbook Format is a strict superset of the Agent Skills open standard. Every valid skillbook `SKILL.md` is a valid Agent Skills file.

Base Agent Skills tools can consume the entry point directly, while Skillbook-aware tools add support for multi-page navigation, pricing metadata, and publishing workflows.

## Field Model

### Agent Skills Base Fields (top-level frontmatter)

- `name`
- `description`
- `license`
- `compatibility` (optional)
- `metadata` (optional string map)

### Skillbook Extension Fields (`metadata.skillbooks-*`)

- `skillbooks-title`
- `skillbooks-server`
- `skillbooks-version`
- `skillbooks-pages`
- `skillbooks-price`
- `skillbooks-tags` (optional, `"true"` when `TAG-INDEX.json` is present)

All extension values are strings for Agent Skills compatibility.

## Discovery Behavior

Agent Skills consumers discover skills by reading root `SKILL.md` and standard directories (`scripts/`, `references/`, `assets/`).

Skillbook-aware consumers additionally:

- Parse table-of-contents paths in `SKILL.md`
- Fetch paid pages from `{server}/{name}/{path}`
- Optionally fetch `{server}/{name}/TAG-INDEX.json` for O(1) tag lookup

## Migration: Agent Skill to Skillbook

1. Keep your existing Agent Skills-compatible `SKILL.md` frontmatter.
2. Add Skillbook extension fields under `metadata` using `skillbooks-` prefixes.
3. Add section directories with `00-overview.md` and content pages.
4. Add `book.json` for catalog metadata.

Example:

```yaml
---
name: my-skillbook
description: Deep reference for my domain.
license: all-rights-reserved
compatibility: "Requires HTTP access to skillbooks.ai"
metadata:
  skillbooks-title: "My Skillbook"
  skillbooks-server: "https://skillbooks.ai"
  skillbooks-version: "1.0.0"
  skillbooks-pages: "12"
  skillbooks-price: "$6.00"
---
```

## Non-Skillbook-Aware Tool Behavior

Tools that only implement Agent Skills will still parse standard fields and ignore unknown `metadata` keys. This preserves compatibility while allowing Skillbook-specific features in enhanced runtimes.
