# Skillbook Format — Frequently Asked Questions

## 1. What is the difference between an Agent Skill and a Skillbook?

Agent Skills are cheat sheets — quick reference guides for immediate tasks. Skillbooks are textbooks: deep, structured, multi-page knowledge resources that teach comprehensively. A skillbook's `SKILL.md` file is a valid Agent Skill, so it works as both. Same entry point, dramatically more depth.

## 2. Do I need to use skillbooks.ai to publish?

No. The Skillbook Format is open and free to use. **skillbooks.ai** is the official marketplace that provides payments, discovery, validation, and hosting. Self-hosting your skillbook is completely valid — you can publish anywhere that serves markdown.

## 3. How is pricing calculated?

Authors set a full book price when publishing. Per-page price is calculated as `full_price / total_pages`. Revenue split is **80% to the author** and **20% to the platform**. This applies to all paid skillbooks on the marketplace.

## 4. Can I use this for free/open content?

Yes. Simply set the price to **$0.00**. The format works identically — readers can still discover, download, and use your skillbook. Free skillbooks are a great way to build an audience or share open knowledge.

## 5. What agents support this?

Any agent that supports Agent Skills can discover and use skillbooks. This includes **30+ tools** in the ecosystem. For paid content, agents need HTTP capability and your API key to authenticate requests.

## 6. How does versioning affect billing?

- **Patch updates** (e.g., v1.0.1): No new charges — readers keep access.
- **Minor updates** (e.g., v1.1.0): New pages cost; existing pages remain free.
- **Major updates** (e.g., v2.0.0): All pages are charged again, as it's treated as a new book.

## 7. What is TAG-INDEX.json?

An optional metadata file that maps tags to specific pages for **O(1) lookup speed**. It allows agents to jump directly to relevant sections without parsing the full skillbook. It's served free alongside `SKILL.md` and is recommended for larger skillbooks.

---

*For more details, see the full [Skillbook Format Specification](./spec.md).*
```
