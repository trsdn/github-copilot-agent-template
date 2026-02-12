# Copilot Customization Starter

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Copilot that knows how to customize itself.**

This template gives every new project a set of **Agent Skills** that teach GitHub Copilot the exact conventions, file formats, and best practices for building its own customization layer — agents, prompts, instructions, and skills. Instead of looking up docs every time, you just ask Copilot to create what you need and it already knows how.

> Click **"Use this template"** on GitHub, clone your new repo, and start customizing.

---

## How It Works

The template ships four Agent Skills. Each one encodes deep domain knowledge that Copilot loads automatically when it's relevant:

| Skill | What It Knows |
|-------|---------------|
| **Customization Selector** | Which customization type to use for a given goal — instructions vs. prompts vs. agents vs. skills. Decision flowcharts, comparison matrices, example combinations. |
| **Skill Builder** | How to create Agent Skills: `SKILL.md` format, frontmatter fields, directory structure, file referencing, best practices for descriptions and scope. |
| **Compatibility Checker** | Every VS Code version requirement and experimental setting for Copilot features. Full feature matrix from v1.95 to current. Diagnostic steps for "it's not working" issues. |
| **Setup Auditor** | Complete audit checklists for agents, prompts, instructions, skills, and settings. Knows what a well-configured repo looks like and what's missing. |

On top of that, there's a **custom agent** (Copilot Customization Builder) and **six prompt templates** that use these skills to scaffold new customizations with a single command.

### The Flow

```
You type: /copilot-new-agent
                │
                ▼
    Prompt template triggers the
    Copilot Customization Builder agent
                │
                ▼
    Agent draws on skills for conventions
    (file format, frontmatter, placement, best practices)
                │
                ▼
    Copilot creates a correct .agent.md file
    in the right location with proper structure
```

This works for agents, prompts, instructions, and skills — each prompt template follows the same pattern.

---

## Getting Started

### 1. Create Your Repository

Click **"Use this template"** → **"Create a new repository"** on GitHub.

```bash
git clone https://github.com/YOUR-USERNAME/your-new-repo.git
cd your-new-repo
./scripts/setup-hooks.sh   # enables conventional commit enforcement
```

### 2. Tell Copilot About Your Project

Edit [.github/copilot-instructions.md](.github/copilot-instructions.md) — this is the first thing to customize. Replace the placeholder content with:

- What your project does and how it's structured
- Your coding conventions (naming, formatting, patterns)
- Your tech stack and architecture decisions

These instructions are included in **every** Copilot Chat session automatically.

### 3. Build Your Customization Layer

Open VS Code, open Copilot Chat, and start creating customizations for your project:

| Command | What It Creates |
|---------|----------------|
| `/copilot-new-agent` | A specialized agent (e.g., a code reviewer, planner, or debugger for your project) |
| `/copilot-new-prompt` | A reusable prompt template (e.g., `/generate-tests`, `/create-component`) |
| `/copilot-new-instructions` | Scoped instructions for specific file types (e.g., Python style rules for `**/*.py`) |
| `/copilot-new-skill` | A new Agent Skill with domain knowledge for your project |
| `/copilot-audit-setup` | Audit your current setup and get recommendations |
| `/copilot-check-compatibility` | Diagnose why a feature isn't working |

Or select the **Copilot Customization Builder** agent directly and describe what you need in natural language.

### 4. Make It Yours

Once you've built your project-specific customizations, replace this README with your own project documentation.

---

## What's Included

### Skills (the knowledge layer)

```
.github/skills/
├── copilot-customization-selector/   # Which customization type to use
├── copilot-skill-builder/            # How to create skills
├── copilot-compatibility-checker/    # Version/setting requirements
└── copilot-setup-audit/              # Audit checklists and best practices
```

These are automatically discovered by Copilot when relevant. You don't need to reference them manually.

### Agent + Prompts (the action layer)

```
.github/agents/
└── copilot-customization-builder.agent.md   # The builder agent

.github/prompts/
├── copilot-new-agent.prompt.md              # /copilot-new-agent
├── copilot-new-prompt.prompt.md             # /copilot-new-prompt
├── copilot-new-skill.prompt.md              # /copilot-new-skill
├── copilot-new-instructions.prompt.md       # /copilot-new-instructions
├── copilot-audit-setup.prompt.md            # /copilot-audit-setup
└── copilot-check-compatibility.prompt.md    # /copilot-check-compatibility
```

### Instructions (the context layer)

```
.github/
└── copilot-instructions.md   # Workspace-wide — edit this for your project
```

### CI + Conventions

```
.github/workflows/
├── release.yml       # Auto-release with changelog on push to main
├── validate.yml      # Validate customization file structure
└── commit-lint.yml   # Enforce conventional commits on PRs

.githooks/
└── commit-msg        # Local commit message linting

.vscode/
└── settings.json     # Copilot-optimized workspace settings
```

All commits follow [Conventional Commits](https://www.conventionalcommits.org/): `feat:` triggers a minor release, `fix:` a patch, `feat!:` a major. Enforced locally via git hook and in CI.

---

## Why This Exists

GitHub Copilot supports a rich customization system — custom agents, prompt templates, scoped instructions, Agent Skills, MCP servers — but the conventions for building these correctly are spread across documentation pages, release notes, and experimental settings that change with each VS Code version.

This template captures all of that knowledge in Agent Skills so that Copilot itself can apply it. You get the customization system working correctly from day one without memorizing file formats or hunting through docs.

---

## Learn More

- [Blueprint Repository](https://github.com/trsdn/github-copilot-agent) — source of this template, with full docs and contribution guidelines
- [VS Code Copilot Customization](https://code.visualstudio.com/docs/copilot/customization/overview) — official documentation
- [Agent Skills Standard](https://agentskills.io/) — the open standard behind skills
- [Conventional Commits](https://www.conventionalcommits.org/) — commit message convention used here

## License

[MIT](LICENSE)
