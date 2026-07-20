# Capabilities

A Skillbook packages one or more **capabilities**: coherent outcomes an agent can reliably
produce with the author's expertise. Capabilities replace the v1 global `reference` / `guide`
type distinction.

## Why Capabilities, Not Book Types

Useful expert work rarely fits one purpose. A single outcome may require authoritative facts,
a procedure, decision criteria, examples, and an output template. Labeling the whole book as
either something to look up or something to follow hides the actual value from agents and
forces authors to split expertise that belongs together.

The capability is the unit that should be discovered, activated, and evaluated. The Skillbook is
the bundle that is installed, versioned, licensed, and optionally purchased. A capability states:

- **when** the capability applies
- **outcome** the user should receive
- **entry** the Agent Skills-compatible `SKILL.md` that teaches the agent how to produce it

There is no separate `purpose` enum. Purpose is expressed concretely by `when` and `outcome`.
A capability MAY use whatever mixture of procedures and source material is necessary.

## Requirements

Every Skillbook MUST declare at least one capability in `package.json` under
`skillbook.capabilities`. Capability IDs MUST be unique within the book.

```json
{
  "id": "formulate-needs",
  "when": "Turning customer evidence or feature requests into objective need statements",
  "outcome": "A measurable, solution-independent needs library linked to evidence",
  "entry": "skills/formulate-needs/SKILL.md",
  "evals": ["eval/cases.jsonl#formulate-needs"]
}
```

| Field | Required | Description |
|---|---|---|
| `id` | Yes | Stable kebab-case identifier, unique within the book. |
| `when` | Yes | Task conditions that should activate the capability. |
| `outcome` | Yes | Observable user result, not a subject label. |
| `entry` | Yes | Package-relative path to a valid `SKILL.md`. |
| `evals` | No | Package-relative evaluation case references for this capability. |

The root `SKILL.md` MUST contain a concise `## Capabilities` section that exposes the same IDs,
activation conditions, outcomes, and entry paths to agents. Tooling MUST verify that the root
section and `package.json` do not disagree.

The root `SKILL.md` MAY be the entry for one or more simple capabilities. When capabilities
need materially different instructions, each SHOULD have its own entry under
`skills/<capability>/SKILL.md`. For a single-capability request, clients SHOULD activate only
that entry instead of loading every procedure in the book.

## Composition

Capabilities compose within a book and across books:

- A Shakespeare book can retrieve an authoritative passage, compare scenes, and apply a
  close-reading procedure without pretending the entire book has one purpose.
- An HVAC test-prep book can explain a concept, diagnose a misconception, generate practice,
  and assess readiness from the same verified technical corpus.
- A JTBD book can frame a market, map a job, formulate needs, and prioritize strategy as
  independent capabilities or as an end-to-end sequence.

Authors SHOULD split capabilities at meaningful outcome boundaries, not at every small step.
Too few capabilities load irrelevant instructions; too many create activation overhead and
conflicting guidance.

---

[← Previous: Naming Conventions](03-naming-conventions.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
