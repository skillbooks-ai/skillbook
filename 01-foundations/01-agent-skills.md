# Agent Skills Foundation

Skillbooks are built on top of the **[Agent Skills](https://agentskills.io)** open standard — the
interoperability layer adopted by 30+ tools including Claude Code, Cursor, Gemini CLI, VS Code,
GitHub Copilot, Windsurf, and more.

Every skillbook's `SKILL.md` is a valid Agent Skills file. Any tool that understands Agent Skills
can discover, read, and use a skillbook's entry point out of the box — no special integration needed.

## What Agent Skills Provides (the base layer)

- `name` and `description` frontmatter for discovery
- `author` for attribution
- `license` for usage terms
- `compatibility` for environment requirements
- `metadata` for extension fields
- Standard directory conventions (`SKILL.md`, `scripts/`, `references/`, `assets/`)

## What the Skillbook Format Adds (the extension layer)

- Structured multi-page content with sections and a table of contents
- Metered per-page access and credit-based billing
- Tag-based lookup via `TAG-INDEX.json`
- Skillbook-specific config in `package.json` under the `skillbook` key
- Source attribution and verification pipeline
- All skillbook-specific SKILL.md fields namespaced under `metadata` with a `skillbook-` prefix

Because of this layered design, a skillbook works everywhere Agent Skills work — and adds
structured content and commercial publishing capabilities on top.

## Why This Matters

An agent that already uses Agent Skills doesn't need a new integration to read skillbooks.
The SKILL.md is the entry point it already knows. The multi-page structure, pricing, and
tag system are progressive enhancements — present when needed, invisible when not.

---

[↑ Section](00-overview.md) | [Next: Directory Structure →](02-directory-structure.md) | [🏠 Home](../SKILL.md)
