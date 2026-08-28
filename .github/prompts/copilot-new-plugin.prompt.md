---
description: Scaffold an agent plugin bundle with prompts, skills, agents, hooks, and MCP servers
name: New Agent Plugin
agent: Copilot Customization Builder
tools: ['search', 'edit/editFiles']
---

# New Agent Plugin

Create an agent plugin blueprint for packaging multiple Copilot customizations as an installable bundle.

## Inputs

- Plugin name (kebab-case): `${input:pluginName}`
- Plugin description: `${input:pluginDescription}`
- Components to include (`skills`, `agents`, `prompts`, `hooks`, `mcp`): `${input:pluginComponents}`
- Target format (`copilot`, `claude`, `openplugin`, or `cross-tool`): `${input:pluginFormat}`

## Requirements

1. Use plugins when a workflow should be installed as a bundle rather than copied as loose files.
2. Keep plugin names plain kebab-case: lowercase letters, numbers, and hyphens only; max 64 characters.
3. Create an inert example by default (`plugin.example.json`) unless the user explicitly asks for an active plugin manifest.
4. Include only the components requested by the user:
   - `skills/` for Agent Skills
   - `agents/` for `.agent.md` files
   - prompt/slash commands where supported by the target format
   - `hooks.json` or `hooks/hooks.json` depending on plugin format
   - `.mcp.json` for plugin MCP servers
5. Warn that plugins can run code through hooks and MCP servers. Users must review publisher, scripts, and server configuration before enabling.
6. For workspace recommendations, document that VS Code can recommend plugins through `.github/copilot/settings.json` or `.claude/settings.json`.

## Copilot-format manifest example

```json
{
  "name": "${input:pluginName}",
  "description": "${input:pluginDescription}",
  "version": "0.1.0",
  "author": {
    "name": "Your Team"
  },
  "skills": "skills/",
  "agents": "agents/",
  "hooks": "hooks.json",
  "mcpServers": ".mcp.json"
}
```

## Suggested structure

```text
${input:pluginName}/
├── plugin.json
├── skills/
│   └── example-skill/
│       └── SKILL.md
├── agents/
│   └── example-agent.agent.md
├── hooks.json
├── scripts/
│   └── validate-tool.sh
└── .mcp.json
```

## Cross-tool notes

- VS Code detects plugin manifests at `.plugin/plugin.json`, `plugin.json`, `.github/plugin/plugin.json`, and `.claude-plugin/plugin.json`.
- Claude-format plugins use `${CLAUDE_PLUGIN_ROOT}` in hook and MCP configuration; Copilot-format plugins do not define that token.
- Skills inside plugins still require `SKILL.md` `name` to match the parent directory and use plain kebab-case.
- Plugin MCP servers use top-level `mcpServers`, while VS Code workspace MCP config uses top-level `servers`.

## Reference docs

- Agent plugins (VS Code): https://code.visualstudio.com/docs/copilot/customization/agent-plugins
- Agent Skills (VS Code): https://code.visualstudio.com/docs/copilot/customization/agent-skills
- Hooks (VS Code): https://code.visualstudio.com/docs/copilot/customization/hooks
- MCP servers (VS Code): https://code.visualstudio.com/docs/copilot/customization/mcp-servers
- Copilot CLI plugin reference: https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-plugin-reference
