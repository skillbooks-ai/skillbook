# API Versioning Strategies

API versioning allows you to evolve your interface without breaking existing client integrations. Choosing the right strategy impacts long-term maintainability.

## When to Version

Create a new version when making breaking changes:
- Removing or renaming fields
- Changing response structure
- Modifying authentication requirements
- Altering error formats

## Versioning Strategies

### URL Path (Most Common)

Include version in the path:

```
GET /api/v1/users
GET /api/v2/users
```

**Pros**: Explicit, easy to route, clear which version is being used

**Cons**: URL changes on every version bump, more complex routing

### Query Parameter

Pass version as a parameter:

```
GET /users?version=1
```

**Pros**: Single URL for all versions, easy to test

**Cons**: Easy to forget parameter, caching complications

### Header Versioning

Specify version in HTTP header:

```
Accept: application/vnd.myapi.v1+json
```

**Pros**: Clean URLs, flexible

**Cons**: Less visible, requires client header knowledge

## Best Practices

### Version Everything Consistently
Don't mix versioning strategies. Choose one approach and apply it uniformly.

### Support Multiple Versions Simultaneously
Give clients time to migrate. Maintain backward compatibility during transition periods.

### Document Deprecation
Clearly communicate timeline for removing old versions. Use deprecation headers:

```
Deprecation: true
Sunset: Sat, 01 Jan 2025 00:00:00 GMT
```

### Consider Semantic Versioning
Use MAJOR.MINOR.PATCH for version numbers. Increment major for breaking changes.

## Related Topics

- [REST Principles](../01-fundamentals/01-rest-principles.md) — Foundation for understanding versioning
- [Error Handling](../01-fundamentals/03-error-handling.md) — Handle version-related errors gracefully
