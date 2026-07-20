# Resource Indexes & Delivery

Large Skillbooks SHOULD keep capability entry points small and retrieve supporting material
only when the task requires it. A declared resource index extends Agent Skills progressive
disclosure without requiring a vector database, embeddings, or a RAG deployment.

## The Runtime Atom

```text
activate one capability → search pointers if needed → fetch exact resource → produce outcome
```

Search and fetch are separate operations. Search MUST return pointers and selection metadata,
not full resource bodies. Fetch resolves one selected pointer and returns only the bounded
resource needed for the task.

## Package Configuration

Declare indexed resources under `skillbook.resources` in `package.json`:

```json
{
  "index": "knowledge/index.sqlite",
  "search": "scripts/search_resources.py",
  "fetch": "scripts/fetch_resource.py",
  "delivery": {
    "default": "local-first",
    "local": { "root": "knowledge/source", "optional": true },
    "hosted": {
      "auth": { "scheme": "bearer", "environment": "SKILLBOOKS_API_KEY" },
      "versionHeader": "X-Skillbook-Version"
    }
  }
}
```

The index format is implementation-defined. SQLite FTS5 is a useful portable default, but
the standard does not require SQLite. The installed index SHOULD be small enough to search
locally and MAY be a binary artifact. Publishers and installers MUST preserve a declared
index even when it is not a text file.

A contentless full-text index does not contain page-body columns, but it may still expose ordered
normalized tokens and positions from which much of the indexed prose can be reconstructed. A thin
edition intended to keep licensed text hosted SHOULD therefore bundle only non-sensitive routing
metadata or a coarse local index and let the declared search program query an entitlement-gated
hosted search service. Publishers MUST NOT describe a positional full-corpus FTS index as keeping
the indexed knowledge hosted-only.

## Pointer Contract

Resource URIs MUST be stable within a major version and use:

```text
skillbook://<book-name>/<resource-id>
```

With `--json`, the declared search program MUST return an array whose entries contain:

```json
{
  "uri": "skillbook://book/resource-id",
  "title": "Human- or agent-readable selection label",
  "location": "knowledge/source/path.md",
  "sha256": "optional-content-digest"
}
```

The search result MAY include headings, media type, rank, or other selection metadata. It
MUST NOT include the full resource body. A search program SHOULD accept a query, `--limit`,
and `--json`; exact invocation belongs in the root or capability entry point.

The declared fetch program MUST accept one resource URI as a positional argument. With `--json`,
it MUST return one object containing `uri` and `content`. It SHOULD also return `title`,
`mediaType`, `sha256`, `resolvedFrom`, and `license`. The resolver MUST reject unknown pointers
and MUST NOT print authentication credentials.

## Local and Hosted Editions

A complete author edition MAY include local source modules. A thin installed edition MAY
contain only capability entries, resolver scripts, and the pointer index, then fetch licensed
modules from the configured server. The package `name`, `skillbook.server`, and pointer `location`
define the hosted resource. Unless a platform documents an equivalent resolver, the hosted URL is
`{server}/{name}/{location}`.

If both delivery modes exist, the resolver SHOULD default to local-first unless the manifest
states otherwise. The declared default MUST name an included mode; `local-first` and
`hosted-first` require both modes. Protected hosted resources SHOULD use bearer authentication.
Public hosted resources may omit `auth`. Platforms MAY also support compatibility headers such as
`X-Skillbook-Key`.

The index and hosted resources MUST be version-compatible. When a fetched resource has a
declared digest and the content does not match it, the resolver MUST fail closed and direct
the client to update the Skillbook package or index. Content updates and their matching index
SHOULD be published atomically.

## Licensing and Context Discipline

An index is a routing artifact, not DRM. A contentless search index can avoid storing page
bodies while still indexing terms and positions; authors MUST NOT describe that as copy
protection.
License instructions SHOULD tell agents to use fetched material for the licensed user's task
without bulk extraction or redistribution.

Agents SHOULD fetch the smallest resource set that resolves the task. Capability procedures
belong in entry points; detailed definitions, examples, source material, and templates belong
behind resource pointers when they are not needed on every run.

---

[← Previous: Tags & Index](03-tags-and-index.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
