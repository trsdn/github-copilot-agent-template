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
   - `target`: Set to `vscode` or `github-copilot` if restricting; omit for both
   - `model` (optional): Specific AI model to use
   - `infer` (optional): Boolean to enable/disable use as subagent (default: true)
   - `argument-hint` (optional): Hint text shown in chat input field
   - `handoffs` (optional): List of suggested next actions to transition between agents
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

When done, list the created file path and how to select the agent in the VS Code agents dropdown.

## Reference docs

- Custom agents (VS Code): https://code.visualstudio.com/docs/copilot/customization/custom-agents
- Agents overview (local/background/cloud): https://code.visualstudio.com/docs/copilot/agents/overview
- Background agents: https://code.visualstudio.com/docs/copilot/agents/background-agents
- Cloud agents: https://code.visualstudio.com/docs/copilot/agents/cloud-agents
- Tools & approvals (VS Code): https://code.visualstudio.com/docs/copilot/chat/chat-tools
- Security considerations (VS Code): https://code.visualstudio.com/docs/copilot/security
- Awesome Copilot examples: https://github.com/github/awesome-copilot

GitHub Copilot (cloud) custom agents:
- Creating custom agents (GitHub docs): https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents
