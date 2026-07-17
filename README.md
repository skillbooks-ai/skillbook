# Spec: Skillbooks for Agents

[![License](https://img.shields.io/badge/license-CC--BY--4.0-blue.svg)](LICENSE)
[![Spec Version](https://img.shields.io/badge/spec-v2.0-green.svg)](SKILL.md)
[![Agent Skills](https://img.shields.io/badge/Agent%20Skills-compatible-orange.svg)](https://agentskills.io)

> The Skillbook Format — a specification for granting AI agents vast knowledge and action skills

Skillbooks extend the [Agent Skills](https://agentskills.io) open standard with expert-authored capabilities, progressively disclosed resources, evaluation evidence, and optional hosted delivery. Each capability has an explicit activation condition, promised outcome, and Agent Skills-compatible entry point.

**This repository is itself a skillbook.** The format you're reading about is the format it's written in.

## What's a Skillbook?

A skillbook is a portable capability pack for AI agents. It packages the procedures, authoritative knowledge, criteria, examples, and templates needed to produce a meaningful outcome—not merely answer questions about a topic. Agents activate one small capability entry, then retrieve only the supporting resources the task requires.

The format works anywhere: locally with your own tools, self-hosted, or published to a platform like [skillbooks.ai](https://skillbooks.ai) that adds paid access, continuous updates, and commercial distribution. This specification defines the structure — how you serve it is up to you.

## Key Features

- **Agent Skills compatible** — every SKILL.md works with existing Agent Skills tooling
- **Outcome-based capabilities** — the unit of discovery, activation, and evaluation within a book
- **Progressive disclosure** — small entries route to exact pages or indexed resources on demand
- **Standard tooling** — `package.json`, familiar developer workflow
- **Portable resource delivery** — local, hosted, or thin licensed editions without a RAG deployment
- **Evaluation evidence** — comparable web, no-web, and Skillbook conditions with transfer cases
- **Verification pipeline** — source attribution and content integrity checks
- **Commerce-optional** — a display price and hosted entitlement can support authors without changing the portable runtime

## Quick Start

### Create Your Own Skillbook

```bash
npm i -g @skillbooks/cli
skillbook init
```

Then define the outcomes your expertise enables. See [Capabilities](01-foundations/04-capabilities.md), [Directory Structure](01-foundations/02-directory-structure.md), and [Resource Indexes & Delivery](03-content/04-resource-indexes-and-delivery.md).

### Explore the Marketplace

Browse published skillbooks at [skillbooks.ai](https://skillbooks.ai). Add one to your agent with a single API key — no integration work needed.

### Collaborate on the Spec

This specification is open. [Read the full spec](SKILL.md), open an [issue](https://github.com/skillbooks-ai/skillbook/issues), or join the [discussion](https://github.com/skillbooks-ai/skillbook/discussions).

## Example Skillbooks

| Book | Content | Repo |
|------|---------|------|
| EU AI Act | Regulatory text + compliance guidance | [skillbook-eu-ai-act](https://github.com/skillbooks-ai/skillbook-eu-ai-act) |
| EPA 608 | Certification exam prep | [skillbook-epa-608](https://github.com/skillbooks-ai/skillbook-epa-608) |
| Shakespeare | Complete works (725 scenes) | [skillbook-shakespeare-complete](https://github.com/skillbooks-ai/skillbook-shakespeare-complete) |


## License

Licensed under [CC-BY-4.0](LICENSE).
