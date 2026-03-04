#!/usr/bin/env python3
"""Format repo grind — feeds tasks to MiniMax sequentially."""

import json
import os
import sys
import time
import urllib.request
import urllib.error

API = "http://192.168.0.7:1234/v1/chat/completions"
MODEL = "minimax/minimax-m2.5"
BASE = "/Users/bodhi/.openclaw/workspace/skillbooks/format-repo"
FORMAT_PATH = "/Users/bodhi/.openclaw/workspace/skillbooks/FORMAT.md"

with open(FORMAT_PATH) as f:
    FORMAT = f.read()

def extract_section(start_header, end_header=None):
    """Extract a section from FORMAT.md between headers."""
    lines = FORMAT.split('\n')
    collecting = False
    result = []
    for line in lines:
        if line.startswith(start_header):
            collecting = True
        elif end_header and line.startswith(end_header):
            break
        if collecting:
            result.append(line)
    return '\n'.join(result)

def call_mm(prompt, max_tokens=4096, retries=2):
    """Call MiniMax via LM Studio API."""
    payload = json.dumps({
        "model": MODEL,
        "messages": [{"role": "user", "content": prompt}],
        "max_tokens": max_tokens,
        "temperature": 0.3
    }).encode()
    
    for attempt in range(retries + 1):
        try:
            req = urllib.request.Request(API, data=payload, headers={"Content-Type": "application/json"})
            with urllib.request.urlopen(req, timeout=180) as resp:
                data = json.loads(resp.read())
                content = data["choices"][0]["message"]["content"]
                return content
        except Exception as e:
            if attempt < retries:
                print(f"  ⚠️  Retry {attempt+1}: {e}")
                time.sleep(5)
            else:
                print(f"  ❌ Failed after {retries+1} attempts: {e}")
                return None

def write_file(path, content):
    """Write content to file, creating directories."""
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, 'w') as f:
        f.write(content)
    lines = content.count('\n') + 1
    print(f"  ✅ Wrote: {os.path.relpath(path, BASE)} ({lines} lines)")

def split_and_write(content, base_dir):
    """Split multi-file output on '--- FILE:' markers and write each."""
    current_file = None
    current_lines = []
    files_written = 0
    
    for line in content.split('\n'):
        if line.strip().startswith('--- FILE:'):
            # Write previous file
            if current_file and current_lines:
                path = os.path.join(base_dir, current_file)
                write_file(path, '\n'.join(current_lines).strip() + '\n')
                files_written += 1
            # Parse new filename
            fname = line.strip()
            fname = fname.replace('--- FILE:', '').strip()
            fname = fname.rstrip(' -').strip()
            if fname.endswith('---'):
                fname = fname[:-3].strip()
            current_file = fname
            current_lines = []
        elif current_file is not None:
            current_lines.append(line)
    
    # Write last file
    if current_file and current_lines:
        path = os.path.join(base_dir, current_file)
        write_file(path, '\n'.join(current_lines).strip() + '\n')
        files_written += 1
    
    return files_written

print("=== Format Repo Build — MM Grind ===")
print(f"Started: {time.strftime('%Y-%m-%d %H:%M:%S')}")
print()

tasks_done = 0
tasks_failed = 0

