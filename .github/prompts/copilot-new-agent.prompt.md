---
description: Scaffold a new custom agent (.agent.md) for VS Code and/or GitHub Copilot
name: New Custom Agent
agent: Copilot Customization Builder
tools: ['search', 'edit/editFiles']
---

# New Custom Agent

Create a new custom agent profile in this repository.

## Inputs

- Agent file slug (filename, without `.agent.md`): `${input:agentSlug}`
- Agent display name: `${input:agentName}`
- One-line description: `${input:agentDescription}`
- Target environment (`vscode`, `github-copilot`, or `both`): `${input:agentTarget}`
- Tools list (comma-separated, or leave blank to propose a minimal set): `${input:agentTools}`

## Requirements

1. Inspect existing agents in `.github/agents/` and match conventions (YAML keys, quoting style).
2. Create the agent file at: `.github/agents/${input:agentSlug}.agent.md`
3. In YAML frontmatter, use these fields:
   - `description` (required): Brief description shown as placeholder text in chat input
   - `name` (recommended): Display name (defaults to filename if omitted)
   - `tools` (recommended): Explicit list of available tools (prefer minimal)
       - Can include built-in tools, tool aliases, extension tools, tool sets, or MCP tools (`<server>/<tool>`, `<server>/*`)
   - `target`: Set to `vscode` or `github-copilot` if restricting; omit for both
   - `model` (optional): Specific AI model or prioritized array of models
   - `user-invocable` (optional): Boolean to control agents dropdown visibility (default: true)
   - `disable-model-invocation` (optional): Boolean to prevent subagent invocation (default: false)
   - `argument-hint` (optional): Hint text shown in chat input field
   - `handoffs` (optional): List of suggested next actions to transition between agents
   - `hooks` (optional, preview): Lifecycle hooks scoped to this agent
   - `mcp-servers` (optional): MCP server configs for GitHub Copilot target
4. In the Markdown body, include:
   - What the agent does
   - A default workflow (how it operates)
   - Guardrails (safety + scope boundaries)
   - Use `#tool:<tool-name>` syntax to reference tools in body text
5. Don't add repo-specific behavior unless requested.

## Handoffs (optional)

If creating a workflow agent, consider adding handoffs:

```yaml
handoffs:
  - label: Start Implementation
    agent: implementation
    prompt: Now implement the plan outlined above.
    send: false
```

- `label`: Button text shown after response
- `agent`: Target agent identifier
- `prompt`: Text to send to target agent
- `send`: Auto-submit prompt if true (default: false)
- `model`: Optional model override for the handoff target

## MCP and tool guidance

- For VS Code-only agents, configure MCP servers in `.vscode/mcp.json`, not agent frontmatter.
- For GitHub Copilot cloud agents, use `mcp-servers` in frontmatter and reference tools in `tools`.
- Prefer specific MCP tools (`server/tool-name`) over full server wildcards (`server/*`).
- Use tool sets for reusable groups of built-in, MCP, and extension tools when the same capability bundle is reused.

When done, list the created file path and how to select the agent in the VS Code agents dropdown.

> **Deprecated:** `infer` is deprecated. Use `user-invocable` and `disable-model-invocation` instead.

## Reference docs

- Custom agents (VS Code): https://code.visualstudio.com/docs/copilot/customization/custom-agents
- Agents overview (local/background/cloud): https://code.visualstudio.com/docs/copilot/agents/overview
- Background agents: https://code.visualstudio.com/docs/copilot/agents/background-agents
- Cloud agents: https://code.visualstudio.com/docs/copilot/agents/cloud-agents
- Agent tools & approvals (VS Code): https://code.visualstudio.com/docs/copilot/agents/agent-tools
- MCP servers (VS Code): https://code.visualstudio.com/docs/copilot/customization/mcp-servers
- Security considerations (VS Code): https://code.visualstudio.com/docs/copilot/security
- Hooks (VS Code): https://code.visualstudio.com/docs/copilot/customization/hooks
- Awesome Copilot examples: https://github.com/github/awesome-copilot

GitHub Copilot (cloud) custom agents:
- Creating custom agents (GitHub docs): https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents
