# Intake: task-manager-cli

## Consultant Overview

A minimal Task Manager CLI built in Go. Users interact via four terminal commands (`task add`, `task list`, `task done`, `task delete`). Persistence is handled by a local SQLite database — single compiled binary, no server, no runtime dependencies.

The backend-engineer owns the full implementation: domain logic, SQLite adapter, and cobra CLI commands. Architecture follows the Hexagonal (Ports and Adapters) pattern as defined in `knowledge/backend.md`.

**Stack:**
- Language: Go
- CLI framework: `cobra`
- Persistence: SQLite via `mattn/go-sqlite3`
- Tests: Go stdlib `testing` + `testify`

**MVP Commands:**
```
task add "Buy milk"     # create a task
task list               # list all tasks with status
task done <id>          # mark a task complete
task delete <id>        # remove a task
```

**Scope boundary:** MVP only. No auth, no sync, no tagging, no priorities, no due dates.

---

## Execution Plan

```json
{
  "tickets": [
    {
      "id": "T1",
      "agent": "system-architect",
      "task": "Design the architecture for the task-manager-cli Go project. WHAT: Produce (1) a domain model defining the Task entity and its fields (id, title, status, created_at), (2) the SQLite schema DDL, (3) hexagonal port interfaces in Go (TaskRepository port, TaskService port), and (4) the CLI command contract listing all four commands with their arguments and expected outputs. WHY: All downstream agents depend on these contracts — backend implements them, QA tests against them, reviewer audits them. CONSTRAINTS: Follow knowledge/backend.md (Hexagonal Architecture). No implementation code — interfaces and schemas only. Output must be written to projects/task-manager-cli/architecture.md.",
      "acceptance_criteria": [
        "Task entity fields are fully defined with Go types",
        "SQLite schema DDL is valid and covers the Task entity",
        "TaskRepository and TaskService port interfaces are defined in Go interface syntax",
        "All four CLI commands are specified with argument names, flag names, and sample output",
        "Output saved to projects/task-manager-cli/architecture.md"
      ]
    },
    {
      "id": "T2",
      "agent": "devils-advocate",
      "task": "Critique the architecture defined in projects/task-manager-cli/architecture.md. WHAT: Identify fatal flaws, scaling bottlenecks, and over-engineering risks in the proposed hexagonal design for a CLI tool. Specifically evaluate: (1) whether hexagonal architecture is justified for this scope, (2) SQLite concurrency risks for a CLI tool, (3) error handling gaps in the command contracts, (4) any missing edge cases in the domain model (e.g. duplicate task titles, empty input). WHY: Surface problems before the backend-engineer writes any code. CONSTRAINTS: Do not rewrite the architecture — only flag issues and recommend targeted fixes. Output must be written to projects/task-manager-cli/risk-review.md.",
      "acceptance_criteria": [
        "Each identified risk is rated: Critical / Medium / Low",
        "Each risk includes a specific recommended fix",
        "Output saved to projects/task-manager-cli/risk-review.md"
      ]
    },
    {
      "id": "T3",
      "agent": "uiux-designer",
      "task": "Design the CLI user experience for the task-manager-cli. WHAT: Produce (1) the exact output format for each command (tabular layout for `task list`, confirmation messages for `task add/done/delete`, error message copy for invalid IDs and empty input), (2) the help text for each command and the root `--help` output, (3) colour/styling conventions (e.g. green for done, red for errors) if using a terminal colour library, (4) exit code conventions (0 = success, non-zero = error). WHY: The backend-engineer must implement CLI output that matches this spec exactly — defining it upfront prevents rework. CONSTRAINTS: CLI-only, no TUI or interactive prompts. Follow knowledge/uiux.md accessibility principles adapted to terminal context. Output must be written to projects/task-manager-cli/cli-ux-spec.md.",
      "acceptance_criteria": [
        "Sample rendered output is shown for all four commands",
        "Error message copy is defined for: invalid ID, empty title, task not found",
        "Help text is defined for root command and each subcommand",
        "Exit code table is included",
        "Output saved to projects/task-manager-cli/cli-ux-spec.md"
      ]
    },
    {
      "id": "T4",
      "agent": "backend-engineer",
      "task": "Implement the full task-manager-cli Go application. WHAT: Build the complete working codebase including: (1) Go module setup (go.mod, go.sum), (2) domain layer — Task entity and TaskService implementing the port interfaces from architecture.md, (3) SQLite adapter implementing TaskRepository port (auto-create DB file at ~/.task-manager/tasks.db on first run), (4) cobra CLI layer wiring all four commands (add, list, done, delete) with output matching cli-ux-spec.md exactly, (5) graceful error handling with correct exit codes as per cli-ux-spec.md. WHY: This is the full deliverable — a single `task` binary the user can build and run. CONSTRAINTS: Follow architecture.md port interfaces exactly. Implement fixes flagged as Critical in risk-review.md. Follow knowledge/backend.md (Hexagonal Architecture, Ports and Adapters). All source files go in projects/task-manager-cli/src/.",
      "acceptance_criteria": [
        "`go build ./...` succeeds with no errors",
        "All four commands function correctly end-to-end against a real SQLite file",
        "`task add` returns exit 0 and prints confirmation",
        "`task list` renders a table with id, title, status columns",
        "`task done <id>` and `task delete <id>` return exit 0 on success, non-zero on invalid ID",
        "Port interfaces from architecture.md are respected — no bypassing the domain layer",
        "All source files saved under projects/task-manager-cli/src/"
      ]
    },
    {
      "id": "T5",
      "agent": "qa-architect",
      "task": "Write the test plan and test code for task-manager-cli. WHAT: Produce (1) a written test plan covering unit and integration test scope, (2) unit tests for the TaskService domain logic (use an in-memory/mock TaskRepository), (3) integration tests that spin up a real SQLite DB and exercise each CLI command end-to-end, (4) edge case tests: adding a task with an empty title, completing a non-existent ID, deleting an already-deleted task. WHY: Validates that the implementation matches the architecture contracts and handles failure paths correctly. CONSTRAINTS: Follow knowledge/qa.md testing pyramid. Tests must live alongside source in projects/task-manager-cli/src/ using Go's standard `_test.go` convention. `go test ./...` must pass.",
      "acceptance_criteria": [
        "Test plan document saved to projects/task-manager-cli/test-plan.md",
        "`go test ./...` passes with no failures",
        "Unit tests cover TaskService with a mock repository",
        "Integration tests cover all four CLI commands against a real SQLite DB",
        "Edge cases are covered: empty title, invalid ID, double-delete"
      ]
    },
    {
      "id": "T6",
      "agent": "code-reviewer",
      "task": "Audit the complete task-manager-cli codebase. WHAT: Review all files under projects/task-manager-cli/src/ and validate: (1) hexagonal port boundaries are respected — no direct SQLite calls from the domain layer, (2) error handling is complete and consistent with cli-ux-spec.md exit codes, (3) Go idioms are followed (proper error returns, no panic in library code, context usage), (4) no hardcoded paths beyond the ~/.task-manager/tasks.db convention, (5) test coverage is adequate per test-plan.md. WHY: Final quality gate before the project is considered complete. CONSTRAINTS: Follow knowledge/engineering.md standards. Output a structured report — do not modify source files. Save report to projects/task-manager-cli/review.md.",
      "acceptance_criteria": [
        "Each finding is categorised: Blocker / Warning / Suggestion",
        "Hexagonal boundary violations (if any) are flagged as Blockers",
        "Report includes a final verdict: PASS, PASS WITH WARNINGS, or FAIL",
        "Report saved to projects/task-manager-cli/review.md"
      ]
    }
  ]
}
```

---

## Required Team

| Agent | Ticket | Output |
|-------|--------|--------|
| system-architect | T1 | `architecture.md` |
| devils-advocate | T2 | `risk-review.md` |
| uiux-designer | T3 | `cli-ux-spec.md` |
| backend-engineer | T4 | `src/` (full Go codebase) |
| qa-architect | T5 | `test-plan.md` + `src/**_test.go` |
| code-reviewer | T6 | `review.md` |
