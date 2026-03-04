# Contributing to the Skillbook Format Specification

## Overview

This repository contains the formal specification for the Skillbook Format. Contributions include spec clarifications, new examples, and corrections to ambiguities.

## Proposing Spec Changes

1. **Open an Issue**: Describe the proposed change in a GitHub issue. Include:
   - The section or concept affected
   - The problem the change addresses
   - A suggested resolution

2. **Discussion**: Maintainers and community members will discuss the proposal. Be prepared to clarify intent and provide rationale.

3. **Submit an RFC PR**: If the change is accepted, draft a Pull Request using the [RFC template](link). Your PR MUST:
   - Reference the related issue
   - Include a diff of the specification changes
   - Provide rationale for the change

## Submitting Examples

Place example skillbooks in the `examples/` directory. Each example MUST:
- Validate against the current specification
- Include a `README.md` explaining its purpose
- Follow the naming convention: `{category}-{name}.skillbook`

## Style Guide

All specification language MUST follow RFC 2119 keywords:
- **MUST** / **MUST NOT**: Absolute requirements
- **SHOULD** / **SHOULD NOT**: Recommended behavior, with valid exceptions
- **MAY**: Optional behavior

Write in precise imperative language. Avoid marketing terms, vague descriptors, and ambiguous phrasing.

## PR Review Process

All Pull Requests require at least one maintainer review before merging. Reviewers will evaluate:
- Technical accuracy and clarity
- Consistency with existing specification style
- Proper use of RFC 2119 keywords

## Reporting Spec Bugs

If you find ambiguities, contradictions, or errors in the specification, open a GitHub issue labeled `bug`. Include:
- The exact text causing confusion
- The section and line number
- A suggested correction (if applicable)

## Code of Conduct

This project adheres to the [Contributor Covenant](https://www.contributor-covenant.org/version/2/0/code_of_conduct.html). By participating, you MUST uphold its standards.
