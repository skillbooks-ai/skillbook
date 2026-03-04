# Format Repo Build — MM Task List

The goal: build the public `skillbooks-ai/format` repo that publishes the Skillbook Format spec as an **Agent Skills extension**.

Each task below is a self-contained doc generation job sized for MiniMax (< 2k tokens output each). Feed them sequentially — each task includes the context it needs.

Status: ⬜ = pending, 🔄 = in progress, ✅ = done, ❌ = failed

---

## Task 1: README.md — Repo landing page
**Output:** `README.md`
**Context needed:** FORMAT.md (summary only), Agent Skills positioning
**Prompt notes:**
- Position as "Skillbook Format: An Agent Skills extension for deep, structured, paid knowledge"
- Explain: Agent Skills are cheat sheets, Skillbooks are textbooks
- Same entry point (SKILL.md), dramatically more depth
- Backward compatible — any Agent Skills consumer can discover a skillbook
- Include: badges, quick example, link to full spec, link to agentskills.io
- Tone: professional open-source project, not marketing
- ~80-120 lines
**Status:** ✅

## Task 2: SPECIFICATION.md — Core spec (Part 1: Structure)
**Output:** `spec/01-structure.md`
**Context needed:** FORMAT.md §Directory Structure, §Naming Conventions, §What Belongs Where
**Prompt notes:**
- Clean extraction of directory structure rules
- Add Agent Skills compatibility note at top
- Include the directory tree diagram
- Naming conventions section
- ~60-80 lines
**Status:** ✅

## Task 3: SPECIFICATION.md — Core spec (Part 2: SKILL.md)
**Output:** `spec/02-skill-md.md`
**Context needed:** FORMAT.md §SKILL.md section, Agent Skills frontmatter fields
**Prompt notes:**
- Frontmatter as strict superset of Agent Skills
- Standard fields vs skillbooks extension fields (under metadata)
- Navigation instructions section
- TOC format rules
- License section requirements
- Quick start paths
- ~100-120 lines
**Status:** ✅

## Task 4: SPECIFICATION.md — Core spec (Part 3: Content Pages)
**Output:** `spec/03-content-pages.md`
**Context needed:** FORMAT.md §Content Pages, §Section Overview, §Tags
**Prompt notes:**
- 00-overview.md rules
- Content page rules (40-100 lines, one concept, self-contained)
- Tags and TAG-INDEX.json
- Cross-references
- ~80-100 lines
**Status:** ✅

## Task 5: SPECIFICATION.md — Core spec (Part 4: Metadata & Publishing)
**Output:** `spec/04-metadata-publishing.md`
**Context needed:** FORMAT.md §book.json, §Versioning, §Pricing, §Publishing
**Prompt notes:**
- book.json schema with field table
- Semver rules and what each bump means for billing
- Pricing tiers (author sets full price, per-page derived)
- Revenue split: 80/20
- Publishing workflow (validate → publish)
- Validation checks list
- ~80-100 lines
**Status:** ✅

## Task 6: README.md for examples directory
**Output:** `examples/README.md`
**Context needed:** Brief description of the example books
**Prompt notes:**
- Explain that examples/ contains minimal skillbook examples
- List: minimal (bare minimum), standard (typical book), tagged (with TAG-INDEX)
- Each is a complete valid skillbook structure
- ~30-40 lines
**Status:** ✅

## Task 7: Minimal example skillbook
**Output:** `examples/minimal/SKILL.md` + `examples/minimal/README.md` + `examples/minimal/book.json` + `examples/minimal/01-basics/00-overview.md` + `examples/minimal/01-basics/01-hello.md`
**Context needed:** FORMAT.md frontmatter spec, directory structure rules
**Prompt notes:**
- Smallest possible valid skillbook (1 section, 2 pages)
- Topic: "Quick Reference Guide" (something generic)
- Valid Agent Skills frontmatter with skillbooks extensions
- Shows the bare minimum to pass validation
- Each file very short (15-30 lines)
- Generate all files concatenated with `--- FILE: path ---` separators
**Status:** ✅

