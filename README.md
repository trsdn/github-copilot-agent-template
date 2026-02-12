# My Project

> Created from the [GitHub Copilot Customization Blueprint](https://github.com/trsdn/github-copilot-agent)

## Getting Started

1. **Set up Git hooks** (enforces Conventional Commits):

```bash
./scripts/setup-hooks.sh
```

2. **Customize `.github/copilot-instructions.md`** with your project's coding standards, architecture, and conventions.

3. **Review and adapt** the included agents, prompts, and skills in `.github/`.

## Copilot Customizations

### Custom Agents

| Agent | Purpose |
|-------|---------|
| Copilot Customization Builder | Create and maintain Copilot agents, prompts, skills |

### Prompt Templates

Use these in Copilot Chat:

- `/copilot-new-agent` — scaffold a new custom agent
- `/copilot-new-prompt` — scaffold a new prompt template
- `/copilot-new-skill` — scaffold a new agent skill
- `/copilot-new-instructions` — scaffold scoped instructions
- `/copilot-check-compatibility` — diagnose feature issues
- `/copilot-audit-setup` — audit your repo setup

### Agent Skills

| Skill | Purpose |
|-------|---------|
| copilot-skill-builder | Meta-skill for creating new skills |
| copilot-compatibility-checker | Diagnose VS Code/Copilot issues |
| copilot-setup-audit | Audit repo customization setup |
| copilot-customization-selector | Choose the right customization type |

## Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `release.yml` | Push to `main` | Auto-create releases with changelog |
| `validate.yml` | Push/PR to `main` | Validate agent/prompt/skill files |
| `commit-lint.yml` | PR to `main` | Enforce Conventional Commits |

## Commit Convention

This project uses [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<optional scope>): <description>
```

Allowed types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

## License

[MIT](LICENSE)
