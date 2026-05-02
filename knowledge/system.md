# System Architecture: Distribution and Resilience

The transition from a monolith to distributed systems replaces the reliability of local function calls with the unpredictable chaos of network calls. Our system architecture philosophy prioritizes resilience in the face of inevitable failures.

## Core Architectural Concepts

### 1. Design for Failure
Assume every external system, database, and network switch will fail. 
- **Timeouts**: No request should wait forever.
- **Circuit Breakers**: If a downstream service is failing, stop hammering it. "Trip the circuit" and return immediate errors or cached fallbacks so the downstream service has time to recover.
- **Bulkheads**: Isolate failures. If the email notification service crashes, it should not bring down the checkout queue.

### 2. Eventual Consistency
In a distributed world, forcing multiple databases to instantly synchronize (Strong Consistency via 2-Phase Commits) destroys performance and availability. Instead, embrace **Eventual Consistency**.
Services should handle their own atomic operations and emit generic "Events" (e.g., `OrderPlaced`) to a message broker. Other services listen to these events and update their state eventually. The system is momentarily out of sync, but highly available, and will eventually converge on the correct truth.

### 3. Command Query Responsibility Segregation (CQRS)
Reading data and writing data have drastically different operational profiles. Write-paths require heavy validation, transactions, and locking. Read-paths require raw speed. 
CQRS solves this by physically separating them. You write to a highly-normalized transactional database. You read from a heavily denormalized, fast cache or search index. The two stores are kept in sync asynchronously.

### 4. Bounded Contexts
Don't share databases. A `User` in the Billing system is a completely different concept than a `User` in the Analytics system. Force services to communicate through APIs or Events, not by reaching into each other's SQL tables.
