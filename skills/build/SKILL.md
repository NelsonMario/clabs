<!--
  SKILL: build
  TRIGGER: ./run.sh build projects/app/intake.md
  INPUT: {{INTAKE}} — contents of a completed intake.md with JSON execution plan
  OUTPUT: Full project codebase in projects/[name]/
  TEAM: All roles in .agent-team/teams/
-->

1. I have a project plan. Create an optimal team called **clabs team** to build this project from different angles. Choose relevant personas from the `.agent-team/teams/` directory:
   - **System Architect** (`.agent-team/teams/system-architect/ROLE.md`) — define domain contracts, bounded contexts, and package structure
   - **Devil's Advocate** (`.agent-team/teams/devils-advocate/ROLE.md`) — critique and surface fatal flaws
   - **UI/UX Designer** (`.agent-team/teams/uiux-designer/ROLE.md`) — define user experience and design tokens
   - **Backend Engineer** (`.agent-team/teams/backend-engineer/ROLE.md`) — implement Hexagonal domain logic and adapters
   - **Frontend Engineer** (`.agent-team/teams/frontend-engineer/ROLE.md`) — implement UI views and state management
   - **DevOps Engineer** (`.agent-team/teams/devops-engineer/ROLE.md`) — write Dockerfile, Makefile, and CI/CD pipelines
   - **QA Architect** (`.agent-team/teams/qa-architect/ROLE.md`) — write unit, integration, and E2E tests
   - **Code Reviewer** (`.agent-team/teams/code-reviewer/ROLE.md`) — audit the final codebase for quality and purity

2. Explicitly spawn parallel teammates for each role and instruct them with their corresponding persona rules.

Here is the project plan:

{{INTAKE}}

I need you to act as the **CLABS Lead Orchestrator**.

Each teammate must read their rules from the `.agent-team/teams/` directory and the architectural boundaries from `knowledge/` before starting. Aggregate all output under `projects/[project_name]/`.

Here are the system architectural definitions you must enforce:
{{KNOWLEDGE}}

Assign the JSON tickets from the Execution Plan to your teammates to work on simultaneously, and aggregate their findings. Review their output to ensure it aligns perfectly with the knowledge base constraints.
