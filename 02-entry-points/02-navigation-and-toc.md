# Capability Routing & Navigation

After frontmatter, the root `SKILL.md` tells agents which capability to activate and how to
retrieve only the supporting resources that capability needs.

## Capabilities Section

Every Skillbook MUST include a concise `## Capabilities` section. Use stable IDs and expose the
same `when`, `outcome`, and `entry` values declared in `package.json`.

```markdown
## Capabilities

- **`classify-risk`** — Use when determining an AI system's EU AI Act risk tier.
  Outcome: an evidence-linked classification with unresolved facts.
  Activate: `skills/classify-risk/SKILL.md`.
- **`answer-authoritatively`** — Use when an answer must trace to the Act's text.
  Outcome: a concise answer with article-level citations.
  Activate: `skills/answer-authoritatively/SKILL.md`.
```

The root SHOULD state composition order when several capabilities form a useful sequence. For a
single outcome, agents SHOULD load only the selected entry.

## Resource Navigation

Every required resource MUST be discoverable through one or both of these patterns:

### Table of Contents

Use a TOC for a bounded page set. Group pages under section headers and give every page a
descriptive one-line entry. Include numbered `00-overview.md` pages.

```markdown
### 02 — Risk Classification

- `02-risk-classification/00-overview.md` — The risk-based approach and navigation
- `02-risk-classification/01-four-tiers.md` — Unacceptable, high, limited, and minimal risk
```

### Pointer Search

Use an index for a large or agent-optimized corpus. Show the exact search and fetch invocation,
state that search returns pointers rather than prose, and tell the agent how many resources to
fetch by default. Do not list thousands of resources in `SKILL.md`.

See [Resource Indexes & Delivery](../03-content/04-resource-indexes-and-delivery.md).

## Hosted Access

Tell the agent:

- how hosted URLs are formed: `{server}/{name}/{path}`
- that `Authorization: Bearer <key>` is the preferred authentication form
- which environment variable supplies the key when a bundled resolver is used
- what unauthenticated or insufficient-credit responses mean
- which discovery files are public

Platforms MAY support `X-Skillbook-Key` as a compatibility header. Agents MUST NOT print or
redistribute credentials.

The root `SKILL.md` is the capability map and concise navigation layer. There is no separate
`SUMMARY.md`. Large indexed books do not need a full page-level TOC in the root.

---

[← Previous: Frontmatter](01-frontmatter.md) | [↑ Section](00-overview.md) | [Next: License & Quick Start →](03-license-and-quickstart.md) | [🏠 Home](../SKILL.md)
