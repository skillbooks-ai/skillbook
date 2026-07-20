# Versioning

Skillbooks use strict **semver** (major.minor.patch). Versions communicate whether an installed
capability contract and its resource pointers remain compatible.

## Capability Compatibility

| Change | Example | Meaning |
|---|---|---|
| **Patch** | 1.0.0 → 1.0.1 | Corrections and instruction improvements that preserve outcomes, entries, and resource IDs. |
| **Minor** | 1.0.0 → 1.1.0 | New backward-compatible capabilities or resources. Existing activation and pointers still work. |
| **Major** | 1.0.0 → 2.0.0 | Removed or incompatible outcomes, entries, delivery behavior, or stable resource IDs. |

More specifically:

- Adding a capability or new optional resources is normally a **minor** change.
- Fixing instructions without changing the promised outcome is normally a **patch** change.
- Removing a capability, changing its outcome incompatibly, changing stable resource IDs, or
  breaking existing activation paths is a **major** change.

## Hosted Updates

Hosted resources and the installed index MUST be version-compatible. Publishers SHOULD make
patch and minor improvements available to an existing entitlement within the same major version;
continuous expert maintenance is a central benefit of hosted delivery. A major version requires
an explicit client upgrade and MAY be sold separately under platform terms.

The format does not silently update capability instructions during a run. An installer or client
selects a package version, and the resolver verifies fetched content against that package's index.

## Sync

When root metadata exposes `skillbook-version`, it must match `package.json.version`.
`skillbook validate` checks this.

---

[← Previous: package.json](01-package-json.md) | [↑ Section](00-overview.md) | [Next: Pricing →](03-pricing.md) | [🏠 Home](../SKILL.md)
