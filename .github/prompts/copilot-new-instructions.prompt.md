---
description: Scaffold a new scoped custom instructions file (*.instructions.md)
name: New Instructions File
agent: Copilot Customization Builder
tools: ['search', 'edit/editFiles']
---
# New Instructions File

Create a new `*.instructions.md` file with an `applyTo` glob.

## Inputs

- Instructions file slug (filename, without `.instructions.md`): `${input:instructionsSlug}`
- applyTo glob (example: `**/*.py`): `${input:applyToGlob}`
- Short purpose line (what it enforces): `${input:instructionsPurpose}`
- Location (`workspace` or `user`): `${input:instructionsLocation}`

## Instructions file types

VS Code supports multiple types of instructions files:

| Type | Location | Scope |
|------|----------|-------|
| `.github/copilot-instructions.md` | Workspace root | All chat requests |
| `*.instructions.md` | `.github/instructions/` or user profile | File-pattern scoped via `applyTo` |
| `AGENTS.md` | Workspace root (or subfolders with experimental setting) | All agents in workspace |

## Requirements

1. Create the file at the appropriate location:
   - Workspace: `.github/instructions/${input:instructionsSlug}.instructions.md`
   - User profile: Use the `Chat: New Instructions File` command and select "User profile"
2. Use YAML frontmatter with these fields:
   - `applyTo` (optional): Glob pattern for auto-application (e.g., `**/*.py`). If omitted, must be attached manually.
   - `description` (optional): Short description of the instructions file
   - `name` (optional): Display name in UI (defaults to filename)

```yaml
---
applyTo: '${input:applyToGlob}'
description: ${input:instructionsPurpose}
name: ${input:instructionsSlug}
---
```

3. Write concise, actionable rules aligned to the purpose
4. Use `#tool:<tool-name>` syntax to reference tools in body text
5. Use Markdown links to reference specific files or URLs as context
6. Avoid duplicating rules already present in `.github/copilot-instructions.md` unless specializing for a file pattern

## AGENTS.md (alternative)

If working with multiple AI agents, consider using `AGENTS.md` at the workspace root instead:
- Enable with `chat.useAgentsMdFile` setting
- Applies to all chat requests in workspace
- Experimental: Enable `chat.useNestedAgentsMdFiles` for subfolder-specific instructions

When done, explain:
- How this file interacts with `.github/copilot-instructions.md`
- How to verify instructions are applied (check References section in chat response)

## Reference docs

- Custom instructions (VS Code): https://code.visualstudio.com/docs/copilot/customization/custom-instructions
- Customize chat overview (VS Code): https://code.visualstudio.com/docs/copilot/customization/overview
- Security considerations (VS Code): https://code.visualstudio.com/docs/copilot/security
- Awesome Copilot examples: https://github.com/github/awesome-copilot
