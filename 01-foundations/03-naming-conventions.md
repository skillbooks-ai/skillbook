# Naming Conventions

Consistent naming makes skillbooks predictable for both agents and authors.

## Folders

- **Section folders:** `NN-topic-name/` — 2-digit prefix, kebab-case, lowercase
- Prefixes start at `01` and increment sequentially
- Examples: `01-foundations/`, `02-risk-classification/`, `03-compliance/`

## Files

- **Section overview:** `00-overview.md` — always the first file in every section folder
- **Content pages:** `01-` through `NN-` — 2-digit prefix, kebab-case, lowercase
- **No spaces.** All names lowercase, hyphen-separated
- Examples: `01-four-tiers.md`, `02-unacceptable-risk.md`, `03-high-risk-deep.md`

## Namespace

Books live at the top of the server namespace: `{server}/{name}/`.

- The `server` value is set in SKILL.md metadata (e.g., `https://skillbooks.ai`)
- Book names are **first-come, first-served** within a given server (like npm packages)
- No author prefix — it's `{server}/eu-ai-act`, not `{server}/brookr/eu-ai-act`
- Names must be URL-safe: lowercase, hyphens only, max 64 characters
- No leading, trailing, or consecutive hyphens

## Numeric Shorthand

Pages can be addressed by their numeric path: `{server}/eu-ai-act/02/01` resolves
to the first content page in the second section (`02-risk-classification/01-four-tiers.md`).
Numeric shorthand is a server convenience — authors don't need to do anything special to enable it.

---

[← Previous: Directory Structure](02-directory-structure.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
