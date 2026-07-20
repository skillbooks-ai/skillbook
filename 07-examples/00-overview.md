# Examples

The same capability model works for primary sources, training material, and proprietary expert
methods. These sketches show outcome boundaries; authors should validate the exact split against
real user tasks.

## Shakespeare Complete Works

The [complete works repository](https://github.com/skillbooks-ai/skillbook-shakespeare-complete)
contains 725 scenes. It should not be labeled globally as a reference book: a reader may need
retrieval, textual comparison, or an interpretive procedure.

```json
"capabilities": [
  {
    "id": "retrieve-passage",
    "when": "Locating Shakespeare text by work, act, scene, speaker, line, or remembered phrase",
    "outcome": "The exact bounded passage with a stable work and scene citation",
    "entry": "skills/retrieve-passage/SKILL.md"
  },
  {
    "id": "compare-passages",
    "when": "Tracing language, imagery, character, or theme across two or more passages",
    "outcome": "A passage-grounded comparison that distinguishes quotation from interpretation",
    "entry": "skills/compare-passages/SKILL.md"
  },
  {
    "id": "close-read-scene",
    "when": "Developing a defensible close reading of a scene or speech",
    "outcome": "An interpretation supported by textual features and explicit counterevidence",
    "entry": "skills/close-read-scene/SKILL.md"
  }
]
```

A compact full-text index can return scene pointers; fetch then loads only selected scenes. The
primary text, editorial notes, and interpretive procedure can remain distinguishable resources
without forcing them into separate books.

## EPA 608 / HVAC Test Prep

The [EPA 608 repository](https://github.com/skillbooks-ai/skillbook-epa-608) combines public-domain
rules with instructional expertise. Its capabilities can share a verified technical corpus:

```json
"capabilities": [
  {
    "id": "explain-refrigerant-concept",
    "when": "A learner needs an exam-relevant concept explained from their current understanding",
    "outcome": "A technically accurate explanation with the governing rule and a worked example",
    "entry": "skills/explain-concept/SKILL.md"
  },
  {
    "id": "diagnose-misconception",
    "when": "A learner gives a wrong answer or conflicting reasoning",
    "outcome": "The specific misconception, corrective model, and a discriminating check question",
    "entry": "skills/diagnose-misconception/SKILL.md"
  },
  {
    "id": "assess-exam-readiness",
    "when": "A learner wants targeted practice or a readiness decision for an EPA 608 exam section",
    "outcome": "A blueprint-balanced assessment, scored weaknesses, and prioritized study plan",
    "entry": "skills/assess-readiness/SKILL.md"
  }
]
```

This is more valuable than generic question generation: the entry defines item-quality and
diagnostic rules, while fetched resources supply current thresholds, procedures, and citations.

## THRV Jobs-to-be-Done

The THRV prototype packages a proprietary methodology as several independently activatable but
composable outcomes:

```json
"capabilities": [
  {
    "id": "frame-market",
    "when": "Defining the customer, job, and market boundary before product strategy work",
    "outcome": "A precise market frame with job executor, functional job, and scope assumptions",
    "entry": "skills/frame-market/SKILL.md"
  },
  {
    "id": "formulate-needs",
    "when": "Turning interviews, requests, or observations into customer need statements",
    "outcome": "A deduplicated set of measurable, solution-independent desired outcomes linked to evidence",
    "entry": "skills/formulate-needs/SKILL.md"
  },
  {
    "id": "prioritize-opportunities",
    "when": "Choosing where to innovate from customer importance and satisfaction evidence",
    "outcome": "A traceable opportunity ranking with uncertainty and research gaps made explicit",
    "entry": "skills/prioritize-opportunities/SKILL.md"
  }
]
```

The installed package can contain only these small entries, resolver programs, and a contentless
pointer index. Licensed methodology modules can remain local in an author edition or resolve from
a hosted subscriber account. Evaluation compares web, no-web, and no-web-plus-capability runs and
keeps held-out transfer cases separate from the iteration set.

## This Repository

This specification repository is itself a single-capability Skillbook. Its root `SKILL.md` is the
entry for `author-skillbooks`; its normal table of contents supplies the small resource set, so it
does not need a separate search index.

---

[🏠 Home](../SKILL.md)
