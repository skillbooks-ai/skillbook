# Error Handling

Consistent error handling improves developer experience and helps clients handle failures gracefully. Your API should communicate errors clearly and predictably.

## HTTP Status Codes

Use standard status codes to indicate error types:

| Code | Meaning |
|------|---------|
| 400 | Bad Request — Client sent invalid data |
| 401 | Unauthorized — Authentication required |
| 403 | Forbidden — Access denied |
| 404 | Not Found — Resource doesn't exist |
| 422 | Unprocessable Entity — Validation failed |
| 429 | Too Many Requests — Rate limit exceeded |
| 500 | Internal Server Error — Unexpected failure |

## Error Response Format

Include helpful details in error responses:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": [
      {
        "field": "email",
        "issue": "Must be a valid email address"
      }
    ],
    "request_id": "abc-123-def"
  }
}
```

## Best Practices

### Be Consistent
Use the same error structure across all endpoints. Clients should always know where to find error details.

### Include Request IDs
Trace identifiers help support teams diagnose issues. Log request IDs server-side for correlation.

### Don't Leak Sensitive Data
Error messages should be user-friendly but never expose internal system details to external clients.

### Provide Actionable Messages
Tell clients what they can do differently. "Invalid parameter" is less helpful than "Page size must be between 1 and 100."

## Next Steps

With fundamentals complete, proceed to the [Patterns Section](../02-patterns/00-overview.md) for advanced implementation strategies.
