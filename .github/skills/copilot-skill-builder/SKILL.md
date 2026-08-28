---
name: copilot-skill-builder
description: Create and maintain Agent Skills for VS Code and GitHub Copilot. Use this skill when setting up new skills, skill directories, or SKILL.md files. Helps scaffold project skills in .github/skills/ or personal skills in ~/.copilot/skills/.
---

# Skill Builder

This skill helps you create, organize, and maintain Agent Skills for GitHub Copilot and compatible AI agents.

## What are Agent Skills?

Agent Skills are folders containing a `SKILL.md` file plus optional scripts, examples, and resources. They teach specialized capabilities and workflows to AI agents. Skills are:

- **Portable**: Work across VS Code, Copilot CLI, and Copilot coding agent
- **Composable**: Multiple skills can work together
- **Efficient**: Loaded on-demand based on relevance to the current task
- **Open standard**: Based on [agentskills.io](https://agentskills.io/)

## Skill locations

| Type | Location | Use case |
|------|----------|----------|
| Project skills | `.github/skills/<skill-name>/` | Shared with the repository |
| Personal skills | `~/.copilot/skills/<skill-name>/` | Private to your machine |

## SKILL.md file format

Every skill requires a `SKILL.md` file with YAML frontmatter:

```markdown
---
name: skill-name
description: Description of what the skill does and when to use it (max 1024 chars)
---

# Skill Instructions

Detailed instructions, guidelines, and examples...
```

### Frontmatter fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | Yes | Unique identifier. Lowercase, hyphens for spaces, max 64 chars. Must match parent directory name |
| `description` | Yes | What the skill does and when to use it. Be specific to help Copilot decide when to load. Max 1024 chars |
| `argument-hint` | No | Hint text shown in chat input when invoked as a slash command |
| `user-invocable` | No | Controls `/` slash command visibility (default: `true`). Set to `false` for background skills |
| `disable-model-invocation` | No | Controls auto-loading by Copilot (default: `false`). Set to `true` for manual-only skills |
| `license` | No | License name or reference to a bundled license file (from [agentskills.io](https://agentskills.io/) spec) |
| `compatibility` | No | Environment requirements — intended product, system packages, network access. Max 500 chars |
| `metadata` | No | Arbitrary key-value mapping for additional metadata (e.g., `author`, `version`) |
| `allowed-tools` | No | Space-delimited list of pre-approved tools the skill may use (experimental) |

### Body content

The skill body should include:

1. **Purpose**: What the skill accomplishes
2. **When to use**: Specific triggers and use cases
3. **Step-by-step procedures**: Clear instructions to follow
4. **Examples**: Expected inputs and outputs
5. **Resource references**: Links to included scripts/files using relative paths

## Creating a new skill

### Step 1: Create the skill directory

```bash
mkdir -p .github/skills/<skill-name>
```

### Step 2: Create SKILL.md

Create `.github/skills/<skill-name>/SKILL.md` with:

- YAML frontmatter with `name` and `description`
- Clear instructions in the Markdown body
- References to any additional resources

### Step 3: Add optional resources

Add any supporting files to the skill directory:

- Scripts (e.g., `test-template.js`, `deploy.sh`)
- Examples (e.g., `examples/basic.json`)
- Documentation (e.g., `README.md`, `troubleshooting.md`)

Reference these files using relative paths in your SKILL.md:

```markdown
Use the [test template](./test-template.js) as a starting point.
See [examples](./examples/) for common scenarios.
```

## Best practices

### Writing effective descriptions

The description determines when Copilot loads your skill. Be specific:

✅ Good: "Debug GitHub Actions workflows by analyzing logs, identifying common failures, and suggesting fixes"

❌ Bad: "Help with GitHub Actions"

### Keeping skills focused

- One skill = one capability or workflow
- Avoid kitchen-sink skills that try to do everything
- Compose multiple focused skills for complex workflows

### Managing skill size

- Skills load progressively (metadata → instructions → resources)
- Keep `SKILL.md` focused on instructions
- Put detailed documentation in separate files

### Security considerations

- Review shared skills before using them
- Be cautious with skills that run shell commands
- Use VS Code's terminal tool controls for script execution

## Example skill structure

```
.github/skills/
└── webapp-testing/
    ├── SKILL.md              # Main skill file (required)
    ├── scripts/              # Executable code agents can run
    │   └── test-template.js
    ├── references/           # Additional documentation
    │   └── REFERENCE.md
    ├── assets/               # Static resources (templates, schemas)
    │   └── config-template.json
    └── examples/
        ├── login-test.js
        └── api-test.js
```

### Recommended directories (from agentskills.io spec)

| Directory | Purpose |
|-----------|---------|
| `scripts/` | Executable code (Python, Bash, JavaScript). Should be self-contained with helpful error messages |
| `references/` | Additional documentation loaded on demand (keep files focused for efficient context use) |
| `assets/` | Static resources: templates, images, data files, schemas |

### Progressive disclosure guidelines

Skills load progressively to minimize context usage:

1. **Metadata** (~100 tokens): `name` and `description` loaded at startup for all skills
2. **Instructions** (< 5000 tokens recommended): Full SKILL.md body loaded when activated
3. **Resources** (as needed): Files in `scripts/`, `references/`, `assets/` loaded only when required

Keep your main SKILL.md under **500 lines**. Move detailed reference material to separate files.

## Reference documentation

- [Agent Skills in VS Code](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Agent Skills standard](https://agentskills.io/)
- [Reference skills repository](https://github.com/anthropics/skills)
- [Awesome Copilot community collection](https://github.com/github/awesome-copilot)
