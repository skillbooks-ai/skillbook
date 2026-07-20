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
4. Capability entries, resolver programs, and declared binary indexes are included

## Updates

Bump the version, then publish:

```bash
skillbook version patch              # 1.0.0 → 1.0.1 (compatible corrections)
skillbook version minor              # 1.0.0 → 1.1.0 (compatible capabilities/resources)
skillbook version major              # 1.0.0 → 2.0.0 (incompatible capability contract)
skillbook publish .
```

`skillbook version` updates both `package.json` and SKILL.md metadata in one shot —
no manual sync needed. See [Versioning](../04-project/02-versioning.md) for the compatibility
policy.

## Self-Hosting

Publishing to a platform is optional. You can serve a skillbook from any static file host,
your own server, or use it locally. The format works the same everywhere.

Publishing to [skillbooks.ai](https://skillbooks.ai) adds:
- **Paid entitlements** — per-book purchases and subscriber access
- **Analytics** — page views, top pages, reader behavior
- **Discovery** — catalog listing, search, marketplace visibility
- **API keys** — managed authentication for your readers
- **CDN delivery** — global edge caching for fast page loads

## Full and Thin Editions

A full edition includes local resources. A thin edition includes capability entries, resolver
programs, and a pointer index while licensed content stays hosted. Both editions MUST expose the
same capability IDs and resource URIs for a given major version.

Publish resource bodies and their matching index atomically. A client with a stale index MUST
fail a digest check instead of silently consuming mismatched content. Packaging tools MUST copy
declared artifacts by manifest path; a text-extension allowlist can accidentally omit SQLite or
other binary indexes.

Hosted editions SHOULD use bearer authentication from the manifest-declared environment. License
terms may prohibit bulk extraction or redistribution, but instructions and contentless indexes
are not DRM. Authors who want continuous updates SHOULD treat hosting, version compatibility, and
subscriber access as a delivery service rather than claiming the downloaded package is uncopyable.

---

[← Previous: Validation](01-validation.md) | [↑ Section](00-overview.md) | [Next: Evaluating Capabilities →](03-evaluating-capabilities.md) | [🏠 Home](../SKILL.md)
