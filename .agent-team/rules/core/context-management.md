# Context Management

## Trigger

Apply this rule when switching phases, resuming paused work, or when working context has grown stale.

## When to Reset Context

MUST perform a context cleanup before:

1. **Phase transitions** — finishing Consult and starting Build, or starting a new Build ticket after completing a prior one.
2. **Large content intake** — before processing substantial diffs, logs, or outputs that could displace working memory.
3. **Clarity loss** — when the session can no longer clearly hold the task goal, constraints, and next steps simultaneously.
4. **Discontinuous work** — after pauses, restarts, handoffs, or switching between agent roles.

## Re-Anchor Hierarchy

When resuming or recovering, load context in this order:

1. `.agent-team/rules/index.md` — orchestration rules
2. Matching rule files in `core/` — applicable constraints
3. `projects/[name]/intake.md` — the scoped execution plan
4. Role file in `.agent-team/teams/[role]/ROLE.md` — agent identity and responsibilities
5. `knowledge/` files relevant to the current ticket

Do not skip to detail files before understanding the broader framework.

## Core Principle

Reset session context without modifying file artifacts. Re-anchor via the hierarchy above before producing any new output.
