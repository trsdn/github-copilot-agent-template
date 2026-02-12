# Copilot Customization Starter

**Stop reading docs. Start asking Copilot.**

This template ships Agent Skills that teach Copilot how to build its own agents, prompts, instructions, and skills — correctly, every time. You describe what you need, and Copilot handles the file formats, frontmatter fields, directory conventions, and version-specific quirks.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

---

### What it looks like

```
You:  /copilot-new-agent
      → Name: code-reviewer
      → Description: Security-focused code review
      → Tools: search, usages, problems

Copilot creates:
      .github/agents/code-reviewer.agent.md
      ✓ Correct frontmatter (name, description, tools, user-invokable)
      ✓ Structured body (purpose, workflow, guardrails)
      ✓ Matches your repo's existing conventions
```

Same for prompts, instructions, and skills. Six slash commands, one builder agent, four skills full of conventions. That's the whole idea.

---

## Get Started

**One.** Click **"Use this template"** on GitHub and clone your repo.

```bash
git clone https://github.com/YOUR-USERNAME/your-new-repo.git
cd your-new-repo
./scripts/setup-hooks.sh
```

**Two.** Open [.github/copilot-instructions.md](.github/copilot-instructions.md) and replace the placeholders with your project — what it does, how it's structured, what conventions your team follows.

**Three.** Open Copilot Chat in VS Code. Type `/copilot-new-agent`. Build from there.

---

## What's Inside

**Four skills** that encode everything Copilot needs to know:

- **Customization Selector** — decision trees for choosing between instructions, prompts, agents, and skills
- **Skill Builder** — `SKILL.md` format, frontmatter, directory structure, best practices
- **Compatibility Checker** — VS Code version matrix, experimental settings, diagnostic steps
- **Setup Auditor** — full audit checklists, gap analysis, migration paths

**One agent** that uses them:

- **Copilot Customization Builder** — creates and maintains all customization types

**Six prompt templates** that trigger it:

| | |
|-|-|
| `/copilot-new-agent` | Scaffold a custom agent |
| `/copilot-new-prompt` | Scaffold a prompt template |
| `/copilot-new-skill` | Scaffold an agent skill |
| `/copilot-new-instructions` | Scaffold scoped instructions |
| `/copilot-audit-setup` | Audit your setup |
| `/copilot-check-compatibility` | Diagnose issues |

**CI and conventions** — auto-releases with changelog, file validation, and conventional commit enforcement (local hook + CI workflow).

---

## Why

Copilot's customization system is powerful — agents, prompts, instructions, skills, MCP — but building these correctly means juggling docs, release notes, experimental flags, and file format details that shift with every VS Code release.

This template puts all of that knowledge into Agent Skills so Copilot applies it for you. You get a correct setup from the start and a way to extend it without leaving the chat.

---

<sub>

Based on [trsdn/github-copilot-agent](https://github.com/trsdn/github-copilot-agent) · [VS Code Copilot Customization](https://code.visualstudio.com/docs/copilot/customization/overview) · [Agent Skills Standard](https://agentskills.io/) · [MIT License](LICENSE)

</sub>
