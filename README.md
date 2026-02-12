# GitHub Copilot Starter Template

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A ready-to-use project template with **pre-configured GitHub Copilot customizations**, CI workflows, and development conventions. Click **"Use this template"** on GitHub and start building — Copilot already knows your project's rules.

> Based on the [GitHub Copilot Customization Blueprint](https://github.com/trsdn/github-copilot-agent)

---

## What You Get

| Category | What's Included |
|----------|----------------|
| **Custom Agent** | Copilot Customization Builder — creates and maintains agents, prompts, skills, and instructions using Copilot itself |
| **6 Prompt Templates** | `/copilot-new-agent`, `/copilot-new-prompt`, `/copilot-new-skill`, `/copilot-new-instructions`, `/copilot-check-compatibility`, `/copilot-audit-setup` |
| **4 Agent Skills** | Skill builder, compatibility checker, setup auditor, customization selector |
| **3 CI Workflows** | Auto-releases with changelog, file validation, conventional commit enforcement |
| **Git Hooks** | Local commit message linting via `.githooks/commit-msg` |
| **VS Code Settings** | Copilot-optimized workspace configuration |
| **Copilot Instructions** | Workspace-wide coding standards in `.github/copilot-instructions.md` |

---

## Getting Started

### 1. Create Your Repository

Click **"Use this template"** → **"Create a new repository"** on GitHub, then clone it:

```bash
git clone https://github.com/YOUR-USERNAME/your-new-repo.git
cd your-new-repo
```

### 2. Set Up Git Hooks

This enables local [Conventional Commits](https://www.conventionalcommits.org/) enforcement:

```bash
./scripts/setup-hooks.sh
```

### 3. Customize Copilot Instructions

Edit [.github/copilot-instructions.md](.github/copilot-instructions.md) to reflect your project:

- **Project context** — what your app does, its architecture, key technologies
- **Coding conventions** — naming, formatting, patterns your team follows
- **File structure** — where things live in your repo

These instructions are automatically included in every Copilot Chat session.

### 4. Start Using Copilot Customizations

Open the project in **VS Code**, open **Copilot Chat**, and try:

- Select the **Copilot Customization Builder** agent to create new customizations
- Type `/copilot-new-agent` to scaffold a domain-specific agent for your project
- Type `/copilot-new-prompt` to create a reusable prompt template
- Type `/copilot-audit-setup` to review your current configuration

### 5. Clean Up This README

Replace this README with your own project documentation. Keep the commit convention section if you want contributors to follow it.

---

## File Structure

```
.github/
├── agents/           # Custom Copilot agent profiles (.agent.md)
├── prompts/          # Reusable prompt templates (.prompt.md)
├── skills/           # Agent skills with specialized knowledge (SKILL.md)
├── workflows/        # CI/CD (release, validate, commit-lint)
└── copilot-instructions.md  # Always-on Copilot instructions
.githooks/
└── commit-msg        # Local conventional commit enforcement
.vscode/
└── settings.json     # Copilot workspace settings
scripts/
└── setup-hooks.sh    # Git hooks installer
```

## Workflows

| Workflow | Trigger | What It Does |
|----------|---------|--------------|
| `release.yml` | Push to `main` | Bumps version based on commit types, creates GitHub release with changelog |
| `validate.yml` | Push / PR to `main` | Validates agent, prompt, and skill file structure |
| `commit-lint.yml` | PR to `main` | Rejects PRs with non-conventional commit messages or titles |

## Commit Convention

All commits must follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<optional scope>): <description>
```

| Type | Version Bump | Example |
|------|-------------|---------|
| `feat` | Minor | `feat(auth): add OAuth2 login` |
| `fix` | Patch | `fix(api): handle null response` |
| `feat!` / `fix!` | **Major** | `feat!: redesign config format` |
| `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert` | — | No release triggered |

Enforced locally via git hook and in CI via `commit-lint.yml`.

---

## Learn More

- [Blueprint Repository](https://github.com/trsdn/github-copilot-agent) — the source of this template, with full documentation and contribution guidelines
- [VS Code Copilot Customization Docs](https://code.visualstudio.com/docs/copilot/copilot-customization)
- [Conventional Commits Specification](https://www.conventionalcommits.org/)

## License

[MIT](LICENSE)
