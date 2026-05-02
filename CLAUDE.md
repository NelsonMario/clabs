# CLABS — Claude Agent Team Framework

Read this file first. It is your orientation guide for this repository.

## What This Project Does

CLABS orchestrates a team of specialized AI agents to plan and build software projects. It operates in two phases:

1. **Consult** — scope a raw idea into a sequenced execution plan (`intake.md`)
2. **Build** — spawn the full engineering team to execute that plan

---

## How to Orient Yourself

### When consulting on a new idea
→ Load `skills/consult-new/SKILL.md`

### When refining an existing plan
→ Load `skills/consult-refine/SKILL.md`

### When building a project
→ Load `skills/build/SKILL.md`

### Rules for orchestration behavior
→ Read `.agent-team/rules/index.md`

---

## Team Roles

All role definitions live in `.agent-team/teams/`. Each subfolder contains a `ROLE.md` — the system prompt for that agent.

| Role | Folder | Purpose |
|------|--------|---------|
| Project Manager | `project-manager/` | Scope ideas → sequenced JSON tickets |
| System Architect | `system-architect/` | Hexagonal architecture decisions |
| Devil's Advocate | `devils-advocate/` | Risk analysis and fatal flaw detection |
| UI/UX Designer | `uiux-designer/` | Wireframes, design tokens, a11y |
| Backend Engineer | `backend-engineer/` | Domain logic, ports and adapters |
| Frontend Engineer | `frontend-engineer/` | UI views, state management |
| DevOps Engineer | `devops-engineer/` | Docker, CI/CD, Kubernetes |
| QA Architect | `qa-architect/` | Test plans, unit/integration/E2E |
| Code Reviewer | `code-reviewer/` | Architecture and quality audit |

---

## Knowledge Base

`knowledge/` contains architectural handbooks that all agents must follow:

| File | Covers |
|------|--------|
| `system.md` | Distributed systems, CQRS, Bounded Contexts |
| `backend.md` | Hexagonal Architecture, Ports and Adapters |
| `frontend.md` | Frontend architecture patterns |
| `api.md` | API design standards |
| `devops.md` | Infrastructure and deployment |
| `qa.md` | Testing strategy and pyramid |
| `uiux.md` | Design systems and accessibility |
| `agile.md` | Agile/ticket workflow |
| `engineering.md` | General engineering principles |

---

## Project Outputs

Generated projects land in `projects/[name]/`. Each contains:
- `intake.md` — the scoped execution plan

---

## Invocation

```bash
./run.sh consult "My project idea"          # New consultation
./run.sh consult projects/app/intake.md     # Refine existing plan
./run.sh build   projects/app/intake.md     # Execute the plan
```
