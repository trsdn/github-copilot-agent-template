---
description: Scaffold a new hook configuration for lifecycle automation in agent sessions
name: New Hook
agent: Copilot Customization Builder
tools: ['search', 'edit/editFiles']
---

# New Hook Configuration

Create a new hook configuration file for lifecycle automation.

## Inputs

- Hook purpose (what it automates): `${input:hookPurpose}`
- Hook event type: `${input:hookEvent:PreToolUse, PostToolUse, SessionStart, Stop, UserPromptSubmit, PreCompact, SubagentStart, SubagentStop}`
- Scope (`workspace` for `.github/hooks/` or `agent` for agent frontmatter): `${input:hookScope}`

## What are hooks?

Hooks execute custom shell commands at key lifecycle points during agent sessions. They provide deterministic, code-driven automation that runs regardless of how the agent is prompted.

## Hook events

| Event | When It Fires | Common Use Cases |
|-------|---------------|------------------|
| `SessionStart` | First prompt of a new session | Initialize resources, log session start |
| `UserPromptSubmit` | User submits a prompt | Audit requests, inject context |
| `PreToolUse` | Before agent invokes any tool | Block dangerous operations, require approval |
| `PostToolUse` | After tool completes | Run formatters, log results |
| `PreCompact` | Before context is compacted | Export important context |
| `SubagentStart` | Subagent is spawned | Track nested agent usage |
| `SubagentStop` | Subagent completes | Aggregate results, cleanup |
| `Stop` | Agent session ends | Generate reports, cleanup |

## Requirements

1. Inspect existing hooks in `.github/hooks/` (if any) and match conventions.
2. Create the hook configuration:
   - **Workspace scope**: Create a JSON file at `.github/hooks/<name>.json`
   - **Agent scope**: Add a `hooks:` field in the agent's `.agent.md` frontmatter (requires `chat.useCustomAgentHooks`)
3. Hook configuration format (JSON):

```json
{
  "hooks": {
    "${input:hookEvent}": [
      {
        "type": "command",
        "command": "./scripts/<hook-script>.sh",
        "timeout": 30
      }
    ]
  }
}
```

4. Create the companion shell script if needed:
   - Read JSON input from stdin
   - Return JSON output to stdout
   - Use exit code 0 for success, 2 for blocking error
5. For `PreToolUse` hooks, the output can control tool execution:
   - `permissionDecision`: `"allow"`, `"deny"`, or `"ask"`
   - `permissionDecisionReason`: Explanation shown to user
6. For OS-specific commands, use `windows`, `linux`, `osx` fields alongside default `command`

## Hook input/output

All hooks receive JSON via stdin with common fields:

```json
{
  "timestamp": "2026-01-01T00:00:00.000Z",
  "cwd": "/path/to/workspace",
  "sessionId": "session-id",
  "hookEventName": "PreToolUse"
}
```

All hooks can return JSON via stdout:

```json
{
  "continue": true,
  "systemMessage": "Optional message to show in chat"
}
```

## Best practices

- Keep hook scripts fast (default timeout is 30 seconds)
- Check `stop_hook_active` in `Stop` hooks to prevent infinite loops
- Use exit code 2 for blocking errors (stderr shown to model)
- When multiple hooks conflict, the most restrictive decision wins

When done, explain:
- The created file path(s)
- How to test the hook
- Required settings (e.g., `chat.useCustomAgentHooks` for agent-scoped hooks)

## Reference docs

- Hooks (VS Code): https://code.visualstudio.com/docs/copilot/customization/hooks
- Customize chat overview: https://code.visualstudio.com/docs/copilot/customization/overview
- Custom agents (for agent-scoped hooks): https://code.visualstudio.com/docs/copilot/customization/custom-agents
