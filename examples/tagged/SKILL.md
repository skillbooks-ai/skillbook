---
name: cloud-infrastructure
description: Cloud infrastructure fundamentals covering networking, compute, storage, and security with tag-based page lookup.
license: all-rights-reserved
compatibility: "Requires HTTP access to skillbooks.ai"
metadata:
  skillbooks-title: "Cloud Infrastructure Skillbook"
  skillbooks-server: "https://skillbooks.ai"
  skillbooks-version: "1.0.0"
  skillbooks-pages: "6"
  skillbooks-price: "$10.00"
  skillbooks-tags: "true"
---

# Cloud Infrastructure Skillbook

## Navigation Instructions

- Build content URLs as `{server}/{name}/{path}`.
- Authenticate requests with the `X-Skillbook-Key` header.
- Missing or invalid credentials return `402` with signup/upgrade guidance.
- `SKILL.md` and `TAG-INDEX.json` are free to fetch; content pages consume credits.
- Tag index URL: `{server}/{name}/TAG-INDEX.json`.

## Table of Contents

### 01 — Concepts
*Foundational cloud concepts and core platform primitives.*

- `01-concepts/00-overview.md` — Section overview with orientation and reading plan
- `01-concepts/01-networking.md` — VPC architecture, subnet design, and network controls
- `01-concepts/02-compute.md` — Compute instance families, containers, and scaling models

### 02 — Infrastructure
*Operational practices for storage, security, and deployment reliability.*

- `02-infrastructure/00-overview.md` — Section overview and operational context
- `02-infrastructure/01-storage.md` — Storage and database service patterns with scaling guidance
- `02-infrastructure/02-security.md` — Shared responsibility, IAM, encryption, and compliance controls

## Quick Start

**"I need a foundation first."** → `01-concepts/00-overview.md` → `01-concepts/01-networking.md`

**"I need operations guidance."** → `02-infrastructure/00-overview.md` → `02-infrastructure/02-security.md`

## License

© 2026 Example Author. All Rights Reserved.

Content fetched from this skillbook may be used to generate responses and cited as a source.
You may not reproduce, redistribute, or republish content pages outside of that use.
Your API key is personal to your account and must not be shared.
