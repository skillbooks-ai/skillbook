# Publishing

Publishing a skillbook makes it available on a hosting platform. This page covers
the workflow for publishing to [skillbooks.ai](https://skillbooks.ai) via the
`@skillbooks/cli` tool.

## Prerequisites

- `@skillbooks/cli` installed (`npm i -g @skillbooks/cli`)
- An author account on the target platform
- A skillbook that passes [validation](01-validation.md)

## Workflow

```bash
skillbook login                      # authenticate with your author token
skillbook validate .                 # check everything before publishing
skillbook publish .                  # publish (or update)
skillbook stats my-book              # views, revenue, top pages
```

## First Publish

On first publish, the platform registers your book name. Names are first-come, first-served
within a server — see [Naming Conventions](../01-foundations/03-naming-conventions.md).

The CLI checks:
1. `skillbook validate .` passes
2. `name` is available (or already owned by you)
3. `version` follows semver and is newer than the current published version

## Updates

Bump the version, then publish:

```bash
skillbook version patch              # 1.0.0 → 1.0.1 (fixes, no new charges)
skillbook version minor              # 1.0.0 → 1.1.0 (new pages metered, existing access preserved)
skillbook version major              # 1.0.0 → 2.0.0 (full re-meter, significant rewrite)
skillbook publish .
```

`skillbook version` updates both `package.json` and SKILL.md metadata in one shot —
no manual sync needed. See [Versioning](../04-project/02-versioning.md) for the full policy
on how version bumps affect metering.

## Self-Hosting

Publishing to a platform is optional. You can serve a skillbook from any static file host,
your own server, or use it locally. The format works the same everywhere.

Publishing to [skillbooks.ai](https://skillbooks.ai) adds:
- **Metered billing** — per-page access control and credit-based pricing
- **Analytics** — page views, top pages, reader behavior
- **Discovery** — catalog listing, search, marketplace visibility
- **API keys** — managed authentication for your readers
- **CDN delivery** — global edge caching for fast page loads

---

[← Previous: Validation](01-validation.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
