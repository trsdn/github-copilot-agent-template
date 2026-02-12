---
name: copilot-customization-selector
description: Help decide which GitHub Copilot customization to use (instructions, prompts, agents, or skills). Use this skill when users ask which customization type to create, want to understand the differences, or need guidance choosing between .instructions.md, .prompt.md, .agent.md, or SKILL.md files.
---

# Customization Selector

This skill helps you decide which GitHub Copilot customization option to use for your specific needs.

## When to use this skill

- User asks "what type of customization should I create?"
- User wants to understand differences between instructions, prompts, agents, and skills
- User needs to choose the right approach for a new customization
- User asks "should I use a prompt or an instruction file?"

## Quick Decision Flowchart

```
What do you want to achieve?
│
├─► Define coding standards/rules that apply automatically?
│   └─► Use CUSTOM INSTRUCTIONS (.instructions.md)
│
├─► Create a reusable task template (e.g., "generate tests")?
│   └─► Use PROMPT FILES (.prompt.md)
│
├─► Create a specialized AI persona with specific tools?
│   └─► Use CUSTOM AGENTS (.agent.md)
│
├─► Build portable capabilities with scripts/resources?
│   └─► Use AGENT SKILLS (SKILL.md)
│
└─► Connect external services or APIs?
    └─► Use MCP SERVERS (mcp.json)
```

## Decision Matrix

| Feature | Instructions | Prompt Files | Custom Agents | Agent Skills |
|---------|--------------|--------------|---------------|--------------|
| **File Extension** | `.instructions.md` | `.prompt.md` | `.agent.md` | `SKILL.md` |
| **Location** | `.github/instructions/` | `.github/prompts/` | `.github/agents/` | `.github/skills/<name>/` |
| **Triggers** | Auto (always or via glob) | Manual (`/name`) | Manual (switch agent) | Auto (when relevant) |
| **Can include scripts?** | ❌ No | ❌ No | ❌ No | ✅ Yes |
| **Can specify tools?** | ❌ No | ✅ Yes | ✅ Yes | ❌ No |
| **Can specify model?** | ❌ No | ✅ Yes | ✅ Yes | ❌ No |
| **Portable across tools?** | ❌ VS Code only | ❌ VS Code only | ❌ VS Code only | ✅ Open standard |
| **Status** | Stable | Stable | Stable (1.106+) | Preview (1.108+) |

## Detailed Guidance

### Use Custom Instructions when

**Perfect for:**

- Enforcing coding standards across all requests
- Setting language/framework conventions (e.g., "always use TypeScript strict mode")
- Defining commit message or PR description guidelines
- Applying rules to specific file types via `applyTo` glob patterns
- Sharing team coding practices in version control

**File types:**

| File | Location | Behavior |
|------|----------|----------|
| `copilot-instructions.md` | `.github/` | Applies to all requests |
| `*.instructions.md` | `.github/instructions/` | Conditional via `applyTo` |
| `AGENTS.md` | Root or subfolders | Multi-agent compatible |

**Example use cases:**

- "Always use functional React components"
- "Follow PEP 8 for Python files"
- "Include JSDoc comments for all public functions"
- "Use conventional commits format"

---

### Use Prompt Files when

**Perfect for:**

- Creating reusable workflows (e.g., `/create-react-form`, `/security-review`)
- Scaffolding components, API routes, or modules
- Generating tests with consistent patterns
- Running the same task repeatedly with variations
- Need to specify tools and agent for a specific task

**Key features:**

- Invoked with `/promptName` in chat
- Can specify `agent`, `tools`, and `model` in frontmatter
- Support variables like `${selection}`, `${file}`, `${input:name}`
- Can reference instruction files for consistent guidelines

**Example use cases:**

- `/create-component` - Generate a new React component with tests
- `/code-review` - Perform a security-focused code review
- `/api-route` - Scaffold a new API endpoint
- `/migration-plan` - Generate a database migration strategy

---

### Use Custom Agents when

**Perfect for:**

- Creating specialized AI personas (planner, reviewer, architect)
- Restricting available tools (e.g., read-only for planning)
- Defining sequential workflows with **handoffs**
- Different tasks need different tool configurations
- Using a specific model for certain tasks

**Key features:**

- Define `tools` list to control what the agent can do
- Use `handoffs` for guided multi-step workflows
- Specify `model` for optimal performance per task
- Set `infer: false` to prevent use as subagent