# ─── TASK 1: README.md ───
print("📝 Task 1/14: README.md")
result = call_mm("""You are writing the README.md for an open-source specification repository called 'skillbook-format'. 

CONTEXT:
Skillbooks are an extension of the Agent Skills open standard (agentskills.io) — adopted by 30+ tools including Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, Windsurf. Agent Skills are like cheat sheets for AI agents. Skillbooks extend this into full textbook-depth content with structured multi-page knowledge, per-page micropayment pricing, and commercial publishing capabilities.

Every skillbook's SKILL.md is a valid Agent Skills file. Any tool that understands Agent Skills can discover and read a skillbook's entry point. Skillbooks add: structured multi-page content with sections and TOC, per-page pricing and credit-based access, book.json for catalog metadata, TAG-INDEX.json for tag-based lookup, verification pipeline and source attribution.

The spec repo is at github.com/skillbooks-ai/format. It contains the specification docs, examples, and tooling references.

INSTRUCTIONS:
Write a professional open-source README.md for this spec repo. Include:
- A brief tagline/description
- Badges placeholder (build, version, license)
- What Skillbooks are (2-3 sentences)
- How they relate to Agent Skills (the extension concept)
- Key features list
- Quick example showing a minimal directory structure
- Links to: full spec (spec/ directory), examples (examples/ directory), Agent Skills (agentskills.io)
- License: Apache 2.0 (spec code) + CC-BY-4.0 (documentation)

Tone: professional open-source project, not marketing. ~80-120 lines.
Output ONLY the markdown file content, no wrapper.""", 4096)
if result:
    write_file(f"{BASE}/README.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 2: spec/01-structure.md ───
print("📝 Task 2/14: spec/01-structure.md")
ctx = extract_section("## Directory Structure", "## SKILL.md")
result = call_mm(f"""You are writing a specification document for the Skillbook Format spec.

CONTEXT — this is the authoritative reference for this section:
{ctx}

INSTRUCTIONS:
Write spec/01-structure.md — the directory structure specification. Include:
- Title: '# Directory Structure'
- Agent Skills compatibility note at top (skillbooks extend Agent Skills directory conventions)
- The full directory tree diagram from the context
- Naming conventions section (folder naming, file naming, kebab-case rules)
- 'What Belongs Where' as a bullet list (not a table)
- Book namespace rules (skillbooks.ai/<name>/)

Use precise, imperative language (RFC 2119 style: MUST, SHOULD, MAY).
~60-80 lines. Output ONLY the markdown content.""", 4096)
if result:
    write_file(f"{BASE}/spec/01-structure.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 3: spec/02-skill-md.md ───
print("📝 Task 3/14: spec/02-skill-md.md")
ctx = extract_section("## SKILL.md — The Agent Entry Point", "## README.md")
result = call_mm(f"""You are writing a specification document for the Skillbook Format spec.

CONTEXT — this is the authoritative reference for this section:
{ctx}

INSTRUCTIONS:
Write spec/02-skill-md.md — the SKILL.md specification. Include:
- Title: '# SKILL.md Specification'
- Opening: SKILL.md is the agent entry point, always served free (the storefront)
- Frontmatter section: strict superset of Agent Skills. Show the full YAML example. List all fields in both 'Agent Skills Standard Fields' and 'Skillbooks Extension Fields' (use bullet lists, not tables)
- Navigation Instructions section
- Table of Contents section (format rules, TOC example)
- License section (requirements, examples)
- Quick Start Paths section

Use precise, imperative language (RFC 2119 style). ~100-120 lines. Output ONLY the markdown content.""", 4096)
if result:
    write_file(f"{BASE}/spec/02-skill-md.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 4: spec/03-content-pages.md ───
print("📝 Task 4/14: spec/03-content-pages.md")
ctx1 = extract_section("## Section Overview", "## Content Pages")
ctx2 = extract_section("## Content Pages", "## book.json")
result = call_mm(f"""You are writing a specification document for the Skillbook Format spec.

CONTEXT — Section Overviews:
{ctx1}

CONTEXT — Content Pages:
{ctx2}

INSTRUCTIONS:
Write spec/03-content-pages.md — the content pages specification. Include:
- Title: '# Content Pages'
- Section Overview (00-overview.md) rules: what goes in them, target length 20-40 lines, example
- Content page rules: 40-100 lines, one concept, self-contained
- Cross-references: relative paths
- Tags: optional frontmatter, format rules, lowercase hyphen-separated
- TAG-INDEX.json: format, served free, O(1) lookup
- What makes a good page
- What to avoid

Use precise, imperative language (RFC 2119 style). ~80-100 lines. Output ONLY the markdown content.""", 4096)
if result:
    write_file(f"{BASE}/spec/03-content-pages.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 5: spec/04-metadata-publishing.md ───
print("📝 Task 5/14: spec/04-metadata-publishing.md")
ctx = extract_section("## book.json", "## Quick Checklist")
result = call_mm(f"""You are writing a specification document for the Skillbook Format spec.

CONTEXT — this is the authoritative reference:
{ctx}

INSTRUCTIONS:
Write spec/04-metadata-publishing.md — metadata and publishing specification. Include:
- Title: '# Metadata & Publishing'
- book.json section: full JSON example, field descriptions as bullet list
- Versioning: semver rules, what each bump means for billing
- Pricing: author sets full price, per-page derived. Tiers. Revenue split 80/20
- Publishing workflow: login, validate, publish, stats commands
- Validation checks list

Use precise, imperative language (RFC 2119 style). ~80-100 lines. Output ONLY the markdown content.""", 4096)
if result:
    write_file(f"{BASE}/spec/04-metadata-publishing.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 6: examples/README.md ───
print("📝 Task 6/14: examples/README.md")
result = call_mm("""Write a short README.md for the examples/ directory in the Skillbook Format spec repository.

This directory contains three example skillbooks that demonstrate the format:
1. minimal/ — The bare minimum valid skillbook (1 section, 2 pages). Shows the smallest possible structure that passes validation.
2. standard/ — A typical skillbook with 2 sections and multiple pages. Demonstrates full SKILL.md with TOC, navigation, license, and cross-references.
3. tagged/ — Like standard, but adds tags to pages and includes TAG-INDEX.json for tag-based lookup.

Each example is a complete, valid skillbook structure that passes 'skillbook validate'.

Write ~30-40 lines. Professional tone. Output ONLY the markdown content.""", 2048)
if result:
    write_file(f"{BASE}/examples/README.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 7: Minimal example ───
print("📝 Task 7/14: Minimal example skillbook")
result = call_mm("""Create a minimal example skillbook — the smallest valid skillbook structure. Topic: 'Quick Reference Guide' (generic).

Files to generate (output ALL files, separated by '--- FILE: <path> ---' markers):

1. SKILL.md — Agent Skills frontmatter (name: minimal-example, description, license: CC-BY-4.0, metadata with skillbooks-* fields: title, server: https://skillbooks.ai, version: 1.0.0, pages: 2, price: $2.00). Navigation instructions. Short TOC with 2 entries. License section.

2. README.md — Brief human-facing overview (~15 lines)

3. book.json — Required fields: id, title, description, version, author, language: en, verified: false, structure.readme

4. 01-basics/00-overview.md — Section overview: what this section covers, file index listing 01-hello.md (~20 lines)

5. 01-basics/01-hello.md — A simple content page about getting started (~40 lines)

Each file should be 15-40 lines. Use this exact separator format between files:
--- FILE: <relative-path> ---

Output ONLY the file contents with separators.""", 4096)
if result:
    n = split_and_write(result, f"{BASE}/examples/minimal")
    if n > 0:
        tasks_done += 1
    else:
        print("  ⚠️  No files parsed from output, writing raw")
        write_file(f"{BASE}/examples/minimal/_raw_output.md", result)
        tasks_failed += 1
else:
    tasks_failed += 1

# ─── TASK 8: Standard example ───
print("📝 Task 8/14: Standard example skillbook")
result = call_mm("""Create a standard example skillbook. Topic: 'API Design Patterns' (relatable to developers). 2 sections, ~8 pages total.

Files to generate (output ALL files, separated by '--- FILE: <path> ---' markers):

1. SKILL.md — Full Agent Skills frontmatter (name: api-design-patterns, description about REST/GraphQL API design, license: all-rights-reserved, compatibility: Requires HTTP access to skillbooks.ai, metadata with skillbooks-* fields: title: API Design Patterns, server: https://skillbooks.ai, version: 1.0.0, pages: 8, price: $8.00). Navigation instructions explaining URL construction and auth. Full TOC with all 8 pages across 2 sections. License section. Quick start paths.

2. README.md — Human-facing product page (~40 lines)

3. book.json — All required fields, author: Example Author, language: en

4. 01-fundamentals/00-overview.md — Section overview + file index
5. 01-fundamentals/01-rest-principles.md — REST fundamentals
6. 01-fundamentals/02-resource-design.md — Resource naming and structure  
7. 01-fundamentals/03-error-handling.md — Error response patterns

8. 02-patterns/00-overview.md — Section overview + file index
9. 02-patterns/01-pagination.md — Pagination patterns
10. 02-patterns/02-versioning.md — API versioning strategies
11. 02-patterns/03-rate-limiting.md — Rate limiting design

Each content page: 40-60 lines with cross-references to related pages using relative paths.
Use this exact separator: --- FILE: <relative-path> ---
Output ONLY file contents with separators.""", 8192)
if result:
    n = split_and_write(result, f"{BASE}/examples/standard")
    if n > 0:
        tasks_done += 1
    else:
        write_file(f"{BASE}/examples/standard/_raw_output.md", result)
        tasks_failed += 1
else:
    tasks_failed += 1

# ─── TASK 9: Tagged example ───
print("📝 Task 9/14: Tagged example skillbook")
result = call_mm("""Create a tagged example skillbook. Topic: 'Cloud Infrastructure'. 2 sections, adds tags to demonstrate TAG-INDEX.json.

Files to generate (output ALL files, separated by '--- FILE: <path> ---' markers):

1. SKILL.md — Agent Skills frontmatter (name: cloud-infrastructure, license: all-rights-reserved, metadata with skillbooks-* fields including skillbooks-tags: 'true', pages: 6, price: $10.00). Navigation instructions mentioning TAG-INDEX.json availability. TOC. License. Quick start paths.

2. README.md — Human-facing overview (~30 lines)

3. book.json — All fields, structure.tagIndex: TAG-INDEX.json

4. TAG-INDEX.json — Maps tags to pages. Tags: networking, compute, storage, security, scaling, containers. Each tag maps to 2-3 pages.

5. 01-concepts/00-overview.md — tags: [cloud, fundamentals]
6. 01-concepts/01-networking.md — tags: [networking, vpc, security]
7. 01-concepts/02-compute.md — tags: [compute, containers, scaling]

8. 02-infrastructure/00-overview.md — tags: [infrastructure, deployment]
9. 02-infrastructure/01-storage.md — tags: [storage, databases, scaling]
10. 02-infrastructure/02-security.md — tags: [security, networking, compliance]

Each content page: 40-60 lines. Tags in YAML frontmatter at top of each .md file.
Use this exact separator: --- FILE: <relative-path> ---
Output ONLY file contents with separators.""", 8192)
if result:
    n = split_and_write(result, f"{BASE}/examples/tagged")
    if n > 0:
        tasks_done += 1
    else:
        write_file(f"{BASE}/examples/tagged/_raw_output.md", result)
        tasks_failed += 1
else:
    tasks_failed += 1

# ─── TASK 10: CONTRIBUTING.md ───
print("📝 Task 10/14: CONTRIBUTING.md")
result = call_mm("""Write CONTRIBUTING.md for the Skillbook Format specification repository (github.com/skillbooks-ai/format).

This is an open-source spec — not a code project. Include:
- How to propose spec changes: open a GitHub issue describing the change → discuss → if accepted, submit an RFC-style PR
- How to submit example skillbooks to examples/
- Style guide: precise imperative language, RFC 2119 keywords (MUST, SHOULD, MAY), no marketing language
- PR review process: at least one maintainer review required
- Code of conduct: reference Contributor Covenant (link to CODE_OF_CONDUCT.md)
- How to report bugs in the spec (ambiguities, contradictions)

~50-70 lines. Professional open-source tone. Output ONLY the markdown content.""", 4096)
if result:
    write_file(f"{BASE}/CONTRIBUTING.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 11: Agent Skills compatibility guide ───
print("📝 Task 11/14: docs/agent-skills-compatibility.md")
result = call_mm("""Write docs/agent-skills-compatibility.md — a guide explaining how Skillbook Format relates to and extends Agent Skills.

KEY FACTS:
- Agent Skills (agentskills.io) is the open standard adopted by 30+ tools: Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, Windsurf, etc.
- Agent Skills provides: name, description, license, compatibility frontmatter + standard directory conventions (SKILL.md, scripts/, references/, assets/)
- Skillbooks are a STRICT SUPERSET — every skillbook SKILL.md is a valid Agent Skills file
- Skillbook-specific fields are namespaced under metadata with 'skillbooks-' prefix
- Any Agent Skills consumer can read a skillbook's SKILL.md without modification

Include:
- Title: 'Agent Skills Compatibility'
- Overview of the relationship
- Which fields are standard Agent Skills vs skillbook extensions (bullet list)
- How discovery works
- Migration guide: how to convert an existing Agent Skill into a Skillbook
- What happens when a non-skillbook-aware tool encounters a skillbook

~60-80 lines. Output ONLY the markdown content.""", 4096)
if result:
    write_file(f"{BASE}/docs/agent-skills-compatibility.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 12: FAQ ───
print("📝 Task 12/14: docs/faq.md")
result = call_mm("""Write docs/faq.md — Frequently Asked Questions about the Skillbook Format.

Answer these questions concisely (3-5 sentences each):

1. What's the difference between an Agent Skill and a Skillbook?
   Agent Skills are cheat sheets — short, focused instructions. Skillbooks are textbooks — deep, structured, multi-page knowledge. A skillbook's SKILL.md IS a valid Agent Skill.

2. Do I need to use skillbooks.ai to publish?
   The format is open — anyone can host skillbooks. skillbooks.ai is the official marketplace with built-in payments, discovery, and validation.

3. How is pricing calculated?
   Authors set a full book price. Per-page price = full_price / total_pages. Revenue split: 80% author, 20% platform.

4. Can I use this for free/open content?
   Yes. Set price to $0.00 or use an open license. The format works the same.

5. What agents support this?
   Any agent that supports Agent Skills can discover skillbooks (30+ tools). For paid content, the agent needs HTTP fetching with API key auth.

6. How does versioning affect billing?
   Patch: no charges. Minor: new pages cost, existing stay free. Major: treated as new book.

7. What's TAG-INDEX.json?
   Optional file mapping tags to pages for O(1) lookup. Served free alongside SKILL.md.

~60-80 lines. Output ONLY the markdown content.""", 4096)
if result:
    write_file(f"{BASE}/docs/faq.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── TASK 13: LICENSE files (no MM needed) ───
print("📝 Task 13/14: LICENSE files")
# These are boilerplate — writing directly
write_file(f"{BASE}/LICENSE-APACHE", """                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   Copyright 2026 Skillbooks Contributors

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

   TERMS AND CONDITIONS: See http://www.apache.org/licenses/LICENSE-2.0
""")

write_file(f"{BASE}/LICENSE-CC-BY", """Creative Commons Attribution 4.0 International (CC BY 4.0)

This license applies to the specification documentation in this repository.

You are free to:
  Share — copy and redistribute the material in any medium or format
  Adapt — remix, transform, and build upon the material for any purpose,
          even commercially

Under the following terms:
  Attribution — You must give appropriate credit, provide a link to the
                license, and indicate if changes were made.

Full license text: https://creativecommons.org/licenses/by/4.0/legalcode

Copyright 2026 Skillbooks Contributors
""")
tasks_done += 1

# ─── TASK 14: CHANGELOG.md ───
print("📝 Task 14/14: CHANGELOG.md")
result = call_mm("""Write CHANGELOG.md for the Skillbook Format specification repository. Use Keep a Changelog format.

Include one release:

## [1.0.0] — 2026-03-10

### Added
- Agent Skills compatibility — every SKILL.md is a valid Agent Skills file
- Frontmatter uses Agent Skills standard fields with skillbooks-* extensions under metadata
- Directory structure specification
- SKILL.md specification (frontmatter, navigation, TOC, license, quick start)
- Content pages specification (40-100 lines, one concept, cross-references)
- Tags and TAG-INDEX.json
- book.json metadata schema
- Semver versioning with billing implications
- Pricing model (80/20 revenue split)
- Publishing workflow
- Three example skillbooks

### Changed (from pre-1.0)
- Removed SUMMARY.md
- Replaced folder README.md with 00-overview.md
- Revenue split 90/10 → 80/20
- Removed structure.summary from book.json

~30-40 lines. Output ONLY the markdown content.""", 2048)
if result:
    write_file(f"{BASE}/CHANGELOG.md", result.strip() + '\n')
    tasks_done += 1
else:
    tasks_failed += 1

# ─── Summary ───
print()
print(f"=== Done! {tasks_done}/14 succeeded, {tasks_failed} failed ===")
print(f"Finished: {time.strftime('%Y-%m-%d %H:%M:%S')}")
print()

# List all generated files
for root, dirs, files in sorted(os.walk(BASE)):
    dirs.sort()
    for f in sorted(files):
        if f in ('grind.sh', 'grind.py', 'TASK-LIST.md'):
            continue
        path = os.path.join(root, f)
        rel = os.path.relpath(path, BASE)
        lines = sum(1 for _ in open(path))
        print(f"  {rel} ({lines} lines)")
