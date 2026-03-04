# REST Principles

REST (Representational State Transfer) is the foundational architectural style for modern web APIs. Understanding its constraints is essential for building scalable, maintainable interfaces.

## The Six Constraints

### 1. Client-Server Architecture
The client and server operate independently. Clients are not concerned with data storage, while servers don't handle user interface concerns. This separation allows components to evolve independently.

### 2. Statelessness
Each request contains all information needed to process it. The server stores no client context between requests. This improves visibility, reliability, and scalability.

### 3. Cacheability
Responses must be explicitly marked as cacheable or non-cacheable. Proper caching reduces latency and server load.

### 4. Uniform Interface
Resources are identified by URIs. Representations (JSON, XML) are used to transfer state. Clients interact through representations using HTTP methods.

### 5. Layered System
The architecture can have intermediate servers (proxies, load balancers) without clients knowing. This enables scalability and security.

### 6. Code on Demand (Optional)
Servers can temporarily extend client functionality by transferring executable code.

## HTTP Methods in REST

| Method | Purpose | Idempotent |
|--------|---------|------------|
| GET | Retrieve resources | Yes |
| POST | Create new resources | No |
| PUT | Replace entire resource | Yes |
| PATCH | Partial update | No |
| DELETE | Remove resource | Yes |

## Key Takeaways

REST provides a proven pattern for building APIs that are scalable, simple, and widely understood. Following these principles ensures your API integrates easily with existing tools and workflows.

## Next Steps

Continue to [Resource Design](./02-resource-design.md) to learn how to structure your API endpoints effectively.
