# Pagination Patterns

When APIs return large collections, pagination is essential for performance and usability. Clients need a consistent way to navigate through data.

## Why Pagination Matters

Without pagination, a single request could return thousands of results, causing:
- Slow response times
- Increased bandwidth usage
- Memory issues on client devices
- Timeouts and failures

## Common Pagination Strategies

### Offset-Based Pagination

Uses `limit` and `offset` parameters:

```
GET /users?limit=20&offset=40
```

**Pros**: Simple to implement, supports jumping to specific pages

**Cons**: Performance degrades with high offsets, inconsistent results with changing data

### Cursor-Based Pagination

Uses an opaque cursor (usually the last item's ID):

```
GET /users?limit=20&cursor=eyJpZCI6NDJ9
```

**Pros**: Consistent performance at any position, works well with real-time data

**Cons**: Cannot jump to arbitrary pages, slightly more complex implementation

### Page-Based Pagination

Uses explicit page numbers:

```
GET /users?page=2&per_page=20
```

**Pros**: Intuitive for users, easy to understand

**Cons**: Same offset performance issues, confusing with changing data

## Response Format Example

```json
{
  "data": [...],
  "pagination": {
    "total": 1523,
    "page": 2,
    "per_page": 20,
    "total_pages": 77,
    "next_cursor": "eyJpZCI6NDJ9",
    "has_more": true
  }
}
```

## Choosing a Strategy

For most APIs, cursor-based pagination offers the best balance of performance and usability. Use offset for simple, read-only datasets where jumping to specific pages adds value.

## Related Topics

- [Error Handling](../01-fundamentals/03-error-handling.md) — Return appropriate errors for invalid pagination parameters
- [Rate Limiting](./03-rate-limiting.md) — Prevent abuse of list endpoints