**Example agents:**

- **Planner** - Read-only tools, generates implementation plans
- **Reviewer** - Focus on security vulnerabilities and code quality
- **Architect** - Design patterns and system architecture decisions
- **Implementer** - Full editing capabilities for coding tasks

---

### Use Agent Skills when

**Perfect for:**

- Creating capabilities that work across VS Code, CLI, and coding agent
- Need to include scripts, examples, or resources
- Building specialized testing/debugging/deployment workflows
- Sharing capabilities with the community
- Want progressive loading (only loaded when relevant)

**Key features:**

- Open standard at [agentskills.io](https://agentskills.io/)
- Three-level loading: discovery → instructions → resources
- Can include scripts, templates, and example files
- Works across GitHub Copilot in VS Code, CLI, and coding agent

**Example skills:**

- `webapp-testing` - Testing workflows with test templates
- `github-actions-debug` - Debug CI/CD workflows with log analysis
- `api-documentation` - Generate OpenAPI specs with examples
- `database-migrations` - Migration scripts with rollback templates

---

## How They Work Together

```
┌─────────────────────────────────────────────────────────────┐
│                     CUSTOM AGENT                            │
│  (defines persona, tools, model)                            │
│    ├── Can reference: Custom Instructions                   │
│    └── Can be triggered by: Prompt Files (via agent field)  │
├─────────────────────────────────────────────────────────────┤
│                     PROMPT FILE                             │
│  (defines reusable task template)                           │
│    ├── Can specify: agent, tools, model                     │
│    └── Can reference: Instructions via Markdown links       │
├─────────────────────────────────────────────────────────────┤
│                  CUSTOM INSTRUCTIONS                        │
│  (always applied guidelines, foundation layer)              │
├─────────────────────────────────────────────────────────────┤
│                     AGENT SKILLS                            │
│  (portable capabilities, auto-loaded when relevant)         │
│    └── Works independently, loaded based on task context    │
└─────────────────────────────────────────────────────────────┘
```

## Recommended Folder Structure

```
.github/
├── copilot-instructions.md      # Global project instructions
├── instructions/
│   ├── python.instructions.md   # Python-specific (applyTo: **/*.py)
│   ├── typescript.instructions.md
│   └── security.instructions.md # Security guidelines
├── prompts/
│   ├── create-component.prompt.md
│   ├── code-review.prompt.md
│   └── generate-tests.prompt.md
├── agents/
│   ├── planner.agent.md         # Read-only planning agent
│   ├── reviewer.agent.md        # Code review agent
│   └── implementer.agent.md     # Full coding agent
└── skills/
    ├── webapp-testing/
    │   ├── SKILL.md
    │   └── test-template.js
    └── debugging/
        └── SKILL.md
```

## Common Combinations

### Planning → Implementation Workflow

1. **Agent**: `planner.agent.md` with read-only tools
2. **Handoff**: Button to switch to implementation agent
3. **Instructions**: Shared coding standards apply to both

### Consistent Test Generation

1. **Skill**: `webapp-testing` with test templates and utilities
2. **Prompt**: `/generate-tests` that references the skill patterns
3. **Instructions**: Test naming conventions and coverage requirements

### Security-First Development

1. **Instructions**: Security guidelines applied globally
2. **Agent**: `security-reviewer.agent.md` for dedicated reviews
3. **Prompt**: `/security-audit` for on-demand security checks

## Version Requirements

| Feature | Minimum VS Code Version | Setting |
|---------|-------------------------|---------|
| `copilot-instructions.md` | 1.95 | `github.copilot.chat.codeGeneration.useInstructionFiles` |
| `*.instructions.md` | 1.99 | Auto-discovered |
| Prompt files | 1.99 | Auto-discovered |
| `AGENTS.md` | 1.102 | `chat.useAgentsMdFile` |
| Custom agents (`.agent.md`) | 1.106 | Auto-discovered |
| Nested `AGENTS.md` | 1.105 | `chat.useNestedAgentsMdFiles` (experimental) |
| Agent Skills | 1.108 | `chat.useAgentSkills` (preview) |

## References

- [Customization Overview](https://code.visualstudio.com/docs/copilot/customization/overview)
- [Custom Instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [Prompt Files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [Custom Agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [Agent Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Agent Skills Standard](https://agentskills.io/)
- [Community Examples](https://github.com/github/awesome-copilot)
