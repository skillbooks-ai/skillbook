# Validation

Before publishing, run `skillbook validate .` (or `npm run validate`) to check your
skillbook against the format specification.

## What `skillbook validate` Checks

- **Agent Skills entries** — root and capability `SKILL.md` files satisfy the upstream format
- **Manifest schema** — `package.json` satisfies `schema/skillbook.schema.json`
- **Capabilities** — IDs are unique, entries exist, and root declarations match the manifest
- **Structure** — required files exist and declared navigation paths resolve
- **Consistency** — `00-overview.md` file indexes match actual files in each folder
- **Cross-references** — all relative markdown links resolve to actual files (no broken links)
- **Sync** — `package.json` fields match SKILL.md frontmatter (see [Sync Rules](../04-project/01-package-json.md))
- **Tags** — TAG-INDEX.json entries match page frontmatter (if tags exist)
- **Resources** — declared index/programs/local roots exist and search/fetch JSON honors the contract
- **Context bounds** — warnings for resources likely to exceed the roughly 2,000-token target
- **Security** — prompt injection detection
- **Semver** — version bump is valid against previous publish

## Quick Checklist

Before publishing:

- [ ] `SKILL.md` at the root with Agent Skills-compatible frontmatter
- [ ] `README.md` at the root — human-facing catalog content
- [ ] `package.json` with `name` matching SKILL.md, `private: true`, and `skillbook` config
- [ ] `package.json` passes `schema/skillbook.schema.json`
- [ ] At least one outcome-based capability has `id`, `when`, `outcome`, and a valid entry
- [ ] Root `## Capabilities` declarations match the package manifest
- [ ] `## License` section in SKILL.md with clear usage terms
- [ ] Every resource is discoverable through a TOC or declared pointer index
- [ ] All declared paths and Markdown links resolve
- [ ] Each fetched resource is a coherent unit and normally stays within the context target
- [ ] Resource boundaries reflect independent selection, not arbitrary file size
- [ ] Cross-references use relative paths
- [ ] Version follows semver and matches in both files
- [ ] A declared binary index is included in the package, not dropped by a text-only file walker
- [ ] Search returns pointer metadata without bodies; fetch returns one bounded resource
- [ ] Hosted resolvers read credentials from the declared environment and fail closed on digest mismatch
- [ ] If pages have `tags` frontmatter, `TAG-INDEX.json` is present and consistent
- [ ] Capability eval references resolve; published claims separate regression and transfer results
- [ ] `skillbook validate .` passes

## CI Integration

Add validation to your CI pipeline or pre-commit hook:

```yaml
# .github/workflows/validate.yml
- run: npm install
- run: npm run validate
```

This catches structural issues before they reach readers.

---

[↑ Section](00-overview.md) | [Next: Publishing →](02-publishing.md) | [🏠 Home](../SKILL.md)
