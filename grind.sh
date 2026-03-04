#!/bin/bash
# Format repo grind — feeds tasks to MiniMax sequentially
# Each task: curl to LM Studio → extract content → write file(s)

set -euo pipefail

API="http://192.168.0.7:1234/v1/chat/completions"
MODEL="minimax/minimax-m2.5"
BASE="/Users/bodhi/.openclaw/workspace/skillbooks/format-repo"
FORMAT="/Users/bodhi/.openclaw/workspace/skillbooks/FORMAT.md"

call_mm() {
  local prompt="$1"
  local max_tokens="${2:-4096}"
  
  local response
  response=$(curl -s --connect-timeout 10 --max-time 120 "$API" \
    -H "Content-Type: application/json" \
    -d "$(jq -n \
      --arg model "$MODEL" \
      --arg prompt "$prompt" \
      --argjson max_tokens "$max_tokens" \
      '{model: $model, messages: [{role: "user", content: $prompt}], max_tokens: $max_tokens, temperature: 0.3}')")
  
  echo "$response" | jq -r '.choices[0].message.content // "ERROR: No content returned"'
}

write_file() {
  local path="$1"
  local content="$2"
  mkdir -p "$(dirname "$path")"
  echo "$content" > "$path"
  echo "  ✅ Wrote: $path ($(wc -l < "$path") lines)"
}

# Extract content between --- FILE: markers for multi-file tasks
split_files() {
  local content="$1"
  local base_dir="$2"
  
  # Use awk to split on --- FILE: path --- markers
  echo "$content" | awk -v base="$base_dir" '
    /^--- FILE:/ {
      if (outfile) close(outfile)
      fname = $0
      gsub(/^--- FILE: */, "", fname)
      gsub(/ *---$/, "", fname)
      outfile = base "/" fname
      # Create directory
      cmd = "mkdir -p \"" base "/" fname "\""
      gsub(/\/[^/]+$/, "", cmd)  
      system("mkdir -p \"$(dirname \"" outfile "\")\""  )
      next
    }
    outfile { print > outfile }
  '
}

echo "=== Format Repo Build — MM Grind ==="
echo "Started: $(date)"
echo ""

