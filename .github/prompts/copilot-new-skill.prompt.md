---
description: Scaffold a new Agent Skill (SKILL.md) for VS Code and GitHub Copilot
name: New Skill
agent: Copilot Customization Builder
tools: ['search', 'edit/editFiles']
---

# New Agent Skill

Create a new Agent Skill in this repository.

## Inputs

- Skill directory name (lowercase, hyphens for spaces): `${input:skillName}`
- Skill description (what it does and when to use it): `${input:skillDescription}`
- Skill location (`project` for `.github/skills/` or `personal` for `~/.copilot/skills/`): `${input:skillLocation}`

## Requirements

1. Inspect existing skills in `.github/skills/` (if any) and match conventions.
2. Create the skill directory and SKILL.md file:
   - For project skills: `.github/skills/${input:skillName}/SKILL.md`
   - For personal skills: `~/.copilot/skills/${input:skillName}/SKILL.md`
3. In YAML frontmatter:
   - Set `name` to `${input:skillName}` (lowercase, hyphens, max 64 chars)
   - Set `description` to `${input:skillDescription}` (max 1024 chars, be specific about capabilities and use cases)
4. In the Markdown body, include:
   - What the skill accomplishes
   - When to use it (specific triggers)
   - Step-by-step procedures
   - Examples of expected input/output
   - References to any included scripts or resources (use relative paths)
5. If the skill requires supporting files (scripts, templates, examples), create them in the skill directory and reference them with relative paths like `[script](./script.js)`.

## Skill best practices

- **Specific descriptions**: Help Copilot decide when to load the skill
- **Focused scope**: One skill = one capability or workflow
- **Progressive disclosure**: Keep SKILL.md focused; put details in separate files
- **Security**: Be cautious with shell commands and review shared skills

When done, explain:
- The created file path(s)
- How Copilot will automatically discover and use the skill
- Any follow-up suggestions (additional resources, related skills)

## Reference docs

- Agent Skills (VS Code): https://code.visualstudio.com/docs/copilot/customization/agent-skills
- Agent Skills standard: https://agentskills.io/
- Reference skills: https://github.com/anthropics/skills
- Awesome Copilot: https://github.com/github/awesome-copilot

