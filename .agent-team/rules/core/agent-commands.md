# Agent Commands

## Trigger

Apply this rule when an agent session requires invoking CLABS workflow operations.

## Command Boundary

Agents MUST use the canonical CLABS entry points:

```bash
./run.sh consult "idea"                    # New consultation
./run.sh consult projects/[name]/intake.md # Refine existing plan
./run.sh build   projects/[name]/intake.md # Execute the plan
```

Agents MUST NOT:
- Bypass `run.sh` to invoke internal scripts directly.
- Modify `.agent-team/teams/*/ROLE.md` role files during a build run.
- Commit changes to `CLAUDE.md`, `.agent-team/`, or `knowledge/` as part of a project deliverable.

## Generated File Safety

The following are controller-managed resources and MUST NOT be committed from agent worktrees:

- `CLAUDE.md`
- `.agent-team/`
- `knowledge/`
- Any `run.sh` or harness scripts

Deliverables belong exclusively under `projects/[name]/`.
