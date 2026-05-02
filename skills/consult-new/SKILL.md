<!--
  SKILL: consult-new
  TRIGGER: ./run.sh consult "Your idea here"
  INPUT: {{TASK}} — the user's raw idea or requirement
  OUTPUT: Creates projects/[name]/intake.md with a scoped execution plan
  AGENT: .agent-team/teams/project-manager/ROLE.md
-->

I have an idea that I want you to help me scope. My idea is: '{{TASK}}'

I want you to act as a Project Manager based on the rules in `.agent-team/teams/project-manager/ROLE.md`.

Here is my domain knowledge to factor in:
{{KNOWLEDGE}}

1. Please converse with me to clarify this idea.
2. Once I confirm that the plan is good, automatically generate the Execution Plan and use your native file tools to create the directory `projects/[project_name]/`.
3. Save the complete plan into `projects/[project_name]/intake.md`.
4. Finally, tell me to review the document and run the 'build' command when I am completely satisfied. Do NOT write any application code yet.
