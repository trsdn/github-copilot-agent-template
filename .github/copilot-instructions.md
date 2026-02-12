# Copilot Instructions

These instructions are automatically applied to every Copilot Chat session in this workspace.

## Project Context

<!-- TODO: Replace this section with your project's context -->
<!-- Describe what your project does, its architecture, and key technologies -->

This project uses the [Copilot Customization Starter](https://github.com/trsdn/github-copilot-agent-template)
for pre-configured agents, prompts, skills, and CI workflows.

## Conventions

- All Copilot customization files live under `.github/` (agents, prompts, skills, instructions)
- Use **Conventional Commits** for all commit messages: `<type>(<scope>): <description>`
- Allowed types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- Agent files: `.agent.md` with YAML frontmatter (`name`, `description`, `tools` required)
- Prompt files: `.prompt.md` with YAML frontmatter (`name`, `description` required)
- Skill files: `SKILL.md` in a named directory under `.github/skills/<name>/`
- Use `user-invokable` and `disable-model-invocation` instead of the deprecated `infer` field

## File Structure

<!-- TODO: Update this to match your project's actual structure -->

```
.github/
├── agents/           # Custom agent profiles (.agent.md)
├── prompts/          # Prompt templates (.prompt.md)
├── skills/           # Agent Skills (each in its own directory with SKILL.md)
├── workflows/        # GitHub Actions (release, validate, commit-lint)
└── copilot-instructions.md  # This file
```

## Code Style

<!-- TODO: Add your project's code style rules here -->

- Markdown: ATX-style headings, fenced code blocks with language identifiers
- YAML frontmatter: quote strings that contain special characters
- Shell scripts: use `set -e`, add color output, include usage help
- Keep lines under 120 characters where practical
