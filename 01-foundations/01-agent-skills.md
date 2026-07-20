# Agent Skills Extension

Skillbooks are built on top of the **[Agent Skills](https://agentskills.io)** open standard, an
interoperability layer supported across multiple agent products.

Every skillbook's `SKILL.md` is a valid Agent Skills file. Any tool that understands Agent Skills
can discover, read, and use a skillbook's entry point out of the box — no special integration needed.

## What Agent Skills Provides (the base layer)

- `name` and `description` frontmatter for discovery
- `license` for usage terms
- `compatibility` for environment requirements
- `metadata` for extension fields
- `allowed-tools` for experimental pre-approved tool declarations
- Standard directory conventions (`SKILL.md`, `scripts/`, `references/`, `assets/`)

## What the Skillbook Format Adds (the extension layer)

- A package manifest that groups one or more Agent Skills-compatible capability entries
- Structured content discoverable by a table of contents, a pointer index, or both
- Optional exact-resource search and local/hosted resolution
- Optional paid-book entitlements and hosted subscriber delivery
- Tag-based lookup via `TAG-INDEX.json`
- Skillbook-specific config in `package.json` under the `skillbook` key
- Source attribution and verification pipeline
- All skillbook-specific SKILL.md fields namespaced under `metadata` with a `skillbook-` prefix

The Skillbook package manifest is a distribution and catalog layer. Capability entry points remain
ordinary Agent Skills: clients that do not understand Skillbook extensions can still install and
activate them directly.

Agent Skills uses progressive disclosure: discovery metadata first, task instructions when
activated, and detailed resources only when needed. Skillbooks preserve those layers and add a
portable routing contract for expert corpora that are too large—or too commercially sensitive—to
ship into every prompt. See the upstream guidance on
[progressive disclosure](https://agentskills.io/skill-creation/best-practices).

## Why This Matters

An agent that already uses Agent Skills doesn't need a new integration to read skillbooks.
The root SKILL.md is the entry point it already knows. Capability routing, resource indexes,
pricing, and hosted delivery are progressive enhancements — present when needed, invisible when not.

---

[↑ Section](00-overview.md) | [Next: Directory Structure →](02-directory-structure.md) | [🏠 Home](../SKILL.md)
