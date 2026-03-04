# Resource Design

Resource design determines how clients interact with your API. Well-designed resources are intuitive, consistent, and scalable.

## What Is a Resource?

A resource is any object or concept your API exposes. Examples include users, orders, products, and calculations. Each resource has a unique identifier (URI) and supports a set of operations.

## Resource Naming Best Practices

### Use Nouns, Not Verbs
```
# Bad
GET /getUsers
POST /createUser

# Good
GET /users
POST /users
```

### Use Plural Forms
```
/users        # Collection
/users/123    # Specific item
```

### Use Lowercase with Hyphens
```
/user-profiles
/api-keys
```

### Nest Related Resources
```
/users/123/orders        # Orders belonging to user 123
/orders/456/items        # Items in order 456
```

## Resource Hierarchy

Structure resources to reflect relationships:

- **Collection**: `/users` — All users
- **Singleton**: `/settings` — Single settings resource
- **Sub-collection**: `/users/123/orders` — User's orders

## Query Parameters for Filtering

Use query parameters to filter, sort, and format:

```
GET /users?status=active&sort=name&limit=10
```

## Design Considerations

Keep resources flat when possible. Deep nesting (e.g., `/orgs/123/depts/456/teams/789/members`) creates fragile client code. Consider using links or query parameters instead.

## Next Steps

Learn how to handle [Error Handling](./03-error-handling.md) when things go wrong in your API.
