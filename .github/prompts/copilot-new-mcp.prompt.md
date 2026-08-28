---
description: Scaffold MCP server configuration for VS Code and GitHub Copilot agents
name: New MCP Setup
agent: Copilot Customization Builder
tools: ['search', 'edit/editFiles']
---

# New MCP Setup

Create or update MCP server configuration for this repository.

## Inputs

- MCP server name (stable kebab-case): `${input:mcpServerName}`
- Server transport (`stdio`, `http`, or `sse`): `${input:mcpTransport}`
- Server command or URL: `${input:mcpCommandOrUrl}`
- Scope (`vscode-workspace`, `vscode-user`, `github-copilot-agent`, or `plugin`): `${input:mcpScope}`
- Tools to expose (comma-separated, or `*`): `${input:mcpTools}`

## Requirements

1. Inspect existing MCP configuration before editing:
   - VS Code workspace: `.vscode/mcp.json`
   - VS Code user profile: use `MCP: Open User Configuration`
   - GitHub Copilot cloud agent: `mcp-servers` in `.github/agents/<agent>.agent.md`
   - Agent plugin: `.mcp.json` or `mcpServers` in `plugin.json`
2. Prefer an example file (`mcp.example.json`) unless the user explicitly asks to enable a live server.
3. Never hardcode secrets, tokens, passwords, or API keys.
   - Use VS Code input variables, environment files, or GitHub Copilot environment secrets/variables.
4. For local stdio servers, consider `sandboxEnabled: true` on macOS/Linux and restrict filesystem/network access.
5. Keep tool exposure narrow:
   - Use explicit tools such as `github/list_issues` where practical.
   - Use `<server>/*` only when the full server is intentionally needed.
6. Document how to start, trust, disable, and troubleshoot the MCP server.

## VS Code workspace example

Create or update `.vscode/mcp.json`:

```json
{
  "servers": {
    "${input:mcpServerName}": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@example/mcp-server"],
      "sandboxEnabled": true,
      "sandbox": {
        "filesystem": {
          "allowWrite": ["${workspaceFolder}"]
        },
        "network": {
          "allowedDomains": ["api.example.com"]
        }
      }
    }
  }
}
```

For HTTP servers:

```json
{
  "servers": {
    "${input:mcpServerName}": {
      "type": "http",
      "url": "${input:mcpCommandOrUrl}"
    }
  }
}
```

## GitHub Copilot custom agent example

For `target: github-copilot`, add `mcp-servers` to the agent frontmatter:

```yaml
---
name: example-agent
description: Agent that uses a scoped MCP server
target: github-copilot
tools: ['read', 'search', '${input:mcpServerName}/tool-name']
mcp-servers:
  ${input:mcpServerName}:
    type: 'local'
    command: 'npx'
    args: ['-y', '@example/mcp-server']
    tools: ['*']
    env:
      API_TOKEN: ${{ secrets.COPILOT_MCP_API_TOKEN }}
---
```

## Validation checklist

- YAML/JSON parses successfully.
- Server name is stable and matches tool references.
- Secret handling is documented and no secrets are committed.
- Tool list uses least privilege.
- Trust and approval implications are explained.
- For plugin MCP servers, use top-level `mcpServers` (not `servers`).

## Reference docs

- MCP servers (VS Code): https://code.visualstudio.com/docs/copilot/customization/mcp-servers
- MCP configuration reference: https://code.visualstudio.com/docs/copilot/reference/mcp-configuration
- Agent tools and approvals: https://code.visualstudio.com/docs/copilot/agents/agent-tools
- Custom agents configuration (GitHub): https://docs.github.com/en/copilot/reference/custom-agents-configuration
- Model Context Protocol: https://modelcontextprotocol.io/
