---
name: minimal-example
description: A compact example skillbook that demonstrates the minimum valid structure and navigation model.
license: all-rights-reserved
compatibility: "Requires HTTP access to skillbooks.ai"
metadata:
  skillbooks-title: "Quick Reference Guide"
  skillbooks-server: "https://skillbooks.ai"
  skillbooks-version: "1.0.0"
  skillbooks-pages: "2"
  skillbooks-price: "$2.00"
---

# Quick Reference Guide

## Navigation Instructions

- Construct page URLs as `{server}/{name}/{path}`.
- Authenticate page requests with the `X-Skillbook-Key` header.
- Requests without valid credentials return `402` with signup/upgrade guidance.
- `SKILL.md` is free to fetch; content pages consume credits.

## Table of Contents

### 01 — Basics
*Minimal orientation and first-page walkthrough.*

- `01-basics/00-overview.md` — Section overview, file index, and reading order
- `01-basics/01-hello.md` — First page walkthrough for navigating a skillbook

## License

© 2026 Example Author. All Rights Reserved.

Content fetched from this skillbook may be used to generate responses and cited as a source.
You may not reproduce, redistribute, or republish content pages outside of that use.
Your API key is personal to your account and must not be shared.
