---
description: Scaffold a new reusable prompt file (.prompt.md) invoked via / in Copilot Chat
name: New Prompt File
agent: Copilot Customization Builder
tools: ['search', 'edit/editFiles']
---

# New Prompt File

Create a new reusable prompt file in `.github/prompts/`.

## Inputs

- Prompt file slug (filename, without `.prompt.md`): `${input:promptSlug}`
- Prompt display name: `${input:promptName}`
- One-line description: `${input:promptDescription}`
- Agent to run this prompt with (e.g. `agent`, `ask`, `edit`, or custom agent name): `${input:promptAgent}`
- Tools list (comma-separated): `${input:promptTools}`
- Location (`workspace` or `user`): `${input:promptLocation}`

## Requirements

1. Inspect existing prompt files in `.github/prompts/` and match conventions (YAML keys, quoting style).
2. Create the file:
   - Workspace: `.github/prompts/${input:promptSlug}.prompt.md`
   - User profile: Use the `Chat: New Prompt File` command and select "User profile"
3. Add YAML frontmatter with these fields:
   - `description` (optional): Short description of the prompt
   - `name` (optional): Display name after typing `/` in chat (defaults to filename)
   - `agent` (optional): Agent for running the prompt (`ask`, `edit`, `agent`, or custom agent name)
   - `tools` (optional): List of available tools (can use `<server>/*` for all MCP tools)
   - `model` (optional): Specific AI model to use
   - `argument-hint` (optional): Hint text shown in chat input field
4. In the prompt body:
   - Provide a short title
   - Provide clear steps/instructions
   - Use `#tool:<tool-name>` syntax to reference tools
   - Use Markdown links to reference other workspace files

## Available variables

Use these variables in the prompt body:

| Category | Variables |
|----------|----------|
| Workspace | `${workspaceFolder}`, `${workspaceFolderBasename}` |
| Selection | `${selection}`, `${selectedText}` |
| File context | `${file}`, `${fileBasename}`, `${fileDirname}`, `${fileBasenameNoExtension}` |
| User input | `${input:variableName}`, `${input:variableName:placeholder}` |

## Tool list priority

Tools are resolved in this order:
1. Tools specified in the prompt file
2. Tools from the referenced custom agent
3. Default tools for the selected agent

When done, explain:
- How to invoke it with `/${input:promptSlug}`
- How to run with the editor play button for testing
- Optional: Enable `chat.promptFilesRecommendations` to show as recommended action

## Reference docs

- Prompt files (VS Code): https://code.visualstudio.com/docs/copilot/customization/prompt-files
- Customize chat overview (VS Code): https://code.visualstudio.com/docs/copilot/customization/overview
- Copilot Chat context (VS Code): https://code.visualstudio.com/docs/copilot/chat/copilot-chat-context
- Chat sessions (VS Code): https://code.visualstudio.com/docs/copilot/chat/chat-sessions
- Tools in chat (VS Code): https://code.visualstudio.com/docs/copilot/chat/chat-tools
- Prompt engineering guide: https://code.visualstudio.com/docs/copilot/guides/prompt-engineering-guide
- Context engineering guide: https://code.visualstudio.com/docs/copilot/guides/context-engineering-guide
- Awesome Copilot examples: https://github.com/github/awesome-copilot
