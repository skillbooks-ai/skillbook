# Skillbook Format Examples

This directory contains example skillbooks that demonstrate the Skillbook Format specification. Each subdirectory is a complete, valid skillbook that passes validation with `skillbook validate`.

## Examples Overview

### minimal/

The bare minimum valid skillbook. Contains 1 section with 2 pages, demonstrating the smallest possible structure that passes validation. Use this as a reference for understanding the required core fields and basic file layout.

### standard/

A typical skillbook with 2 sections and multiple pages per section. Demonstrates a complete `SKILL.md` file including:
- Table of contents
- Section navigation
- License information
- Cross-references between pages

This is the recommended starting point for creating new skillbooks.

### tagged/

Extends the standard example by adding metadata tags to pages and including a `TAG-INDEX.json` file. Demonstrates how to implement tag-based lookup for filtering and searching content across the skillbook.

## Usage

To validate any example:

```bash
skillbook validate examples/minimal/
skillbook validate examples/standard/
skillbook validate examples/tagged/
```

All three examples should pass validation without errors.
