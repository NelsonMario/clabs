#!/bin/bash

# ==============================================================================
# CLABS - Automated Agent Team Runner

usage() {
  echo "Usage: ./run.sh <command> <input>"
  echo ""
  echo "Commands:"
  echo "  consult \"Your Idea\"           - Scopes a project and generates intake.md"
  echo "  consult projects/app/intake.md  - Refines or reformats an existing plan"
  echo "  build   projects/app/intake.md  - Orchestrates team to execute the plan"
  echo ""
  echo "Examples:"
  echo "  ./run.sh consult \"A Go-based note taking CLI\""
  echo "  ./run.sh build projects/go-notes/intake.md"
  exit 1
}

if [ "$#" -lt 2 ]; then
  usage
fi

COMMAND=$1
INPUT=$2

# Auto-detect if input is a file or a task string
if [ -f "$INPUT" ]; then
  FILE_PATH="$INPUT"
  INTAKE_CONTENT=$(cat "$FILE_PATH")
else
  TASK_TEXT="$INPUT"
fi

# Check if claude CLI actually exists
if ! command -v claude &> /dev/null; then
  echo "Warning: 'claude' command not found. Outputting the final prompt to stdout instead."
  RUN_MODE="echo"
else
  RUN_MODE="exec"
fi

export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1

# Build knowledge manifest from all files in knowledge/
KNOWLEDGE_MANIFEST="The following architectural knowledge files are available in this repository:\n\n"
for k in knowledge/*.md; do
  KNOWLEDGE_MANIFEST="${KNOWLEDGE_MANIFEST}- $k\n"
done

# Select skill template
if [ "$COMMAND" = "consult" ]; then
  if [ -n "$INTAKE_CONTENT" ]; then
    TEMPLATE_FILE="skills/consult-refine/SKILL.md"
  else
    TEMPLATE_FILE="skills/consult-new/SKILL.md"
  fi
elif [ "$COMMAND" = "build" ]; then
  if [ -z "$INTAKE_CONTENT" ]; then
    echo "Error: build requires an existing intake.md file as input."
    usage
  fi
  TEMPLATE_FILE="skills/build/SKILL.md"
else
  echo "Unknown command: $COMMAND"
  usage
fi

if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Error: Skill template not found at $TEMPLATE_FILE"
  exit 1
fi

PROMPT=$(cat "$TEMPLATE_FILE")

# Generate final prompt by replacing placeholders
FINAL_PROMPT="${PROMPT//\{\{KNOWLEDGE\}\}/"$KNOWLEDGE_MANIFEST"}"
FINAL_PROMPT="${FINAL_PROMPT//\{\{TASK\}\}/"$TASK_TEXT"}"
FINAL_PROMPT="${FINAL_PROMPT//\{\{INTAKE\}\}/"$INTAKE_CONTENT"}"

if [ "$RUN_MODE" = "exec" ]; then
  echo "Starting CLABS $COMMAND mode..."
  CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 claude --dangerously-skip-permissions "$FINAL_PROMPT"
else
  echo "==================== FINAL PROMPT FOR $COMMAND ===================="
  echo -e "$FINAL_PROMPT"
  echo "======================================================================"
fi
