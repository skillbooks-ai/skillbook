# SKILL.md Frontmatter

Skillbook frontmatter is a compatible extension of the
[Agent Skills specification](https://agentskills.io/specification). Skillbook-specific fields
live under `metadata` with a `skillbook-` prefix. Structured capabilities and resource delivery
belong in `package.json`, not YAML frontmatter.

## Example

```yaml
---
name: eu-ai-act
description: >-
  Apply and cite the EU Artificial Intelligence Act. Use when classifying AI-system risk,
  determining compliance obligations, or answering questions that require authoritative text.
license: "CC BY-NC 4.0"
compatibility: "Requires HTTPS access to https://skillbooks.ai"

metadata:
  skillbook-title: "EU AI Act"
  skillbook-publisher: "brookr"
  skillbook-author: "European Parliament and Council of the European Union"
  skillbook-contact: "https://x.com/skillbooks"
  skillbook-server: "https://skillbooks.ai"
  skillbook-version: "2.0.0"
  skillbook-pages: "94"
  skillbook-price: "$14.00"
  skillbook-tags: "true"
  skillbook-keywords: "ai-regulation, eu-law, compliance, risk-classification"
---
```

## Agent Skills Fields

| Field | Skillbook requirement | Description |
|---|---|---|
| `name` | MUST | URL-safe identifier. Max 64 chars, lowercase letters, numbers, and hyphens. |
| `description` | MUST | What the book enables and when to use it. Max 1024 chars. |
| `license` | MUST | License identifier or reference to a bundled license file. |
| `compatibility` | SHOULD when needed | Environment, runtime, network, or system requirements. |
| `metadata` | MAY | String-to-string map for namespaced extension fields. |
| `allowed-tools` | MAY | Experimental Agent Skills field; support varies by client. |

Top-level `author` and `version` are not Agent Skills fields. Put publisher and content-author
identity in namespaced metadata and put the package version in `package.json`.

## Skillbook Metadata

| Key | Required | Description |
|---|---|---|
| `skillbook-title` | Recommended | Human-readable display title. |
| `skillbook-publisher` | Recommended | Person or organization maintaining and publishing the package. |
| `skillbook-author` | Recommended | Originator of the domain content, distinct from publisher. |
| `skillbook-contact` | No | Creator contact: email, URL, or social handle. |
| `skillbook-server` | When hosted | Base URL for hosted pages and resources. |
| `skillbook-version` | Recommended | Semver matching top-level `package.json.version`. |
| `skillbook-pages` | No | Count of hosted content pages, including numbered overviews. |
| `skillbook-price` | No | Display price, such as `"$14.00"` or `"$0.00"`. |
| `skillbook-tags` | No | `"true"` when `TAG-INDEX.json` exists. |
| `skillbook-keywords` | Recommended | Comma-separated discovery keywords. |

All metadata values MUST be strings. Parsers should coerce pages to integer, tags to boolean,
and price to a display value. Capability IDs do not need a duplicated metadata string: agents
read the root `## Capabilities` section and catalog tooling reads `package.json`.

Every root and nested capability entry SHOULD pass `skills-ref validate` from the Agent Skills
reference library.

---

[↑ Section](00-overview.md) | [Next: Navigation & TOC →](02-navigation-and-toc.md) | [🏠 Home](../SKILL.md)
