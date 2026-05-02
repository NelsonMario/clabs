# Merge Workflow

## Trigger

Apply this rule whenever integrating agent branches back into `main` or another integration branch.

## Controller-Side Synchronization

- ALL rebase and merge operations MUST happen from the controller (orchestrator) side — never from within a worker/agent session.
- Before merging an agent branch, rebase it against `main` from the controller.
- Escalate immediately if merge conflicts arise — do not auto-resolve without review.

## Pre-Merge Safety Check

Before integrating an agent branch:

1. Review `git diff main...[branch]` to confirm deliverables are in tracked paths under `projects/`.
2. Confirm no generated metadata files (e.g. `.claude/`, `.agent-team/`) were committed from agent worktrees.
3. Verify the commit history references the correct ticket IDs.

## Core Principle

Agents produce commits; the controller integrates them. Keep the agent side free of merge and rebase operations to prevent history divergence.
