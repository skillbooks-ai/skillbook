# Changelog

All notable changes to the Skillbook Format specification are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-03-12

### Added

- `skillbook-author` field — distinguishes content author from skill publisher
- `skillbook-contact` field — creator contact info
- Publishing page with `skillbook version` and `skillbook publish` workflow
- Self-hosting section with platform benefits callout

### Changed

- Metadata prefix from `skillbooks-` to `skillbook-` (singular)
- Replaced `book.json` with standard `package.json` — skillbook config under the `skillbook` key
- Restructured repository as a skillbook (the spec is the demo)
- Separated format from platform — metering is MAY, not MUST
- Pricing tiers updated: added Textbook tier, public domain in Micro
- Renamed "Agent Skills Foundation" to "Agent Skills Extension"
- Namespace uses `{server}` instead of hardcoded skillbooks.ai

## [1.0.0] - 2026-03-04

### Added

- Agent Skills compatibility as base layer
- Frontmatter uses Agent Skills standard fields with `skillbook-*` extensions under metadata
- Directory structure specification (sections, 00-overview.md, naming conventions)
- SKILL.md specification (frontmatter, navigation, TOC, license, quick start)
- Content pages specification (40-100 lines, one concept, cross-references)
- Tags and TAG-INDEX.json for O(1) topic lookup
- Semver versioning with metering implications
- Pricing model (metered per page)
- Validation checks and pre-publish checklist

### Changed

- Removed SUMMARY.md — SKILL.md TOC is single source of truth
- Replaced folder README.md with 00-overview.md
