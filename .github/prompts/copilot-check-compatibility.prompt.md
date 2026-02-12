---
description: Diagnose VS Code and GitHub Copilot feature compatibility - check settings, version requirements, and troubleshoot issues
name: Check Compatibility
agent: Copilot Customization Builder
tools: ['search', 'runCommand', 'fetch']
---

# Check Compatibility

Diagnose feature availability and troubleshoot Copilot customization issues.

## What to check

- Feature not working: `${input:featureIssue:Describe the feature or issue}`

## Diagnostic workflow

1. **Check VS Code version** - Run `code --version` in terminal to get version number
2. **Consult release notes** - Fetch the relevant VS Code release notes to verify feature availability
3. **Check workspace settings** - Look for `.vscode/settings.json` in workspace
4. **Verify file locations** - Ensure customization files are in correct directories
5. **Check feature requirements** - Cross-reference with documentation

## Key Sources to Consult

When diagnosing, fetch these sources as needed:

- **Release Notes**: `https://code.visualstudio.com/updates/v1_XXX` (replace XXX with version)
- **Custom Instructions**: https://code.visualstudio.com/docs/copilot/customization/custom-instructions
- **Custom Agents**: https://code.visualstudio.com/docs/copilot/customization/custom-agents
- **Agent Skills**: https://code.visualstudio.com/docs/copilot/customization/agent-skills
- **Prompt Files**: https://code.visualstudio.com/docs/copilot/customization/prompt-files

## Feature Requirements Quick Reference

### Experimental/Preview Features (require explicit opt-in)

| Feature | Required Setting |
|---------|-----------------|
| Agent Skills | `chat.useAgentSkills: true` |
| Nested AGENTS.md | `chat.useNestedAgentsMdFiles: true` |
| Subagents with custom agents | `chat.customAgentInSubagent.enabled: true` |
| Org/Enterprise agents | `github.copilot.chat.customAgents.showOrganizationAndEnterpriseAgents: true` |
| Background agents | `chat.agent.background.enabled: true` |

### Stable Features (usually enabled by default)

| Feature | Setting (if not working) |
|---------|-------------------------|
| copilot-instructions.md | `github.copilot.chat.codeGeneration.useInstructionFiles: true` |
| AGENTS.md (root) | `chat.useAgentsMdFile: true` |
| MCP servers | `chat.mcp.enabled: true` |

## Diagnostic actions

Based on the user's issue (`${input:featureIssue}`):

1. Identify which feature is affected
2. Check if the required setting is enabled
3. Verify VS Code version meets minimum requirement
4. Confirm files are in correct locations with valid format
5. Suggest specific fixes

## File location checklist

- [ ] `.github/copilot-instructions.md` - workspace-wide instructions
- [ ] `.github/instructions/*.instructions.md` - scoped instructions
- [ ] `.github/agents/*.agent.md` - custom agents
- [ ] `.github/prompts/*.prompt.md` - prompt files
- [ ] `.github/skills/*/SKILL.md` - agent skills
- [ ] `.vscode/settings.json` - workspace settings
- [ ] `AGENTS.md` - multi-agent instructions

## Output

Provide:
1. Root cause of the issue
2. Required settings to enable
3. Minimum VS Code version needed
4. File location fixes if applicable
5. Sample settings.json snippet to copy
