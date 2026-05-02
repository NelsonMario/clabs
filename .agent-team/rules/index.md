# CLABS Orchestration Rules

Read this file first. Then load the relevant `core/` rule files before producing any output.

## Core Rules

These apply universally across all phases and agent roles:

| File | Governs |
|------|---------|
| [`core/debugging.md`](core/debugging.md) | Bugs, errors, and build failures — reproduce → inspect → isolate → validate |
| [`core/context-management.md`](core/context-management.md) | When to reset context; re-anchor hierarchy for phase transitions and handoffs |
| [`core/worktree.md`](core/worktree.md) | Branch safety, file placement, and commit scope for agent worktrees |
| [`core/merge-workflow.md`](core/merge-workflow.md) | Controller-side rebase and merge sequencing; agents never rebase |
| [`core/agent-commands.md`](core/agent-commands.md) | Canonical CLABS entry points; what agents must not commit or modify |
| [`core/skill-resolution.md`](core/skill-resolution.md) | How to handle capability gaps — check knowledge/ first, surface blockers, don't invent |

---

## Phase Rules

### Consult Phase
- The Project Manager agent owns this phase entirely.
- Do NOT write any application code during consultation.
- Output: a completed `projects/[name]/intake.md` with a JSON execution plan.
- Always confirm the plan with the user before proceeding to Build.

### Build Phase
- The Lead Orchestrator reads `intake.md` and spawns agents based on its tickets.
- Always sequence agents in this order:
  1. `system-architect` — define contracts and domain boundaries first
  2. `devils-advocate` — surface fatal flaws before any code is written
  3. `uiux-designer` — produce design specs before frontend starts
  4. `backend-engineer` — implement domain and APIs
  5. `frontend-engineer` — implement UI against the backend contracts
  6. `devops-engineer` — containerize and wire CI/CD
  7. `qa-architect` — write test plans and test code
  8. `code-reviewer` — audit the final output
- Agents may work in parallel where dependencies allow (e.g., backend + uiux can overlap).
- All agents must read the relevant files in `knowledge/` before producing output.
- All output lands in `projects/[project_name]/`.

## Knowledge Loading
- Every agent receives the knowledge manifest listing all `knowledge/*.md` files.
- Agents must respect the architectural constraints defined there (Hexagonal Architecture, 12-Factor, etc.).

## Ticket Rules
- One ticket per agent per concern — no cross-agent tickets.
- Each ticket must specify: WHAT to produce, WHY it matters, acceptance criteria.
- No gold-plating — do not generate work not requested.

## Role Files
- All role definitions are in `.agent-team/teams/[role]/ROLE.md`.
- Do not modify role files during a build — they are stable system prompts.
