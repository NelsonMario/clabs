# API Design: The Philosophy of Contracts

An API is a rigid, unyielding contract between two entities. A good API is predictable, self-documenting, and designed with the assumption that the consumer does not know how your internal code works.

## Fundamental Concepts

### 1. Resources, Not Verbs (REST Philosophy)
APIs should represent a hierarchy of "Resources" (nouns), not a collection of remote procedure calls (verbs). 
Instead of asking an API to `/activateUser` or `/deleteCart`, you modify the state of a resource: you `POST` a new state to a `User` or you `DELETE` the `Cart` resource. The standard HTTP methods (GET, POST, PUT, PATCH, DELETE) act as the universal verbs.

### 2. Predictable Envelopes
Consumers should never have to guess the shape of your response. Every successful request should wrap its payload in a generic "data" envelope. Every failed request should provide an "error" envelope containing an actionable error code and a human-readable message.

### 3. Idempotency
Network requests fail. Consumers will retry requests. **Idempotency** means that if a consumer sends the exact same `POST` or `DELETE` request ten times in a row, the effect on the system is only executed once. This is critical for operations like payment processing—you must design external APIs to accept idempotency keys to prevent accidental double-charging.

### 4. Defensive Pagination
Never trust that a collection is "small enough" to return all at once. Any list endpoint must be paginated by default. If a collection is prone to rapidly changing data, utilize cursor-based pagination rather than offset-based, ensuring the consumer doesn't skip or duplicate records as the underlying data shifts.
