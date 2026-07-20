# Evaluating Capabilities

Capability claims SHOULD be supported by repeatable evaluations. The goal is better end-user
outcomes across realistic tasks, not a prompt optimized for a small test set.

## Minimum Comparison

The upstream Agent Skills guidance recommends comparing the same task with and without the
skill. For knowledge-heavy commercial Skillbooks, authors SHOULD use three isolated conditions:

1. **Web** — the model may research authoritative methodology sources; no Skillbook is supplied.
2. **No web** — no web and no Skillbook.
3. **No web + Skillbook** — no web; only the selected capability entry is supplied.

This separates the value of the author's packaged expertise from both model priors and open-web
research. Use the same model, user request, output constraints, and tool policy except for the
condition under test.

## Protect Evaluation Integrity

- Freeze capability entry points before running the scored suite and record their digests.
- Keep regression cases separate from fresh transfer cases written after the freeze.
- Do not revise a frozen capability after seeing transfer results; record failures for the next
  version and test that version against new cases.
- Use realistic prompts from more than one domain, phrasing style, and difficulty level.
- Keep evaluator rubrics outside the capability and generation prompt.

These controls reduce test leakage and test-specific instruction patches. They do not eliminate
model variance, judge bias, or case-selection bias.

## Scoring and Evidence

Use objective assertions where possible and a weighted rubric for qualities that require
judgment. When using an LLM judge, shuffle condition labels and score every response independently.
A response may be best and still receive a poor absolute score.

Record:

- exact requested and resolved models, including auxiliary models
- prompts, condition policies, capability digests, and case-file digests
- raw outputs and blinded label mappings
- assertion or rubric scores with concrete failure reasons
- input, output, and cache tokens; tool calls; cost; duration

Public `eval/EVAL.md` and `eval/eval-report.json` SHOULD summarize results and limitations.
Raw responses MAY remain package-local when licensing, privacy, or size prevents publishing them.

## Claims

Report regression and transfer results separately. Distinguish observations from stable product
claims, especially for latency, cost, and small suites. State remaining failures and material
confounds. A useful Skillbook should show what capability quality it buys and what token, time,
or retrieval cost it adds.

See the official Agent Skills guidance on
[evaluating skill output quality](https://agentskills.io/skill-creation/evaluating-skills).

---

[← Previous: Publishing](02-publishing.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
