# Pricing

Commerce is optional. A paid Skillbook SHOULD use a simple **per-book entitlement**: the user buys
access to the capability pack and its compatible hosted resources, rather than paying each time an
agent follows a resource pointer.

Per-book access keeps the outcome predictable and preserves the purpose of progressive disclosure.
Agents should retrieve the smallest useful context because it is faster and better—not because an
unpredictable per-page meter discourages them from fetching necessary evidence.

## Display Price

Authors MAY publish a full-book display price in `skillbook.price` and
`metadata.skillbook-price`, such as `"$20.00"`. Set `"$0.00"` for free content. The value is
catalog metadata, not a runtime authorization rule; hosted services determine entitlement status.

The v2 string form preserves compatibility with existing catalogs. Currency, regional pricing,
subscriptions, team licensing, refunds, revenue splits, and taxes are platform concerns and are
not encoded by this format.

## What Users Buy

A useful entitlement gives the licensed user:

- the declared capabilities and their small portable entry points
- exact-resource access through the declared resolver
- compatible corrections and additions within the purchased major version
- clear license terms for using outputs and underlying material

The package may be fully local or a thin hosted edition. Copyright instructions can state that
resources are for the purchaser's work and must not be bulk-extracted or redistributed, but the
standard does not define DRM or claim to make downloaded material uncopyable.

---

[← Previous: Versioning](02-versioning.md) | [↑ Section](00-overview.md) | [🏠 Home](../SKILL.md)
