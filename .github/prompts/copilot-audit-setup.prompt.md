---
description: Audit the repository's Copilot customization setup and suggest improvements
name: Audit Copilot Setup
agent: Copilot Customization Builder
tools: ['search', 'editFiles']
---

# Audit Copilot Setup

Analyze this repository's GitHub Copilot customization and provide recommendations.

## Audit Scope

Focus area (optional): `${input:focusArea:Leave empty for full audit, or specify: instructions, agents, prompts, skills, settings}`

## Audit Workflow

### Step 1: Scan Repository Structure

Check for existence and content of:

1. **Instructions**
   - `.github/copilot-instructions.md`
   - `.github/instructions/*.instructions.md`
   - `AGENTS.md` (root and subfolders)

2. **Custom Agents**
   - `.github/agents/*.agent.md`
   - Legacy: `.github/chatmodes/*.chatmode.md` (should migrate)

3. **Prompt Files**
   - `.github/prompts/*.prompt.md`

4. **Agent Skills**
   - `.github/skills/*/SKILL.md`

5. **Settings**
   - `.vscode/settings.json`

### Step 2: Validate Existing Files

For each file found, check:
- Valid YAML frontmatter
- Required fields present
- No deprecated patterns
- Best practices followed

### Step 3: Identify Gaps

Based on project type, suggest missing customizations:
- Language-specific instructions
- Common workflow agents
- Repetitive task prompts
- Project knowledge skills

### Step 4: Generate Report

Output a structured report with:

```markdown
## Copilot Setup Audit Report

### ✅ What's Working Well
- 

### ⚠️ Warnings
- 

### ❌ Issues to Fix
- 

### 💡 Suggestions
- 

### Recommended Next Steps
1. 
2. 
3. 
```

## Report Requirements

1. **Be specific** - Reference exact file paths and line numbers
2. **Prioritize** - Mark issues as critical/warning/suggestion
3. **Be actionable** - Provide concrete fixes, not vague advice
4. **Offer to scaffold** - Ask if user wants help creating missing files

## Project Type Detection

Detect the project type from:
- `package.json` → Node.js/JavaScript/TypeScript
- `requirements.txt` / `pyproject.toml` → Python
- `go.mod` → Go
- `Cargo.toml` → Rust
- `*.csproj` / `*.sln` → .NET
- `pom.xml` / `build.gradle` → Java

Tailor recommendations to the detected project type.
