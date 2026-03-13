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

To publish an update, bump the version in both `package.json` and SKILL.md metadata
(see [Sync Rules](../04-project/01-package-json.md)), then run `skillbook publish .` again.

How you bump the version determines how the update affects existing readers:

- **Patch** (1.0.0 → 1.0.1) — fixes, no new charges
- **Minor** (1.0.0 → 1.1.0) — new pages metered, existing access preserved
- **Major** (1.0.0 → 2.0.0) — full re-meter, signals significant rewrite

See [Versioning](../04-project/02-versioning.md) for the full policy.

## Self-Hosting

Publishing to a platform is optional. You can serve a skillbook from any static file host,
your own server, or use it locally. The format works the same — the CLI and platform
are conveniences, not requirements.

---

[← Previous: Validation](01-validation.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
