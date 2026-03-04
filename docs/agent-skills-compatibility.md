# Agent Skills Compatibility

## Overview

Skillbook Format is designed as a **strict superset** of the Agent Skills open standard. Every valid Skillbook `SKILL.md` file is also a valid Agent Skills file, meaning existing tools can consume Skillbooks without any modification. This ensures backward compatibility while enabling powerful extensions for Skillbook-aware tools.

## Field Comparison

### Standard Agent Skills Fields
- `name` — skill identifier
- `description` — human-readable summary
- `license` — SPDX license expression
- `compatibility` — tool/version requirements (frontmatter)
- Standard directories: `SKILL.md`, `scripts/`, `references/`, `assets/`

### Skillbook Extensions (namespaced under `skillbooks-`)
- `skillbooks-version` — format version
- `skillbooks-category` — taxonomy classification
- `skillbooks-tags` — searchable keywords
- `skillbooks-author` — creator information
- `skillbooks-homepage` — documentation URL
- `skillbooks-repository` — source control location
- `skillbooks-versions` — version history
- `skillbooks-dependencies` — runtime requirements

## Discovery

Agent Skills consumers discover skills via:
1. Scanning `~/.agent-skills/` or project-local `.agent-skills/`
2. Reading root-level `SKILL.md` for metadata
3. Executing scripts from the `scripts/` directory

Skillbook-aware tools perform **additional discovery**:
- Check for `skillbooks.json` manifest alongside `SKILL.md`
- Index extended metadata for advanced search/filtering
- Validate namespace-prefixed fields

## Migration Guide: Agent Skill → Skillbook

1. **Keep existing `SKILL.md`** — already valid
2. **Add skillbook frontmatter** to the YAML header:

```yaml
---
name: my-skill
description: Does useful work
license: MIT
compatibility:
  - claude-code: ">=1.0"
skillbooks-version: "1.0"
skillbooks-category: development
skillbooks-tags: [testing, automation]
---
```

3. **Optional**: Add `skillbooks.json` for rich metadata
4. **Retain directory structure** — no changes required

## Non-Skillbook-Aware Tool Behavior

When a standard Agent Skills tool loads a Skillbook:
- It reads only the base fields (`name`, `description`, etc.)
- Extended `skillbooks-*` fields are **ignored silently**
- All scripts in `scripts/` execute normally
- Directory conventions remain fully compatible

Skillbooks degrade gracefully — they work everywhere Agent Skills works, with enhanced features available only in Skillbook-aware tools.
