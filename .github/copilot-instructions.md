# Copilot Instructions

These instructions are automatically applied to every Copilot Chat session in this workspace.

## Project Context

This is a **GitHub Copilot Customization Blueprint** — a template repository for bootstrapping
Copilot agents, prompt files, instructions, skills, and hooks in any project.

## Conventions

- All customization files live under `.github/` (agents, prompts, skills, instructions, hooks)
- Use **Conventional Commits** for all commit messages: `<type>(<scope>): <description>`
- Allowed types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- Agent files: `.agent.md` with YAML frontmatter (`description` required, `name` and `tools` recommended)
- Prompt files: `.prompt.md` with YAML frontmatter (`description` recommended)
- Skill files: `SKILL.md` in a named directory under `.github/skills/<name>/` (alt locations: `.claude/skills/`, `.agents/skills/`)
- Hook configs: JSON files in `.github/hooks/` defining lifecycle automation
- MCP configs: `.vscode/mcp.json` for VS Code workspace MCP, `mcp-servers` in GitHub Copilot agent frontmatter, `.mcp.json` in plugins
- Agent plugin manifests: `plugin.json` in plugin roots; keep example manifests inert as `*.example.json`
- Tool sets group built-in, MCP, and extension tools; keep examples inert unless deliberately enabled via VS Code
- Use `user-invocable` and `disable-model-invocation` instead of the deprecated `infer` field
- For multi-agent workspaces, `AGENTS.md` (root or experimental nested) and `CLAUDE.md` are also recognized as always-on instructions
- For monorepos opened in a subfolder, enable `chat.useCustomizationsInParentRepositories` to discover customizations from the repo root

## File Structure

```
.github/
├── agents/           # Custom agent profiles (.agent.md)
├── prompts/          # Prompt templates (.prompt.md)
├── instructions/     # Scoped instruction files (*.instructions.md)
├── skills/           # Agent Skills (each in its own directory with SKILL.md)
├── hooks/            # Hook configuration files (*.json)
├── workflows/        # GitHub Actions (release, validate, commit-lint)
└── copilot-instructions.md  # This file
```

## Code Style

- Markdown: ATX-style headings, fenced code blocks with language identifiers
- YAML frontmatter: quote strings that contain special characters
- Shell scripts: use `set -e`, add color output, include usage help
- Keep lines under 120 characters where practical