# ─── TASK 1: README.md ───
echo "📝 Task 1/14: README.md"
RESULT=$(call_mm "You are writing the README.md for an open-source specification repository called 'skillbook-format'. 

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
Output ONLY the markdown file content, no wrapper." 4096)
write_file "$BASE/README.md" "$RESULT"

# ─── TASK 2: spec/01-structure.md ───
echo "📝 Task 2/14: spec/01-structure.md"
CONTEXT2=$(sed -n '/^## Directory Structure/,/^## SKILL.md/p' "$FORMAT" | head -n -1)
RESULT=$(call_mm "You are writing a specification document for the Skillbook Format spec.

CONTEXT — this is the authoritative reference for this section:
$CONTEXT2

INSTRUCTIONS:
Write spec/01-structure.md — the directory structure specification. Include:
- Title: '# Directory Structure'
- Agent Skills compatibility note at top (skillbooks extend Agent Skills directory conventions)
- The full directory tree diagram from the context
- Naming conventions section (folder naming, file naming, kebab-case rules)
- 'What Belongs Where' reference table (as a list, not a table — this will be on GitHub)
- Book namespace rules (skillbooks.ai/<name>/)

Use precise, imperative language (RFC 2119 style: MUST, SHOULD, MAY).
~60-80 lines. Output ONLY the markdown content." 4096)
write_file "$BASE/spec/01-structure.md" "$RESULT"

# ─── TASK 3: spec/02-skill-md.md ───
echo "📝 Task 3/14: spec/02-skill-md.md"
CONTEXT3=$(sed -n '/^## SKILL.md — The Agent Entry Point/,/^## README.md/p' "$FORMAT" | head -n -1)
RESULT=$(call_mm "You are writing a specification document for the Skillbook Format spec.

CONTEXT — this is the authoritative reference for this section:
$CONTEXT3

INSTRUCTIONS:
Write spec/02-skill-md.md — the SKILL.md specification. Include:
- Title: '# SKILL.md Specification'
- Opening: SKILL.md is the agent entry point, always served free (the storefront)
- Frontmatter section: strict superset of Agent Skills. Show the full YAML example. List all fields in both 'Agent Skills Standard Fields' and 'Skillbooks Extension Fields' (use bullet lists, not tables)
- Navigation Instructions section (what to tell the agent)
- Table of Contents section (format rules, TOC example)
- License section (requirements, examples)
- Quick Start Paths section (optional but recommended)
- Migration note from v0 frontmatter

Use precise, imperative language (RFC 2119 style). ~100-120 lines. Output ONLY the markdown content." 4096)
write_file "$BASE/spec/02-skill-md.md" "$RESULT"

# ─── TASK 4: spec/03-content-pages.md ───
echo "📝 Task 4/14: spec/03-content-pages.md"
CONTEXT4=$(sed -n '/^## Section Overview/,/^## book.json/p' "$FORMAT" | head -n -1)
RESULT=$(call_mm "You are writing a specification document for the Skillbook Format spec.

CONTEXT — this is the authoritative reference:
$(sed -n '/^## Content Pages/,/^## book.json/p' "$FORMAT" | head -n -1)

Also include 00-overview.md rules:
$(sed -n '/^## Section Overview/,/^## Content Pages/p' "$FORMAT" | head -n -1)

INSTRUCTIONS:
Write spec/03-content-pages.md — the content pages specification. Include:
- Title: '# Content Pages'
- Section Overview (00-overview.md) rules: what goes in them, target length, example
- Content page rules: 40-100 lines, one concept, self-contained
- Cross-references: relative paths
- Tags: optional frontmatter, format rules
- TAG-INDEX.json: format, how it works, served free
- What makes a good page (guidelines)
- What to avoid (anti-patterns)

Use precise, imperative language (RFC 2119 style). ~80-100 lines. Output ONLY the markdown content." 4096)
write_file "$BASE/spec/03-content-pages.md" "$RESULT"

# ─── TASK 5: spec/04-metadata-publishing.md ───
echo "📝 Task 5/14: spec/04-metadata-publishing.md"
CONTEXT5=$(sed -n '/^## book.json/,/^## Quick Checklist/p' "$FORMAT" | head -n -1)
RESULT=$(call_mm "You are writing a specification document for the Skillbook Format spec.

CONTEXT — this is the authoritative reference:
$CONTEXT5

INSTRUCTIONS:
Write spec/04-metadata-publishing.md — metadata and publishing specification. Include:
- Title: '# Metadata & Publishing'
- book.json section: full JSON example, field descriptions as bullet list
- Versioning: semver rules, what each bump means for billing (patch=free, minor=new pages cost, major=full reset)
- Pricing: author sets full price, per-page derived. Tier examples. Revenue split 80/20 (platform absorbs Stripe fees)
- Publishing workflow: login, validate, publish, stats commands
- Validation checks list

Use precise, imperative language (RFC 2119 style). ~80-100 lines. Output ONLY the markdown content." 4096)
write_file "$BASE/spec/04-metadata-publishing.md" "$RESULT"

# ─── TASK 6: examples/README.md ───
echo "📝 Task 6/14: examples/README.md"
RESULT=$(call_mm "Write a short README.md for the examples/ directory in the Skillbook Format spec repository.

This directory contains three example skillbooks that demonstrate the format:
1. minimal/ — The bare minimum valid skillbook (1 section, 2 pages). Shows the smallest possible structure that passes validation.
2. standard/ — A typical skillbook with 2 sections and multiple pages. Demonstrates full SKILL.md with TOC, navigation, license, and cross-references.
3. tagged/ — Like standard, but adds tags to pages and includes TAG-INDEX.json for tag-based lookup.

Each example is a complete, valid skillbook structure that passes 'skillbook validate'.

Write ~30-40 lines. Professional tone. Output ONLY the markdown content." 2048)
write_file "$BASE/examples/README.md" "$RESULT"

# ─── TASK 7: Minimal example ───
echo "📝 Task 7/14: Minimal example skillbook"
RESULT=$(call_mm "Create a minimal example skillbook — the smallest valid skillbook structure. Topic: 'Quick Reference Guide' (generic).

Files to generate (output ALL files, separated by '--- FILE: <path> ---' markers):

1. SKILL.md — Agent Skills frontmatter (name: minimal-example, description, license: CC-BY-4.0, metadata with skillbooks-* fields: title, server: https://skillbooks.ai, version: 1.0.0, pages: 2, price: \$2.00). Navigation instructions. Short TOC with 2 entries. License section.

2. README.md — Brief human-facing overview (~15 lines)

3. book.json — Required fields: id, title, description, version, author, language: en, verified: false, structure.readme

4. 01-basics/00-overview.md — Section overview: what this section covers, file index listing 01-hello.md (~20 lines)

5. 01-basics/01-hello.md — A simple content page about getting started (~40 lines)

Each file should be 15-40 lines. Use this exact separator format between files:
--- FILE: <relative-path> ---

Output ONLY the file contents with separators." 4096)

# Parse multi-file output
echo "$RESULT" | awk -v base="$BASE/examples/minimal" '
/^--- FILE:/ {
  if (outfile != "") close(outfile)
  fname = $0
  sub(/^--- FILE: */, "", fname)
  sub(/ *---.*$/, "", fname)
  outfile = base "/" fname
  cmd = "mkdir -p \"$(dirname '\''" outfile "'\'')\""
  system(cmd)
  next
}
outfile != "" { print >> outfile }
END { if (outfile != "") close(outfile) }
'
echo "  ✅ Wrote minimal example files"

# ─── TASK 8: Standard example ───
echo "📝 Task 8/14: Standard example skillbook"
RESULT=$(call_mm "Create a standard example skillbook. Topic: 'API Design Patterns' (relatable to developers). 2 sections, ~8 pages total.

Files to generate (output ALL files, separated by '--- FILE: <path> ---' markers):

1. SKILL.md — Full Agent Skills frontmatter (name: api-design-patterns, description about REST/GraphQL API design, license: all-rights-reserved, compatibility: Requires HTTP access to skillbooks.ai, metadata with skillbooks-* fields: title: API Design Patterns, server: https://skillbooks.ai, version: 1.0.0, pages: 8, price: \$8.00). Navigation instructions explaining URL construction and auth. Full TOC with all 8 pages across 2 sections. License section. Quick start paths.

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
Output ONLY file contents with separators." 8192)

echo "$RESULT" | awk -v base="$BASE/examples/standard" '
/^--- FILE:/ {
  if (outfile != "") close(outfile)
  fname = $0
  sub(/^--- FILE: */, "", fname)
  sub(/ *---.*$/, "", fname)
  outfile = base "/" fname
  cmd = "mkdir -p \"$(dirname '\''" outfile "'\'')\""
  system(cmd)
  next
}
outfile != "" { print >> outfile }
END { if (outfile != "") close(outfile) }
'
echo "  ✅ Wrote standard example files"

# ─── TASK 9: Tagged example ───
echo "📝 Task 9/14: Tagged example skillbook"
RESULT=$(call_mm "Create a tagged example skillbook. Topic: 'Cloud Infrastructure'. 2 sections, adds tags to demonstrate TAG-INDEX.json.

Files to generate (output ALL files, separated by '--- FILE: <path> ---' markers):

1. SKILL.md — Agent Skills frontmatter (name: cloud-infrastructure, license: all-rights-reserved, metadata with skillbooks-* fields including skillbooks-tags: 'true', pages: 6, price: \$10.00). Navigation instructions mentioning TAG-INDEX.json availability. TOC. License. Quick start paths.

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
Output ONLY file contents with separators." 8192)

echo "$RESULT" | awk -v base="$BASE/examples/tagged" '
/^--- FILE:/ {
  if (outfile != "") close(outfile)
  fname = $0
  sub(/^--- FILE: */, "", fname)
  sub(/ *---.*$/, "", fname)
  outfile = base "/" fname
  cmd = "mkdir -p \"$(dirname '\''" outfile "'\'')\""
  system(cmd)
  next
}
outfile != "" { print >> outfile }
END { if (outfile != "") close(outfile) }
'
echo "  ✅ Wrote tagged example files"

# ─── TASK 10: CONTRIBUTING.md ───
echo "📝 Task 10/14: CONTRIBUTING.md"
RESULT=$(call_mm "Write CONTRIBUTING.md for the Skillbook Format specification repository (github.com/skillbooks-ai/format).

This is an open-source spec — not a code project. Include:
- How to propose spec changes: open a GitHub issue describing the change → discuss → if accepted, submit an RFC-style PR
- How to submit example skillbooks to examples/
- Style guide: precise imperative language, RFC 2119 keywords (MUST, SHOULD, MAY), no marketing language
- PR review process: at least one maintainer review required
- Code of conduct: reference Contributor Covenant (link to CODE_OF_CONDUCT.md)
- How to report bugs in the spec (ambiguities, contradictions)

~50-70 lines. Professional open-source tone. Output ONLY the markdown content." 4096)
write_file "$BASE/CONTRIBUTING.md" "$RESULT"

# ─── TASK 11: Agent Skills compatibility guide ───
echo "📝 Task 11/14: docs/agent-skills-compatibility.md"
RESULT=$(call_mm "Write docs/agent-skills-compatibility.md — a guide explaining how Skillbook Format relates to and extends Agent Skills.

KEY FACTS:
- Agent Skills (agentskills.io) is the open standard adopted by 30+ tools: Claude Code, Cursor, Gemini CLI, VS Code, GitHub Copilot, Windsurf, etc.
- Agent Skills provides: name, description, license, compatibility frontmatter + standard directory conventions (SKILL.md, scripts/, references/, assets/)
- Skillbooks are a STRICT SUPERSET — every skillbook SKILL.md is a valid Agent Skills file
- Skillbook-specific fields are namespaced under metadata with 'skillbooks-' prefix (per Agent Skills spec extension mechanism)
- Any Agent Skills consumer can read a skillbook's SKILL.md without modification

Include:
- Title: 'Agent Skills Compatibility'
- Overview of the relationship
- Which fields are standard Agent Skills vs skillbook extensions (bullet list)
- How discovery works (any Agent Skills consumer finds skillbooks automatically)
- Migration guide: how to convert an existing Agent Skill into a Skillbook (add book.json, add sections, add metadata fields)
- What happens when a non-skillbook-aware tool encounters a skillbook (it just reads SKILL.md as a normal skill)

~60-80 lines. Output ONLY the markdown content." 4096)
write_file "$BASE/docs/agent-skills-compatibility.md" "$RESULT"

# ─── TASK 12: FAQ ───
echo "📝 Task 12/14: docs/faq.md"
RESULT=$(call_mm "Write docs/faq.md — Frequently Asked Questions about the Skillbook Format.

Answer these questions concisely (3-5 sentences each):

1. What's the difference between an Agent Skill and a Skillbook?
   Agent Skills are cheat sheets — short, focused instructions. Skillbooks are textbooks — deep, structured, multi-page knowledge. A skillbook's SKILL.md IS a valid Agent Skill. Same entry point, dramatically more depth.

2. Do I need to use skillbooks.ai to publish?
   The format is open — anyone can host skillbooks. skillbooks.ai is the official marketplace with built-in payments, discovery, and validation. Self-hosting is valid but you handle auth and payments yourself.

3. How is pricing calculated?
   Authors set a full book price. Per-page price = full_price / total_pages. Agents pay per page accessed. Revenue split: 80% author, 20% platform (platform absorbs Stripe fees).

4. Can I use this for free/open content?
   Yes. Set price to \$0.00 or use an open license. The format works the same — you just skip the payment layer. Great for open-source documentation, public domain works.

5. What agents support this?
   Any agent that supports Agent Skills can discover skillbooks (30+ tools). For paid content access, the agent needs to support HTTP fetching with API key auth.

6. How does versioning affect billing?
   Patch (1.0.x): no new charges. Minor (1.x.0): new pages cost credits, existing accessed pages stay free. Major (x.0.0): treated as new book, all pages cost again.

7. What's TAG-INDEX.json?
   An optional file mapping tags to pages for O(1) lookup. Served free alongside SKILL.md. Agents load it once to find relevant pages by topic without scanning the TOC.

~60-80 lines. Output ONLY the markdown content." 4096)
write_file "$BASE/docs/faq.md" "$RESULT"

# ─── TASK 13: LICENSE files ───
echo "📝 Task 13/14: LICENSE files"
# Apache 2.0 — standard text
cat > "$BASE/LICENSE-APACHE" << 'APACHE_EOF'
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
      not limited to compiled object code, generated documentation,
      and conversions to other media types.

      "Work" shall mean the work of authorship, whether in Source or
      Object form, made available under the License, as indicated by a
      copyright notice that is included in or attached to the work.

      "Derivative Works" shall mean any work, whether in Source or Object
      form, that is based on (or derived from) the Work and for which the
      editorial revisions, annotations, elaborations, or other modifications
      represent, as a whole, an original work of authorship. For the purposes
      of this License, Derivative Works shall not include works that remain
      separable from, or merely link (or bind by name) to the interfaces of,
      the Work and Derivative Works thereof.

      "Contribution" shall mean any work of authorship, including
      the original version of the Work and any modifications or additions
      to that Work or Derivative Works thereof, that is intentionally
      submitted to the Licensor for inclusion in the Work by the copyright owner
      or by an individual or Legal Entity authorized to submit on behalf of
      the copyright owner. For the purposes of this definition, "submitted"
      means any form of electronic, verbal, or written communication sent
      to the Licensor or its representatives, including but not limited to
      communication on electronic mailing lists, source code control systems,
      and issue tracking systems that are managed by, or on behalf of, the
      Licensor for the purpose of discussing and improving the Work, but
      excluding communication that is conspicuously marked or otherwise
      designated in writing by the copyright owner as "Not a Contribution."

      "Contributor" shall mean Licensor and any individual or Legal Entity
      on behalf of whom a Contribution has been received by the Licensor and
      subsequently incorporated within the Work.

   2. Grant of Copyright License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      copyright license to reproduce, prepare Derivative Works of,
      publicly display, publicly perform, sublicense, and distribute the
      Work and such Derivative Works in Source or Object form.

   3. Grant of Patent License. Subject to the terms and conditions of
      this License, each Contributor hereby grants to You a perpetual,
      worldwide, non-exclusive, no-charge, royalty-free, irrevocable
      (except as stated in this section) patent license to make, have made,
      use, offer to sell, sell, import, and otherwise transfer the Work,
      where such license applies only to those patent claims licensable
      by such Contributor that are necessarily infringed by their
      Contribution(s) alone or by combination of their Contribution(s)
      with the Work to which such Contribution(s) was submitted. If You
      institute patent litigation against any entity (including a
      cross-claim or counterclaim in a lawsuit) alleging that the Work
      or a Contribution incorporated within the Work constitutes direct
      or contributory patent infringement, then any patent licenses
      granted to You under this License for that Work shall terminate
      as of the date such litigation is filed.

   4. Redistribution. You may reproduce and distribute copies of the
      Work or Derivative Works thereof in any medium, with or without
      modifications, and in Source or Object form, provided that You
      meet the following conditions:

      (a) You must give any other recipients of the Work or
          Derivative Works a copy of this License; and

      (b) You must cause any modified files to carry prominent notices
          stating that You changed the files; and

      (c) You must retain, in the Source form of any Derivative Works
          that You distribute, all copyright, patent, trademark, and
          attribution notices from the Source form of the Work,
          excluding those notices that do not pertain to any part of
          the Derivative Works; and

      (d) If the Work includes a "NOTICE" text file as part of its
          distribution, then any Derivative Works that You distribute must
          include a readable copy of the attribution notices contained
          within such NOTICE file, excluding any notices that do not
          pertain to any part of the Derivative Works, in at least one
          of the following places: within a NOTICE text file distributed
          as part of the Derivative Works; within the Source form or
          documentation, if provided along with the Derivative Works; or,
          within a display generated by the Derivative Works, if and
          wherever such third-party notices normally appear. The contents
          of the NOTICE file are for informational purposes only and
          do not modify the License. You may add Your own attribution
          notices within Derivative Works that You distribute, alongside
          or as an addendum to the NOTICE text from the Work, provided
          that such additional attribution notices cannot be construed
          as modifying the License.

      You may add Your own copyright statement to Your modifications and
      may provide additional or different license terms and conditions
      for use, reproduction, or distribution of Your modifications, or
      for any such Derivative Works as a whole, provided Your use,
      reproduction, and distribution of the Work otherwise complies with
      the conditions stated in this License.

   5. Submission of Contributions. Unless You explicitly state otherwise,
      any Contribution intentionally submitted for inclusion in the Work
      by You to the Licensor shall be under the terms and conditions of
      this License, without any additional terms or conditions.
      Notwithstanding the above, nothing herein shall supersede or modify
      the terms of any separate license agreement you may have executed
      with Licensor regarding such Contributions.

   6. Trademarks. This License does not grant permission to use the trade
      names, trademarks, service marks, or product names of the Licensor,
      except as required for reasonable and customary use in describing the
      origin of the Work and reproducing the content of the NOTICE file.

   7. Disclaimer of Warranty. Unless required by applicable law or
      agreed to in writing, Licensor provides the Work (and each
      Contributor provides its Contributions) on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
      implied, including, without limitation, any warranties or conditions
      of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
      PARTICULAR PURPOSE. You are solely responsible for determining the
      appropriateness of using or redistributing the Work and assume any
      risks associated with Your exercise of permissions under this License.

   8. Limitation of Liability. In no event and under no legal theory,
      whether in tort (including negligence), contract, or otherwise,
      unless required by applicable law (such as deliberate and grossly
      negligent acts) or agreed to in writing, shall any Contributor be
      liable to You for damages, including any direct, indirect, special,
      incidental, or consequential damages of any character arising as a
      result of this License or out of the use or inability to use the
      Work (including but not limited to damages for loss of goodwill,
      work stoppage, computer failure or malfunction, or any and all
      other commercial damages or losses), even if such Contributor
      has been advised of the possibility of such damages.

   9. Accepting Warranty or Additional Liability. While redistributing
      the Work or Derivative Works thereof, You may choose to offer,
      and charge a fee for, acceptance of support, warranty, indemnity,
      or other liability obligations and/or rights consistent with this
      License. However, in accepting such obligations, You may act only
      on Your own behalf and on Your sole responsibility, not on behalf
      of any other Contributor, and only if You agree to indemnify,
      defend, and hold each Contributor harmless for any liability
      incurred by, or claims asserted against, such Contributor by reason
      of your accepting any such warranty or additional liability.

   END OF TERMS AND CONDITIONS

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
APACHE_EOF
echo "  ✅ Wrote LICENSE-APACHE"

cat > "$BASE/LICENSE-CC-BY" << 'CCBY_EOF'
Creative Commons Attribution 4.0 International (CC BY 4.0)

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
CCBY_EOF
echo "  ✅ Wrote LICENSE-CC-BY"

# ─── TASK 14: CHANGELOG.md ───
echo "📝 Task 14/14: CHANGELOG.md"
RESULT=$(call_mm "Write CHANGELOG.md for the Skillbook Format specification repository. Use Keep a Changelog format (https://keepachangelog.com/).

Include a single release:

## [1.0.0] — 2026-03-10

### Added
- Agent Skills compatibility as the base layer — every SKILL.md is a valid Agent Skills file
- Frontmatter uses Agent Skills standard fields with skillbooks-* extensions under metadata
- Directory structure specification (sections, 00-overview.md, naming conventions)
- SKILL.md specification (frontmatter, navigation, TOC, license, quick start paths)
- Content pages specification (40-100 lines, one concept, self-contained, cross-references)
- Tags and TAG-INDEX.json for O(1) topic lookup
- book.json metadata schema
- Semver versioning with billing implications (patch/minor/major)
- Pricing model: author sets full price, per-page derived, 80/20 revenue split
- Publishing workflow: validate → publish
- Three example skillbooks: minimal, standard, tagged

### Changed (from pre-1.0)
- Removed SUMMARY.md — SKILL.md TOC is the single source of truth
- Replaced folder README.md files with 00-overview.md
- Revenue split changed from 90/10 to 80/20 (platform absorbs Stripe fees)
- Removed structure.summary from book.json

~30-40 lines. Output ONLY the markdown content." 2048)
write_file "$BASE/CHANGELOG.md" "$RESULT"

echo ""
echo "=== Done! ==="
echo "Finished: $(date)"
echo ""
echo "Files generated:"
find "$BASE" -type f -name '*.md' -o -name '*.json' -o -name 'LICENSE-*' | sort
