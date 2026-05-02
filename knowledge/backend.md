# Backend Architecture: The Hexagonal Philosophy

Backend systems decay when the "business logic" (what the application actually does) gets tangled up with the "infrastructure" (how the application talks to the outside world). To prevent this, we strictly enforce **Hexagonal Architecture** (also known as Ports and Adapters).

## The Core Concept
Imagine your application as an island. The center of the island is the **Domain**—this is where your pure business rules live. The Domain doesn't know about databases, HTTP, or message queues. It only knows about the business. 

To communicate with the mainland, the island has specific docks called **Ports**.
- **Inbound Ports** (Driving): The rules for how the outside world can ask the Domain to do something (e.g., "Activate a User").
- **Outbound Ports** (Driven): The rules the Domain lays out for what it needs from the outside world (e.g., "I need a way to store a User").

## The Adapters
Adapters are the ships that dock at the ports. They translate the chaotic outside world into the language of the Domain.
- **Driving Adapters** (e.g., HTTP Controllers, CLI tools) take external requests and push them through the Inbound Ports.
- **Driven Adapters** (e.g., SQL Repositories, Third-Party APIs) connect to the Outbound Ports, implementing the database or network calls the Domain requested.

## Why This Matters
If you want to swap from Postgres to MongoDB, or from REST to GraphQL, you **only rewrite the Adapters**. Your core Domain remains untouched because it never knew those technologies existed in the first place. You achieve true testability because you can easily swap real adapters for mock adapters during unit testing.
