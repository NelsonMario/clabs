<!--
  SKILL: consult-refine
  TRIGGER: ./run.sh consult projects/app/intake.md
  INPUT: {{INTAKE}} — contents of an existing intake.md
  OUTPUT: Updates projects/[name]/intake.md with a refined execution plan
  AGENT: .agent-team/teams/project-manager/ROLE.md
-->

I have an existing project plan:

{{INTAKE}}

I want you to act as a Project Manager or Consultant based on the rules in `.agent-team/teams/project-manager/ROLE.md`. Use the information above as the baseline.

Here is my domain knowledge to factor in:
{{KNOWLEDGE}}

1. Please converse with me to refine or reformat this plan.
2. Once I confirm that the plan is good, automatically generate the updated Execution Plan and save it to the project's `intake.md`.
3. Finally, tell me to review the document and run the 'build' command when I am completely satisfied. Do NOT write any application code yet.
