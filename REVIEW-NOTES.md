# Review Notes — Skillbook Format Repo

This review reconciled generated files with `FORMAT-REFERENCE.md` (source of truth) and corrected spec drift across docs and examples.

## 1. Accuracy Fixes (Spec Alignment)

Updated the following files to match canonical requirements:

- `spec/01-structure.md`
- `spec/02-skill-md.md`
- `spec/03-content-pages.md`
- `spec/04-metadata-publishing.md`

Key corrections:

- Enforced Agent Skills + `metadata.skillbooks-*` frontmatter model.
- Added explicit migration guidance from legacy top-level frontmatter fields.
- Added explicit validation guidance (`skills-ref validate`, `skillbook validate`).
- Added missing rule that `SKILL.md` is the sole navigation source (`SUMMARY.md` must not be used).
- Corrected tags guidance from hard requirement to recommendation where the canonical spec uses SHOULD:
  - `TAG-INDEX.json` is recommended when pages use tags.
- Added missing plain-markdown constraint (no HTML/custom syntax requirement).
- Normalized RFC 2119 language to MUST/SHOULD/MAY in normative statements.

## 2. README Structure/Consistency Fixes

Updated:

- `README.md`

Key corrections:

- Replaced incorrect flat `chapters/` quick example with canonical `NN-section/00-overview.md` + `NN-page.md` structure.
- Updated spec badge to `v1.1`.
- Aligned wording to canonical Agent Skills extension model.

## 3. Supporting Docs Consistency Fixes

Updated:

- `docs/agent-skills-compatibility.md`
- `docs/faq.md`

Key corrections:

- Removed non-canonical extension keys and obsolete schema claims.
- Aligned compatibility/migration examples to `metadata.skillbooks-*` model.
- Fixed links and references to canonical files in this repository.
- Kept pricing/versioning explanations consistent with 80/20 split and semver billing behavior.

## 4. Example Skillbooks — Compliance Repairs

### `examples/minimal/`

Updated:

- `SKILL.md`
- `book.json`
- `01-basics/00-overview.md`
- `01-basics/01-hello.md`

Fixes:

- Rebuilt `SKILL.md` as valid YAML frontmatter + markdown sections.
- Corrected metadata key names and string typing.
- Added required navigation instructions, proper TOC format with path + one-line descriptions, and compliant license section.
- Ensured section overview includes required elements and content page includes cross-reference.
- Brought page lengths to target ranges (`00-overview`: 20-40 lines target, content page: 40-100 lines target).

### `examples/standard/`

Updated:

- `SKILL.md`
- `book.json`
- `01-fundamentals/00-overview.md`
- `02-patterns/00-overview.md`

Fixes:

- Replaced invalid structured YAML body (`toc`, `navigation`, etc.) with canonical markdown body format.
- Corrected frontmatter keys to `metadata.skillbooks-*` with string values.
- Added canonical navigation instructions (`{server}/{name}/{path}`, `X-Skillbook-Key`, `402`, free `SKILL.md`).
- Corrected TOC format and descriptions.
- Normalized `book.json` schema to canonical fields (`id`, `title`, `version`, `language`, `verified`, `structure.readme`, etc.).
- Expanded section overviews to include required elements and line targets.

### `examples/tagged/`

Updated:

- `SKILL.md`
- `book.json`
- `01-concepts/00-overview.md`
- `02-infrastructure/00-overview.md`
- `01-concepts/01-networking.md`
- `01-concepts/02-compute.md`
- `02-infrastructure/01-storage.md`
- `02-infrastructure/02-security.md`

Fixes:

- Rebuilt `SKILL.md` to canonical frontmatter + markdown format.
- Added `metadata.skillbooks-tags: "true"` and free tag-index navigation instructions.
- Corrected TOC entries to full root-relative section paths.
- Normalized `book.json` to canonical schema with `structure.tagIndex`.
- Reduced/rewrote section overviews to target range and required structure.
- Standardized per-page tag frontmatter to match `TAG-INDEX.json` exactly.
- Replaced non-linked “related topics” text with explicit relative markdown links.

## 5. Consistency Outcomes

Repository now aligns on:

- Agent Skills superset frontmatter model
- `metadata.skillbooks-*` naming
- Semver billing behavior
- 80/20 revenue split
- TOC path/description conventions
- `00-overview.md` role and placement
- Canonical `book.json` field model

## 6. Notes

- `FORMAT-REFERENCE.md` was not edited.
- `TASK-LIST.md`, `grind.py`, and `grind.sh` were not edited.
