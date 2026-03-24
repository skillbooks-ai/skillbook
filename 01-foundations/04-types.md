# Types

Every skillbook has a **type** — either `reference` or `guide`. The type tells agents (and humans) how the content is meant to be used.

## The Two Types

### `reference` — What You Know

A reference skillbook is source material an agent looks things up in. It's the dictionary, the encyclopedia, the regulatory text, the complete works of Shakespeare, the API specification.

Reference skillbooks are **authoritative, citable, and comprehensive** within their domain. An agent retrieves specific pages to ground its responses in verified facts rather than generating from training data.

**Examples:**
- The EU AI Act (full regulatory text)
- Shakespeare's Complete Works
- The FDA Food Code
- An API reference

**How agents use them:** Retrieve specific pages to quote, cite, fact-check, or answer questions with ground truth.

### `guide` — What You Do

A guide skillbook gives an agent a process to follow, a methodology to apply, or a set of rules that shape behavior. It's the Rick Steves travel guide, the study prep book, the coding style guide, the compliance checklist.

Guide skillbooks are **instructional, opinionated, and actionable**. They change how an agent approaches a task — not just what it knows, but what it does with what it knows.

**Examples:**
- An exam prep methodology
- A Jobs-to-be-Done innovation framework
- A brand voice and editorial style guide
- A code review checklist

**How agents use them:** Follow workflows, apply frameworks, enforce rules, shape outputs.

## Why Only Two Types?

Every kind of content collapses into one of these two:

| Content | Type | Why |
|---------|------|-----|
| Encyclopedia, dictionary, atlas | `reference` | You look things up in it |
| Textbook, workbook, tutorial | `guide` | You learn by following it |
| Rulebook, compliance framework | `guide` | It directs behavior |
| Style guide, brand voice doc | `guide` | It shapes how you act |
| Anthology, curated collection | `reference` | It's selective source material |
| Catalog, directory, listing | `reference` | You browse and select from it |
| Novel, case studies | `reference` | Source material for analysis |

The type system is intentionally minimal. Two types that compose with each other are more powerful than a sprawling taxonomy.

## Composition

The real power is in **pairing** references with guides. An agent with the right reference and the right guide gets capabilities neither provides alone:

- **FDA Food Code** (reference) + **Exam Prep Methodology** (guide) = a food safety study assistant
- **Shakespeare Complete Works** (reference) + **Literary Analysis Framework** (guide) = a literature tutor
- **API Specification** (reference) + **Code Review Checklist** (guide) = an API integration reviewer

The same reference can pair with different guides for different outcomes. The same guide can apply to different references. This is combinatorial capability — not pre-baked, single-purpose tools.

## Keywords

While type is a controlled vocabulary (`reference` or `guide`), **keywords** are free-form tags for discovery — similar to npm's `keywords` array. They let authors describe their domain, audience, and subject matter without needing a fixed taxonomy.

Keywords go in SKILL.md frontmatter as `skillbook-keywords` (comma-separated string) and in `package.json` as the standard npm `keywords` array.

Good keywords are specific and useful for search:
- ✅ `food-safety, fda, regulatory, restaurant-inspection`
- ❌ `reference, book, knowledge` (too generic — that's what `type` is for)

---

[← Previous: Naming Conventions](03-naming-conventions.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
