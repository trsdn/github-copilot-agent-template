---
name: copilot-compatibility-checker
description: Check VS Code and GitHub Copilot feature compatibility. Use this skill when diagnosing why a feature isn't working, checking required settings, or verifying version requirements for experimental features.
---

# Compatibility Checker

This skill helps diagnose and verify VS Code / GitHub Copilot feature compatibility based on version and settings.

## When to use this skill

- User reports a feature isn't working
- Setting up experimental/preview features
- Checking if a feature is available in the user's VS Code version
- Diagnosing missing capabilities

## Reference Sources

When diagnosing issues, consult these sources for the latest information:

### VS Code Release Notes

- [VS Code 1.108 Release Notes](https://code.visualstudio.com/updates/v1_108)
- [VS Code 1.107 Release Notes](https://code.visualstudio.com/updates/v1_107)
- [VS Code 1.106 Release Notes](https://code.visualstudio.com/updates/v1_106)
- [VS Code 1.105 Release Notes](https://code.visualstudio.com/updates/v1_105)
- [VS Code 1.104 Release Notes](https://code.visualstudio.com/updates/v1_104)
- [VS Code 1.103 Release Notes](https://code.visualstudio.com/updates/v1_103)
- [VS Code 1.102 Release Notes](https://code.visualstudio.com/updates/v1_102)
- [VS Code 1.99 Release Notes](https://code.visualstudio.com/updates/v1_99)
- [VS Code 1.95 Release Notes](https://code.visualstudio.com/updates/v1_95)
- [All VS Code Updates](https://code.visualstudio.com/updates)

### Copilot Customization Documentation

- [Customization Overview](https://code.visualstudio.com/docs/copilot/customization/overview)
- [Custom Instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
- [Custom Agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents)
- [Prompt Files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [Agent Skills](https://code.visualstudio.com/docs/copilot/customization/agent-skills)
- [Hooks](https://code.visualstudio.com/docs/copilot/customization/hooks)
- [Agent Plugins](https://code.visualstudio.com/docs/copilot/customization/agent-plugins)
- [MCP Servers](https://code.visualstudio.com/docs/copilot/customization/mcp-servers)
- [MCP Configuration Reference](https://code.visualstudio.com/docs/copilot/reference/mcp-configuration)
- [Language Models](https://code.visualstudio.com/docs/copilot/customization/language-models)

### Agents Documentation

- [Agents Overview](https://code.visualstudio.com/docs/copilot/agents/overview)
- [Background Agents](https://code.visualstudio.com/docs/copilot/agents/background-agents)
- [Cloud Agents](https://code.visualstudio.com/docs/copilot/agents/cloud-agents)

### Chat & Tools Documentation

- [Agent Tools](https://code.visualstudio.com/docs/copilot/agents/agent-tools)
- [Tools Concepts](https://code.visualstudio.com/docs/copilot/concepts/tools)
- [Chat Sessions](https://code.visualstudio.com/docs/copilot/chat/chat-sessions)
- [Copilot Chat Context](https://code.visualstudio.com/docs/copilot/chat/copilot-chat-context)

### Security & Troubleshooting

- [Security Considerations](https://code.visualstudio.com/docs/copilot/security)
- [Copilot Issues Wiki](https://github.com/microsoft/vscode/wiki/Copilot-Issues)
- [VS Code Settings Reference](https://code.visualstudio.com/docs/getstarted/settings)

### GitHub Copilot Documentation

- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [Custom Agents (GitHub)](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-custom-agents)
- [Custom Agents Configuration (GitHub)](https://docs.github.com/en/copilot/reference/custom-agents-configuration)
- [Coding Agent](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent)

### Community Resources

- [Awesome Copilot Repository](https://github.com/github/awesome-copilot)
- [Agent Skills Standard](https://agentskills.io/)
- [Anthropic Skills Repository](https://github.com/anthropics/skills)

## Feature Compatibility Matrix

### Custom Instructions

| Feature | Setting | Since Version | Status |
|---------|---------|---------------|--------|
| `.github/copilot-instructions.md` | `github.copilot.chat.codeGeneration.useInstructionFiles` | 1.95 | Stable |
| `*.instructions.md` files | Auto-discovered in `.github/instructions/` | 1.99 | Stable |
| `AGENTS.md` (root) | `chat.useAgentsMdFile` | 1.102 | Stable |
| `AGENTS.md` (nested/subfolders) | `chat.useNestedAgentsMdFiles` | 1.105 | **Experimental** |
| `CLAUDE.md` | `chat.useClaudeMdFile` | 1.105+ | Stable/compatible |
| Parent repository discovery | `chat.useCustomizationsInParentRepositories` | 1.108+ | Stable |

### Custom Agents

| Feature | Setting | Since Version | Status |
|---------|---------|---------------|--------|
| Custom agents (`.agent.md`) | Auto-discovered | 1.106 | Stable |
| Legacy chat modes (`.chatmode.md`) | Auto-discovered (deprecated) | 1.99-1.105 | Deprecated |
| Subagents with custom agents | `chat.customAgentInSubagent.enabled` | 1.106 | **Experimental** |
| Organization custom agents | `github.copilot.chat.organizationCustomAgents.enabled` | 1.107+ | Stable/Policy controlled |

### Agent Skills

| Feature | Setting | Since Version | Status |
|---------|---------|---------------|--------|
| Agent Skills | `chat.useAgentSkills` | 1.108 | Stable |
| Project skills (`.github/skills/`) | `chat.useAgentSkills` | 1.108 | Stable |
| Personal skills (`~/.copilot/skills/`) | `chat.useAgentSkills` | 1.108 | Stable |
| Alt skill locations (`.agents/skills/`) | `chat.useAgentSkills` | 1.108 | Stable |
| Custom skill locations | `chat.agentSkillsLocations` | 1.108 | Stable |

### Hooks (Lifecycle Automation)

| Feature | Setting | Since Version | Status |
|---------|---------|---------------|--------|
| Workspace hooks (`.github/hooks/`) | `chat.hookFilesLocations` | Preview | **Preview** |
| Agent-scoped hooks (frontmatter) | `chat.useCustomAgentHooks` | Preview | **Preview** |

### Agent Plugins

| Feature | Setting | Since Version | Status |
|---------|---------|---------------|--------|
| Agent plugins | `chat.plugins.enabled` | Preview | **Preview** |
| Plugin marketplaces | `chat.plugins.marketplaces` | Preview | **Preview** |
| Local plugins | `chat.pluginLocations` | Preview | **Preview** |

### Prompt Files

| Feature | Setting | Since Version | Status |
|---------|---------|---------------|--------|
| Prompt files (`.prompt.md`) | Auto-discovered in `.github/prompts/` | 1.99 | Stable |
| Prompt recommendations | `chat.promptFilesRecommendations` | 1.105 | Stable |

### Tools & Automation

| Feature | Setting | Since Version | Status |
|---------|---------|---------------|--------|
| Terminal tool auto-approval | `chat.tools.autoApprove` | 1.103 | Stable |
| Terminal sandboxing | `chat.tools.terminal.sandbox.enabled` | Preview | **Preview** |
| MCP servers | `chat.mcp.enabled` | 1.102 | Stable |
| MCP access control | `chat.mcp.access` | 1.108+ | Stable/Policy controlled |
| MCP sandbox | `sandboxEnabled` in `mcp.json` | Preview | **Preview** |
| MCP auto-discovery | `chat.mcp.discovery.enabled` | Preview | **Preview** |
| Tool sets | `Chat: Configure Tool Sets` | 1.108+ | Stable/Preview |
| Organization instructions | `github.copilot.chat.organizationInstructions.enabled` | 1.108+ | Stable/Policy controlled |
| Background agents | `chat.agent.background.enabled` | 1.107 | **Experimental** |
| Autopilot mode | `chat.autopilot.enabled` | Preview | **Preview** |

## Diagnostic Steps

### Step 1: Check VS Code Version

Ask the user to run:

```
code --version
```

Or check via: **Help → About** (macOS: **Code → About Visual Studio Code**)

The first line is the version number (e.g., `1.108.0`).

### Step 2: Check Settings

To verify a setting is enabled, check:

1. **User settings**: `~/.config/Code/User/settings.json` (Linux), `~/Library/Application Support/Code/User/settings.json` (macOS), `%APPDATA%\Code\User\settings.json` (Windows)
2. **Workspace settings**: `.vscode/settings.json`

Or use the Command Palette: **Preferences: Open Settings (JSON)**

### Step 3: Verify Feature Files

Check if the required files exist in the correct locations:

| Feature | Expected Location |
|---------|-------------------|
| Workspace instructions | `.github/copilot-instructions.md` |
| Scoped instructions | `.github/instructions/*.instructions.md` |
| Custom agents | `.github/agents/*.agent.md` |
| Prompt files | `.github/prompts/*.prompt.md` |
| Agent Skills | `.github/skills/*/SKILL.md` |
| Hook configs | `.github/hooks/*.json` |
| AGENTS.md | Root or subfolders |

## Common Issues

### "My instructions aren't being applied"

1. Check `github.copilot.chat.codeGeneration.useInstructionFiles` is `true`
2. Verify file is in correct location
3. For `*.instructions.md`: check `applyTo` glob matches target files
4. Check the **References** section in chat response to see which files were used

### "My custom agent doesn't appear"

1. Verify file has `.agent.md` extension
2. Check file is in `.github/agents/` directory
3. Ensure YAML frontmatter is valid (check for syntax errors)
4. Look for the agent in **Configure Custom Agents** menu

### "Agent Skills aren't loading"

1. Enable `chat.useAgentSkills` setting (it's preview, not on by default)
2. Verify `SKILL.md` exists in the skill directory
3. Check skill has valid YAML frontmatter with `name` and `description`

### "Nested AGENTS.md not working"

1. Enable `chat.useNestedAgentsMdFiles` (experimental)
2. Ensure `chat.useAgentsMdFile` is also enabled
3. Verify AGENTS.md files are in subfolders (not just root)

### "Subagent can't use my custom agent"

1. Enable `chat.customAgentInSubagent.enabled` (experimental)
2. Verify the custom agent does not have `disable-model-invocation: true`
3. Ensure `runSubagent` tool is available

### "Hooks aren't running"

1. Verify hook configuration file is valid JSON in `.github/hooks/`
2. For agent-scoped hooks, enable `chat.useCustomAgentHooks`
3. Check that hook scripts exist and are executable
4. Verify the hook event name matches a valid lifecycle event

## Settings Quick Reference

Enable all experimental features:

```json
{
  "github.copilot.chat.codeGeneration.useInstructionFiles": true,
  "chat.useAgentsMdFile": true,
  "chat.useNestedAgentsMdFiles": true,
  "chat.useAgentSkills": true,
  "chat.customAgentInSubagent.enabled": true,
  "chat.mcp.enabled": true,
  "chat.useCustomAgentHooks": true,
  "chat.plugins.enabled": true,
  "chat.autopilot.enabled": true,
  "chat.mcp.discovery.enabled": true,
  "github.copilot.chat.organizationCustomAgents.enabled": true
}
```

## Version History Reference

| Version | Key Features Added |
|---------|-------------------|
| Preview | Hooks (lifecycle automation), Agent plugins |
| 1.108 | Agent Skills |
| 1.107 | Background agents (experimental), org/enterprise agents |
| 1.106 | Custom agents (renamed from chat modes) |
| 1.105 | Nested AGENTS.md (experimental) |
| 1.103 | Terminal auto-approval |
| 1.102 | MCP servers, AGENTS.md |
| 1.99 | Prompt files, instructions files |
| 1.95 | copilot-instructions.md |

## Usage

When a user reports a feature not working or asks about compatibility:

1. **Check their VS Code version** - Ask them to run `code --version` or check Help → About
2. **Verify required settings** - Use the settings quick reference above to identify which experimental flags need to be enabled
3. **Check feature availability** - Cross-reference with the version history to see if the feature exists in their version
4. **Provide solution** - Guide them to either update VS Code or enable the necessary settings

### Examples

#### Example 1: Agent Skills not working

- Check: VS Code version ≥ 1.108
- Setting: `"chat.useAgentSkills": true`
- Solution: Update to 1.108+ and enable the setting

#### Example 2: Custom agents not appearing

- Check: VS Code version ≥ 1.106
- Setting: `"chat.useAgentsMdFile": true`
- File: `.github/AGENTS.md` or `.github/agents/*.agent.md` exists
- Solution: Verify setting is enabled and file structure is correct
