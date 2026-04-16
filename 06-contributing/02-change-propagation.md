# Change Propagation

When the Skillbook Format specification changes, several downstream artifacts MUST be updated
to stay in sync. This page maps every spec area to the systems that depend on it.

**Rule: no spec change ships without updating everything in its row.**

## Propagation Matrix

### Foundations (01)

| Spec area | Downstream artifacts |
|---|---|
| Directory structure (`02`) | `@skillbooks/validate` (validateStructure.ts), `@skillbooks/cli` (publish.ts file walker), API worker (content handler), authoring guide |
| Naming conventions (`03`) | `@skillbooks/validate` (regex patterns in validateStructure.ts, utils.ts), authoring guide |
| Types — `reference`/`guide` (`04`) | `@skillbooks/validate` (validateSkillMd.ts, validatePackageJson.ts, validateStructure.ts sync rules), API worker (catalog handler), website (catalog UI), authoring guide |

### Entry Points (02)

| Spec area | Downstream artifacts |
|---|---|
| SKILL.md frontmatter fields (`01`) | `@skillbooks/validate` (utils.ts REQUIRED_SKILL_TOP_LEVEL_FIELDS, REQUIRED_SKILL_METADATA_FIELDS, validateRequiredSkillFields), API worker (SKILL.md parser), authoring guide, existing books |
| Navigation & TOC format (`02`) | `@skillbooks/validate` (validateSkillMd.ts TOC_LINE_PATTERN, extractTocBulletLines), authoring guide |
| License section requirement (`03`) | `@skillbooks/validate` (validateSkillMd.ts license check), authoring guide |
| README requirements (`04`) | `@skillbooks/validate` (validateStructure.ts requiredFiles), API worker (catalog handler), authoring guide |

### Content (03)

| Spec area | Downstream artifacts |
|---|---|
| Section overviews — `00-overview.md` (`01`) | `@skillbooks/validate` (validateStructure.ts 00-overview check), authoring guide |
| Content page rules — line counts (`02`) | `@skillbooks/validate` (validateStructure.ts line count warnings), authoring guide |
| Tags & TAG-INDEX.json (`03`) | `@skillbooks/validate` (tag consistency checks — planned), API worker (tag-index handler), `@skillbooks/cli` (tag-index command), authoring guide |

### Project Configuration (04)

| Spec area | Downstream artifacts |
|---|---|
| package.json `skillbook` key (`01`) | `@skillbooks/validate` (validatePackageJson.ts), `@skillbooks/cli` (publish.ts reads name/version from package.json), authoring guide, existing books |
| package.json ↔ SKILL.md sync rules (`01`) | `@skillbooks/validate` (validateStructure.ts syncPairs array), authoring guide |
| Versioning policy (`02`) | `@skillbooks/validate` (validateSemver.ts), `@skillbooks/cli` (version bump logic), API worker (version comparison on publish) |
| Pricing format (`03`) | `@skillbooks/validate` (price regex in utils.ts and validatePackageJson.ts), API worker (pricing/metering), website (pricing display) |

### Tooling (05)

| Spec area | Downstream artifacts |
|---|---|
| Validation checklist (`01`) | `@skillbooks/validate` (the library IS this checklist — keep them 1:1), this propagation page |
| Publishing workflow (`02`) | `@skillbooks/cli` (publish command), API worker (publish endpoint), authoring guide |

## Artifact Index

For quick reference, here's where each downstream artifact lives:

| Artifact | Location | What it does |
|---|---|---|
| `@skillbooks/validate` | `packages/validate/src/` | Shared validation library — enforces the spec |
| `@skillbooks/cli` | `packages/cli/src/` | `skillbook validate`, `skillbook publish`, `skillbook tag-index` |
| API worker | `packages/worker/src/` | Serves content, handles publish, metering |
| Website | `packages/www/` | Marketing site, catalog, pricing display |
| Authoring guide | `skillbook-authoring/` (separate repo/skillbook) | How-to guide for creators |
| Existing books | `books/` + published books | May need migration when breaking changes land |
| Spec skillbook (this repo) | `skillbook-spec/` | The specification itself — update CHANGELOG.md |

## How to Use This Page

1. Before merging a spec change, scan the relevant row(s) above
2. Open issues or include patches for every listed downstream artifact
3. If a downstream update can't ship simultaneously, note the gap in the PR description
4. Breaking changes (field renames, new required files) MUST update all artifacts before release

---

[← Previous: How to Contribute](01-how-to-contribute.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