## Task 8: Standard example skillbook
**Output:** `examples/standard/` (SKILL.md, README.md, book.json, 2 sections with 3 pages each)
**Context needed:** FORMAT.md frontmatter spec, directory structure, 00-overview rules
**Prompt notes:**
- Typical skillbook structure (2 sections, ~8 pages total)
- Topic: "API Design Patterns" (relatable to developers)
- Full SKILL.md with TOC, navigation instructions, license, quick start paths
- 00-overview.md in each section with file index
- Cross-references between pages
- Generate all files concatenated with `--- FILE: path ---` separators
**Status:** ✅

## Task 9: Tagged example skillbook
**Output:** `examples/tagged/` (same as standard + TAG-INDEX.json + tags in frontmatter)
**Context needed:** FORMAT.md §Tags, TAG-INDEX.json format
**Prompt notes:**
- Based on standard example but adds tags
- Topic: "Cloud Infrastructure" (good for demonstrating tag utility)
- 2-3 tags per page in frontmatter
- TAG-INDEX.json at root mapping tags to pages
- Shows how tag-based lookup works
- Generate all files concatenated with `--- FILE: path ---` separators
**Status:** ✅

## Task 10: CONTRIBUTING.md
**Output:** `CONTRIBUTING.md`
**Context needed:** This is an open-source spec repo
**Prompt notes:**
- How to propose changes to the spec (GitHub issues → RFC → PR)
- How to submit example skillbooks
- Style guide for spec language (precise, imperative, RFC 2119 keywords)
- Code of conduct reference
- ~50-70 lines
**Status:** ✅

## Task 11: Agent Skills Compatibility Guide
**Output:** `docs/agent-skills-compatibility.md`
**Context needed:** Agent Skills spec summary, our extension approach
**Prompt notes:**
- How Skillbook Format extends Agent Skills
- Which fields are standard vs extension
- How to make a skillbook discoverable by any Agent Skills consumer
- Migration guide: existing Agent Skill → Skillbook
- ~60-80 lines
**Status:** ✅

## Task 12: FAQ
**Output:** `docs/faq.md`
**Context needed:** Common questions from FORMAT.md, positioning notes
**Prompt notes:**
- "What's the difference between an Agent Skill and a Skillbook?"
- "Do I need to use skillbooks.ai to publish?"
- "How is pricing calculated?"
- "Can I use this for free/open content?"
- "What agents support this?"
- "How does versioning affect billing?"
- ~60-80 lines
**Status:** ✅

## Task 13: LICENSE files
**Output:** `LICENSE-APACHE` + `LICENSE-CC-BY`
**Context needed:** Apache 2.0 + CC-BY-4.0 dual license (same as Agent Skills)
**Prompt notes:**
- Standard Apache 2.0 text (spec code/tooling)
- Standard CC-BY-4.0 text (spec documentation)
- Brief header in each explaining scope
- These are boilerplate — MM just needs to output the standard text
**Status:** ✅

## Task 14: Changelog
**Output:** `CHANGELOG.md`
**Context needed:** FORMAT.md §Changes from Pre-1.0, current version
**Prompt notes:**
- Standard Keep a Changelog format
- v1.0.0 entry with all the changes from pre-1.0
- Note Agent Skills compatibility as the headline feature
- ~30-40 lines
**Status:** ✅

---

## Execution Plan

1. Feed tasks 1-5 first (core docs)
2. Then 6-9 (examples)
3. Then 10-14 (supporting docs)
4. I (Bodhi) review all output, fix inconsistencies, commit

Each task prompt should include:
- The relevant section of FORMAT.md as context (copy-paste, not reference)
- The Agent Skills positioning framing
- Output format instructions
- Target line count

Total: 14 tasks, ~1-2 min each on MM = ~20-30 min total grind time.
