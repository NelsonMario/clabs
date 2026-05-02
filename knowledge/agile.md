# Agile & Project Management Philosophy

A project without scope constraints is doomed to fail. Our project management philosophy relies on strict boundaries, measurable outcomes, and deterministic assignment of work.

## 1. Scope Definition (The Consultant Phase)
Before any engineer writes a line of code, the true scope must be identified. Humans naturally speak in vague concepts ("I want a fast messaging app"). 
The Project Manager's first job is to parse these vague requirements into an explicit, human-readable **Consultation Scope Document**. This document proves that both the user and the executing agents share the same reality.

## 2. Breaking Down the Monolith (The Execution Plan)
A task labeled "Build authentication" is impossible to execute deterministically in a multi-agent or human system. Work must be broken down into extremely granular, interlocking dependencies.

- **Isolation**: Each ticket must be actionable by exactly ONE agent/specialty without overlapping concerns. (e.g., A backend engineer should not be modifying CSS in their ticket).
- **Sequencing**: Tickets must rely on Directed Acyclic Graphs (DAGs). The Database Entity ticket must finish before the Repository pattern ticket begins. This prevents blockers and scope collisions.

## 3. Measurable Acceptance Criteria
Acceptance criteria must be verifiable.
- **Bad:** "The login works."
- **Good:** "A POST request to /login returns a 200 OK and a JWT stored in an HttpOnly cookie."

A ticket is only considered "Done" when the output strictly matches the criteria, passing the specialized Code Reviewer agent's architectural audit.
