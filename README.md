# CLABS — Claude Agent Team Framework

CLABS is a structured framework for orchestrating a team of specialized AI agents to plan and build software using **Claude Code Agent Teams**. It enforces Hexagonal Architecture and clean engineering practices across every phase.

---

## Folder Structure

```
clabs/
├── CLAUDE.md                          # Agent orientation — read this first
├── run.sh                             # CLI entry point
│
├── .agent-team/                       # Team definitions and orchestration rules
│   ├── rules/
│   │   └── index.md                   # Orchestration rules (sequencing, phases)
│   └── teams/                         # One folder per agent role
│       ├── project-manager/ROLE.md
│       ├── system-architect/ROLE.md
│       ├── devils-advocate/ROLE.md
│       ├── uiux-designer/ROLE.md
│       ├── backend-engineer/ROLE.md
│       ├── frontend-engineer/ROLE.md
│       ├── devops-engineer/ROLE.md
│       ├── qa-architect/ROLE.md
│       └── code-reviewer/ROLE.md
│
├── knowledge/                         # Architectural handbooks enforced by all agents
│   ├── system.md
│   ├── backend.md
│   ├── frontend.md
│   ├── api.md
│   ├── devops.md
│   ├── qa.md
│   ├── uiux.md
│   ├── agile.md
│   └── engineering.md
│
├── skills/                            # Prompt templates for each run mode
│   ├── consult-new/SKILL.md           # Start a new consultation
│   ├── consult-refine/SKILL.md        # Refine an existing plan
│   └── build/SKILL.md                 # Orchestrate the full agent team
│
├── templates/
│   └── intake.md                      # Intake form template
│
└── projects/                          # Auto-generated per project (git-ignored)
    └── [project-name]/
        └── intake.md
```

---

## Agent Team

| Role | File | Purpose |
|------|------|---------|
| Project Manager | `.agent-team/teams/project-manager/ROLE.md` | Scope ideas into sequenced JSON tickets |
| System Architect | `.agent-team/teams/system-architect/ROLE.md` | Hexagonal architecture decisions |
| Devil's Advocate | `.agent-team/teams/devils-advocate/ROLE.md` | Risk and fatal flaw analysis |
| UI/UX Designer | `.agent-team/teams/uiux-designer/ROLE.md` | Wireframes, design tokens, a11y |
| Backend Engineer | `.agent-team/teams/backend-engineer/ROLE.md` | Domain logic, ports and adapters |
| Frontend Engineer | `.agent-team/teams/frontend-engineer/ROLE.md` | UI views and state management |
| DevOps Engineer | `.agent-team/teams/devops-engineer/ROLE.md` | Docker, CI/CD, Kubernetes |
| QA Architect | `.agent-team/teams/qa-architect/ROLE.md` | Test plans, unit/integration/E2E |
| Code Reviewer | `.agent-team/teams/code-reviewer/ROLE.md` | Architecture and quality audit |

---

## How to Run

The framework operates in two strict phases: **Consultation** then **Build**.

### Phase 1: Consult (Plan)

Scope a new idea into an execution plan. The PM agent will clarify scope and create `projects/[name]/intake.md`. **No application code is written in this phase.**

```bash
# Start a new consultation
./run.sh consult "I want to build a simple habit tracking SaaS app"

# Refine an existing plan
./run.sh consult projects/habit-app/intake.md
```

### Phase 2: Build (Execute)

Once you are satisfied with the `intake.md`, unleash the engineering team.

```bash
./run.sh build projects/habit-app/intake.md
```

The Lead Orchestrator spawns all required agents in parallel based on the JSON tickets in `intake.md` and aggregates their output into `projects/[name]/`.

---

## What are Skills?

`skills/` contains **prompt templates** — one per run mode. Each `SKILL.md` is the instruction that gets injected into Claude when you run a command. The header comment in each file describes:

- **TRIGGER** — which `run.sh` command loads it
- **INPUT** — what placeholders it expects (`{{TASK}}`, `{{INTAKE}}`, `{{KNOWLEDGE}}`)
- **OUTPUT** — what it produces
- **AGENT/TEAM** — which role(s) it activates

`run.sh` reads the correct `SKILL.md`, substitutes placeholders, and passes the final prompt to `claude`.

---

## Customization

| What to change | Where |
|----------------|-------|
| Agent persona rules | `.agent-team/teams/[role]/ROLE.md` |
| Architectural constraints | `knowledge/*.md` |
| Orchestration behavior | `skills/build/SKILL.md` |
| Consultation flow | `skills/consult-new/SKILL.md` or `skills/consult-refine/SKILL.md` |
| Team sequencing rules | `.agent-team/rules/index.md` |
