# Validation

Before publishing, run `skillbook validate .` (or `npm run validate`) to check your
skillbook against the format specification.

## What `skillbook validate` Checks

- **Structure** — SKILL.md exists, every section has `00-overview.md`, all TOC paths resolve
- **Consistency** — `00-overview.md` file indexes match actual files in each folder
- **Cross-references** — all relative markdown links resolve to actual files (no broken links)
- **Sync** — `package.json` fields match SKILL.md frontmatter (see [Sync Rules](../04-project/01-package-json.md))
- **Tags** — TAG-INDEX.json entries match page frontmatter (if tags exist)
- **Pages** — within 40-100 line target (warnings, not errors, for minor deviations)
- **Security** — virus scan, prompt injection detection
- **Semver** — version bump is valid against previous publish
- **Content hash** — integrity verification

## Quick Checklist

Before publishing:

- [ ] `SKILL.md` at the root with Agent Skills-compatible frontmatter
- [ ] `README.md` at the root — human-facing catalog content
- [ ] `package.json` with `name` matching SKILL.md, `private: true`, and `skillbook` config
- [ ] `## License` section in SKILL.md with clear usage terms
- [ ] Every section folder has a `00-overview.md`
- [ ] Every content page is listed in the SKILL.md TOC
- [ ] TOC paths resolve to actual files
- [ ] `00-overview.md` file indexes match actual folder contents
- [ ] Pages are 40-100 lines each
- [ ] One concept per page
- [ ] Cross-references use relative paths
- [ ] Version follows semver and matches in both files
- [ ] If pages have `tags` frontmatter, `TAG-INDEX.json` is present and consistent
- [ ] `skillbook validate .` passes

## CI Integration

Add validation to your CI pipeline:

```yaml
# .github/workflows/validate.yml
- run: npm install
- run: npm run validate
```

This catches structural issues before they reach readers.

---

[↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
