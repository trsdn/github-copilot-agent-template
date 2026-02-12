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
| Legacy project | `.claude/skills/<skill-name>/` | Backward compatibility |
| Legacy personal | `~/.claude/skills/<skill-name>/` | Backward compatibility |

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
| `name` | Yes | Unique identifier. Lowercase, hyphens for spaces, max 64 chars (e.g., `webapp-testing`) |
| `description` | Yes | What the skill does and when to use it. Be specific to help Copilot decide when to load. Max 1024 chars |

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
    ├── SKILL.md              # Main skill file
    ├── test-template.js      # Reusable test template
    ├── playwright.config.ts  # Example config
    └── examples/
        ├── login-test.js
        └── api-test.js
```

## Reference documentation

- [Agent Skills in VS Code](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Agent Skills standard](https://agentskills.io/)
- [Reference skills repository](https://github.com/anthropics/skills)
- [Awesome Copilot community collection](https://github.com/github/awesome-copilot)
