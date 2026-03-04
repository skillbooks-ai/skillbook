# Changelog

All notable changes to the Skillbook Format specification are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-10

### Added

- Agent Skills compatibility as base layer
- Frontmatter uses Agent Skills standard fields with `skillbooks-*` extensions under metadata
- Directory structure specification (sections, 00-overview.md, naming conventions)
- SKILL.md specification (frontmatter, navigation, TOC, license, quick start)
- Content pages specification (40-100 lines, one concept, cross-references)
- Tags and TAG-INDEX.json for O(1) topic lookup
- book.json metadata schema
- Semver versioning with billing implications
- Pricing model with 80/20 revenue split
- Publishing workflow: validate then publish
- Three example skillbooks: minimal, standard, tagged

### Changed

- Removed SUMMARY.md — SKILL.md TOC is single source of truth
- Replaced folder README.md with 00-overview.md
- Revenue split changed from 90/10 to 80/20 (platform absorbs Stripe fees)
- Removed `structure.summary` from book.json
