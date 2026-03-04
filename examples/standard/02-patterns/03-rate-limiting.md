# Rate Limiting Design

Rate limiting protects your API from abuse, ensures fair usage, and maintains performance for all clients. Well-designed rate limits balance protection with usability.

## Why Rate Limit

- Prevent denial-of-service attacks
- Protect backend services from overload
- Enforce tiered access plans
- Encourage efficient API usage

## Rate Limit Headers

Communicate limits to clients using standard headers:

```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640000000
```

## Common Rate Limit Strategies

### Fixed Window
Count requests in fixed time periods (e.g., per minute). Simple but can allow burst traffic at window boundaries.

### Sliding Window
More accurate than fixed window. Tracks request times within a rolling time period. Better prevents traffic spikes.

### Token Bucket
Clients consume tokens for each request. Tokens replenish at a set rate. Allows burst traffic while maintaining average rate.

## Response When Limited

Return 429 Too Many Requests with retry information:

```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Please retry after 60 seconds.",
    "retry_after": 60
  }
}
```

Include `Retry-After` header for HTTP compliance.

## Best Practices

### Set Reasonable Defaults
Start conservative and adjust based on usage patterns. Different endpoints may warrant different limits.

### Differentiate by Tier
Free tiers get stricter limits than paid plans. Communicate differences clearly in documentation.

### Graceful Degradation
Consider implementing queue systems or caching rather than hard failures for slightly exceeded limits.

### Monitor and Adjust
Track rate limit hits. Use analytics to identify legitimate high-usage clients who may need quota increases.

## Related Topics

- [Error Handling](../01-fundamentals/03-error-handling.md) — Proper error format for rate limit responses
- [Pagination](./01-pagination.md) — List endpoints often need stricter rate limits
