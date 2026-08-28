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
├─► Automate actions at agent lifecycle points?
│   └─► Use HOOKS (.github/hooks/*.json)
│
├─► Connect external services or APIs?
│   └─► Use MCP SERVERS (mcp.json)
│
└─► Install pre-packaged customizations?
    └─► Use AGENT PLUGINS (preview)
```

## Decision Matrix

| Feature | Instructions | Prompt Files | Custom Agents | Agent Skills | Hooks | MCP | Plugins | Tool Sets |
|---------|--------------|--------------|---------------|--------------|-------|-----|---------|-----------|
| **File Extension** | `.instructions.md` | `.prompt.md` | `.agent.md` | `SKILL.md` | `.json` | `.json` / YAML frontmatter | `plugin.json` | `.jsonc` |
| **Location** | `.github/instructions/` | `.github/prompts/` | `.github/agents/` | `.github/skills/<name>/` | `.github/hooks/` | `.vscode/mcp.json`, agent `mcp-servers`, plugin `.mcp.json` | plugin root | tool-set file via VS Code |
| **Triggers** | Auto (always or via glob) | Manual (`/name`) | Manual (switch agent) | Auto (when relevant) | Lifecycle events | Tool/resource/prompt invocation | Install/enable plugin | Tool selection or `#toolset` |
| **Can include scripts?** | No | No | No | Yes | Yes | Server-dependent | Yes | No |
| **Can specify tools?** | No | Yes | Yes | No | N/A | Provides tools | Bundles tools via agents/MCP | Groups tools |
| **Can specify model?** | No | Yes | Yes | No | N/A | No | Via bundled prompts/agents | No |
| **Portable across tools?** | VS Code/GitHub | VS Code | Partial | Open standard | Partial | MCP standard | Cross-tool (preview) | VS Code |
| **Status** | Stable | Stable | Stable (1.106+) | Stable | Preview | Stable/Preview features | Preview | Stable/Preview |

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
| `*.instructions.md` | `.github/instructions/` (or `.claude/rules/`, user profile) | Conditional via `applyTo` (`paths` for `.claude/rules`) |
| `AGENTS.md` | Root or subfolders | Multi-agent compatible (`chat.useAgentsMdFile`) |
| `CLAUDE.md` | Root, `.claude/`, or `~/.claude/` | Claude-compatible (`chat.useClaudeMdFile`) |

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
- Specify `model` for optimal performance per task (single string or prioritized array)
- Set `user-invocable: false` for subagent-only agents
- Set `disable-model-invocation: true` to prevent automatic invocation
- Define agent-scoped `hooks` for lifecycle automation (preview)
- Add `mcp-servers` for GitHub Copilot cloud agents when the agent needs private or task-specific external tools
- Use `tools` to limit built-in tools, tool aliases, MCP tools (`server/tool`), or full MCP servers (`server/*`)

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
- Recognized project locations: `.github/skills/`, `.claude/skills/`, `.agents/skills/`
- Recognized user locations: `~/.copilot/skills/`, `~/.claude/skills/`, `~/.agents/skills/`
- Customize via `chat.agentSkillsLocations`

**Example skills:**

- `webapp-testing` - Testing workflows with test templates
- `github-actions-debug` - Debug CI/CD workflows with log analysis
- `api-documentation` - Generate OpenAPI specs with examples
- `database-migrations` - Migration scripts with rollback templates

---

### Use Hooks when

**Perfect for:**

- Enforcing security policies (block dangerous commands before execution)
- Automating code quality (run formatters/linters after edits)
- Creating audit trails (log all tool invocations)
- Injecting project context into sessions
- Controlling tool approvals programmatically

**Key features:**

- Eight lifecycle events: `SessionStart`, `UserPromptSubmit`, `PreToolUse`, `PostToolUse`, `PreCompact`, `SubagentStart`, `SubagentStop`, `Stop`
- JSON-based configuration in `.github/hooks/*.json`
- Can also be scoped to individual agents via frontmatter
- Deterministic execution (runs regardless of prompt)
- Hooks can block, allow, or require approval for tool execution

**Example hooks:**

- Block `rm -rf` and `DROP TABLE` commands
- Auto-format with Prettier after every file edit
- Log every tool invocation for compliance
- Inject environment info at session start

---

### Use Agent Plugins when (Preview)

**Perfect for:**

- Installing pre-packaged customization bundles from marketplaces
- Sharing complete workflows (agents + skills + prompts + hooks) as a single package
- Discovering community-contributed customizations
- Extending Copilot without manual file management

**Key features:**

- Bundles of slash commands, skills, agents, hooks, and MCP servers
- Discoverable via plugin marketplaces
- Installed plugins appear alongside local customizations
- Can add private repositories as custom marketplaces
- Plugin MCP servers use top-level `mcpServers`
- Plugin hooks run alongside workspace and user hooks; for `PreToolUse`, the most restrictive decision wins
- Workspace recommendations can point teams to approved plugin marketplaces and enabled plugins

---

### Use MCP Servers when

**Perfect for:**

- Connecting agents to external APIs, databases, browsers, internal tools, or SaaS systems
- Exposing tools, resources, prompts, or MCP Apps to Copilot
- Reusing the same external tool integration across prompts, agents, and plugin bundles
- Giving GitHub Copilot cloud agents access to repository-approved external tools

**Key features:**

- VS Code workspace config uses `.vscode/mcp.json` with top-level `servers`
- GitHub Copilot custom agents use `mcp-servers` in `.agent.md` frontmatter
- Agent plugins use `.mcp.json` or `plugin.json` with top-level `mcpServers`
- Tools can be referenced as `<server>/<tool>` or `<server>/*`
- Local stdio servers can use `sandboxEnabled: true` on macOS/Linux

**Use MCP instead of a skill when:**

- The agent needs live data or actions outside the repository
- The integration must expose callable tools, not just instructions
- Secrets or runtime configuration are required

---

### Use Tool Sets when

**Perfect for:**

- Grouping read-only research tools for planning and review workflows
- Grouping selected MCP tools so users do not enable a full server by accident
- Making repeated tool selections easier in prompts and custom agents
- Staying under the practical tool limit by enabling only relevant tool groups

**Key features:**

- Tool sets can include built-in tools, MCP tools, and extension tools
- Referenced in prompts with `#toolset-name`
- Appear as collapsible groups in the tools picker
- Useful alongside explicit `tools` lists in `.prompt.md` and `.agent.md` files

---

### Use Organization or Enterprise Customizations when

**Perfect for:**

- Shared defaults across many repositories
- Governance rules that should not be copied manually into every repo
- Organization-wide custom agents or instructions
- Standard plugin marketplaces or approved tool policies

**Key features:**

- Organization instructions and custom agents can be discovered alongside local files when enabled by settings/admin policy
- Repository-level agents with the same name override organization/enterprise-level agents
- Enterprise or organization agents can live in a `.github-private` repository for GitHub Copilot cloud agent scenarios
- Keep repository customizations focused on local project behavior and treat org/enterprise assets as the default layer

---

## How They Work Together

```
┌─────────────────────────────────────────────────────────────┐
│                     CUSTOM AGENT                            │
│  (defines persona, tools, model, hooks)                     │
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
├─────────────────────────────────────────────────────────────┤
│                        HOOKS                                │
│  (deterministic lifecycle automation)                       │
│    └── Runs at lifecycle events, enforces policies          │
├─────────────────────────────────────────────────────────────┤
│                     MCP SERVERS                             │
│  (external tools, resources, prompts, and apps)             │
│    └── Tools can be limited via agent/prompt/tool-set config│
├─────────────────────────────────────────────────────────────┤
│                 AGENT PLUGINS + TOOL SETS                  │
│  (distribution + reusable tool grouping)                    │
│    └── Plugins bundle primitives; tool sets group tools     │
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
├── skills/
│   ├── webapp-testing/
│   │   ├── SKILL.md
│   │   └── test-template.js
│   └── debugging/
│       └── SKILL.md
└── hooks/
    ├── security.json            # Block dangerous commands
    └── formatting.json          # Auto-format after edits
.vscode/
└── mcp.example.json             # Inert MCP example; copy to mcp.json to enable
.github/
├── plugin/
│   └── plugin.example.json      # Inert plugin manifest example
└── toolsets/
    └── toolsets.example.jsonc   # Inert tool-set example
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

### External Tool Integration

1. **MCP**: `.vscode/mcp.json` or agent `mcp-servers` exposes a trusted external tool
2. **Tool set**: Groups only the required MCP tools
3. **Agent**: Restricts `tools` to `read`, `search`, and selected MCP tools

### Packaged Team Workflow

1. **Plugin**: Bundles agents, skills, prompts, hooks, and MCP servers
2. **Organization setting**: Recommends the plugin marketplace or enabled plugin
3. **Repository override**: Adds repo-specific instructions or agent variants

## Version Requirements

| Feature | Minimum VS Code Version | Setting |
|---------|-------------------------|---------|
| `copilot-instructions.md` | 1.95 | `github.copilot.chat.codeGeneration.useInstructionFiles` |
| `*.instructions.md` | 1.99 | Auto-discovered |
| Prompt files | 1.99 | Auto-discovered |
| `AGENTS.md` | 1.102 | `chat.useAgentsMdFile` |
| Custom agents (`.agent.md`) | 1.106 | Auto-discovered |
| Nested `AGENTS.md` | 1.105 | `chat.useNestedAgentsMdFiles` (experimental) |
| `CLAUDE.md` | 1.105+ | `chat.useClaudeMdFile` |
| Agent Skills | 1.108 | `chat.useAgentSkills` |
| Parent-repo discovery (monorepo) | 1.108+ | `chat.useCustomizationsInParentRepositories` |
| MCP servers | 1.102+ | `chat.mcp.enabled` / `chat.mcp.access` |
| MCP sandboxing | Preview | `sandboxEnabled` in `mcp.json` |
| Tool sets | 1.108+ | Configure with `Chat: Configure Tool Sets` |
| Organization instructions | 1.108+ | `github.copilot.chat.organizationInstructions.enabled` |
| Organization custom agents | 1.107+ | `github.copilot.chat.organizationCustomAgents.enabled` |
| Hooks | Preview | `chat.useCustomAgentHooks` (for agent-scoped) |
| Agent plugins | Preview | `chat.plugins.enabled` |

## References

- [Customization Overview](https://code.visualstudio.com/docs/copilot/customization/overview)
- [Custom Instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [Prompt Files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [Custom Agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [Agent Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Hooks](https://code.visualstudio.com/docs/copilot/customization/hooks)
- [Agent Plugins](https://code.visualstudio.com/docs/copilot/customization/agent-plugins)
- [MCP Servers](https://code.visualstudio.com/docs/copilot/customization/mcp-servers)
- [Agent Tools and Tool Sets](https://code.visualstudio.com/docs/copilot/agents/agent-tools)
- [Agent Skills Standard](https://agentskills.io/)
- [Community Examples](https://github.com/github/awesome-copilot)
