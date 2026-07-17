# Changelog

All notable changes to the Skillbook Format specification are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-07-17

### Added

- Outcome-based `skillbook.capabilities` declarations with stable IDs, activation conditions,
  observable outcomes, Agent Skills entry points, and optional evaluation references
- Optional `skillbook.resources` contract for pointer-only search, bounded fetch, portable local
  or hosted delivery, version compatibility, and digest verification
- Machine-readable JSON Schema for the v2 `package.json` manifest
- Three-condition capability evaluation guidance covering web, no-web, and no-web-plus-Skillbook
  runs, with frozen entries, transfer cases, blind judging, and efficiency evidence
- Capability examples for Shakespeare, EPA 608 / HVAC test prep, and THRV Jobs-to-be-Done

### Changed

- Made the capability the unit of discovery, activation, and evaluation within the book bundle
- Allowed TOC navigation, indexed retrieval, or both; large books no longer need to enumerate
  every resource in the root entry
- Replaced per-page metering guidance with optional per-book entitlements and compatible hosted
  updates within a major version
- Corrected Agent Skills frontmatter: publisher information now uses namespaced
  `metadata.skillbook-publisher` instead of a non-standard top-level `author` field
- Clarified that agent-consumable resources need not duplicate a human-readable book layout
- Replaced arbitrary Markdown line targets with task-bounded resources and a roughly 2,000-token
  progressive-disclosure target

### Removed

- Global `reference` / `guide` type classification and `skillbook.type`
- `metadata.skillbook-type`

## [1.2.0] - 2026-03-24

### Added

- Foundations page for the two-type system: `reference` and `guide`
- Guidance on composition: pairing references with guides for combinatorial capability
- `skillbook-type` / `skillbook.type` requirements in frontmatter and package metadata examples

### Changed

- Marked this specification skillbook as `reference` (it is authoritative source material)
- README updated with a short two-type overview and spec badge to `v1.2`
- Added lightweight type mentions in Agent Skills extension, directory structure, content page guidance, and examples
- Clarified that `keywords` are free-form discovery tags, separate from the controlled `type` field

## [1.1.1] - 2026-03-23

### Added

- `eval/` as standard optional directory: `EVAL.md` + `eval-report.json` served free, `raw/` not served
- Skill Eval row in directory structure "What Belongs Where" table

### Changed

- Section overview target length from 20-40 to 20-80 lines (validated across 16+ books)

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
