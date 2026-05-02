# Skill Resolution

## Trigger

Apply this rule whenever an agent role requires a capability or knowledge area not covered by its `ROLE.md` or the `knowledge/` base.

## Required Flow

1. MUST check `knowledge/` first — the answer may already exist in one of the architectural handbooks.
2. MUST check the role's `ROLE.md` for guidance on scope boundaries before assuming a gap.
3. If the capability is genuinely missing, MUST surface the gap to the orchestrator via a blocking comment in the output — do not silently skip or invent.
4. MUST NOT expand a role's scope unilaterally. Scope changes require a new ticket from the Project Manager.

## After the Task

If a recurring capability gap is identified, flag it so the relevant `knowledge/` file or `ROLE.md` can be updated before the next build run.
