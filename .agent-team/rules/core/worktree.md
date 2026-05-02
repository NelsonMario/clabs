# Worktree and Branch Safety

## Trigger

Apply this rule for any git command, branch action, file placement decision, or task work by an agent.

## Branch Safety

- Agents MUST work only on their assigned branch (e.g. `agent/[role]-[ticket-id]`).
- NEVER run `git checkout`, `git switch`, `git merge`, or `git rebase` from within an agent worktree.
- All task commits MUST stay on the current agent branch.

## File Placement

- MUST keep deliverables in tracked repository paths under `projects/[name]/`.
- MUST NOT place outputs in ignored or temporary locations.

## Staging and Commit Scope

- MUST inspect `git status` before staging any changes.
- MUST stage only files required for the assigned ticket.
- NEVER use blanket staging (`git add .` or `git add -A`) that may capture unrelated work.
- Commit messages MUST reference the ticket ID they implement.
