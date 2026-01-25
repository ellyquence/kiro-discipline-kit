# Kiro Global Profile - Engineering Discipline Configuration

A production-ready Kiro IDE configuration that enforces three core engineering disciplines:
- **Living Architecture Documentation** - Keep docs in sync with code
- **Prioritized Backlog Management** - Never code without a task
- **Functional Decomposition** - Maintain clean component boundaries

## Quick Start

```bash
# Clone this repo
git clone <this-repo-url> ~/KiroSpecs

# Install to any project
cd /path/to/your/project
~/KiroSpecs/install-kiro-profile.sh

# Or use symlinks (recommended for version control)
~/KiroSpecs/install-kiro-profile.sh --symlink
```

## File Paths Reference

### Linux Paths
```
Global config:      ~/.config/kiro/           (experimental)
Project config:     <project>/.kiro/          (recommended)
This template:      ~/KiroSpecs/.kiro/
```

### macOS Paths
```
Global config:      ~/Library/Application Support/kiro/  (experimental)
Project config:     <project>/.kiro/                     (recommended)
```

### Windows Paths
```
Global config:      %APPDATA%\kiro\            (experimental)
Project config:     <project>\.kiro\           (recommended)
```

## What's Included

```
.kiro/
├── steering/                    # AI behavior rules
│   ├── global.md               # Core standards (always active)
│   ├── architecture.md         # Living docs requirements
│   ├── backlog.md              # Task management rules
│   ├── decomposition.md        # Component size limits
│   ├── quality.md              # Quality gates
│   ├── typescript.md           # TS/JS rules (fileMatch: **/*.ts)
│   └── python.md               # Python rules (fileMatch: **/*.py)
│
├── hooks/                       # Automated checks
│   ├── architecture-sync.kiro.hook    # Drift detection
│   ├── task-hygiene.kiro.hook         # Backlog compliance
│   ├── component-check.kiro.hook      # Size/coupling validation
│   ├── doc-generation.kiro.hook       # Doc coverage
│   ├── test-on-save.kiro.hook         # Test sync
│   └── security-scan.kiro.hook        # Dependency audit
│
├── templates/                   # Spec templates
│   ├── requirements.md         # EARS notation requirements
│   ├── design.md               # C4 model architecture
│   ├── tasks.md                # MoSCoW prioritized backlog
│   ├── component-spec.md       # Component documentation
│   └── decision-record.md      # ADR template
│
├── settings/
│   └── mcp.json                # MCP server configuration
│
└── specs/                       # Your feature specs go here
    └── .gitkeep
```

## Installation Methods

### Method 1: Copy to Project (Simple)

```bash
# Install to current project
./install-kiro-profile.sh

# Install to specific project
./install-kiro-profile.sh /path/to/project

# Force overwrite existing config
./install-kiro-profile.sh --force /path/to/project
```

### Method 2: Symlink (Recommended for Teams)

```bash
# Create symlink to keep config in sync
./install-kiro-profile.sh --symlink /path/to/project

# Updates to KiroSpecs automatically propagate
```

### Method 3: Manual Copy

```bash
# Create structure
mkdir -p /path/to/project/.kiro/{steering,hooks,templates,settings,specs}

# Copy files
cp -r .kiro/steering/* /path/to/project/.kiro/steering/
cp -r .kiro/hooks/* /path/to/project/.kiro/hooks/
cp -r .kiro/templates/* /path/to/project/.kiro/templates/
cp -r .kiro/settings/* /path/to/project/.kiro/settings/
```

## Verification

After installation, verify everything is working:

### 1. Check Files Exist
```bash
ls -la .kiro/
# Should show: steering/, hooks/, templates/, settings/, specs/

ls .kiro/steering/
# Should show: 7 .md files

ls .kiro/hooks/
# Should show: 6 .kiro.hook files
```

### 2. Restart Kiro IDE
Hooks require a restart to activate:
- Close Kiro IDE completely
- Reopen the project
- Check the status bar for hook indicators

### 3. Test Steering Rules
1. Open any `.ts` or `.py` file
2. Start a chat with Kiro
3. Ask: "What are the file size limits for this project?"
4. Kiro should reference the decomposition rules (300 lines max)

### 4. Test Templates
1. Run command: `Kiro: New Spec`
2. Templates should appear in the selection
3. Select "requirements" to create a new requirements spec

### 5. Test Hooks
1. Create a new file in `src/`: `touch src/test-hook.ts`
2. The task-hygiene hook should trigger
3. Check Kiro's output for the task validation message

## Project Override Pattern

Override global settings for specific projects:

### Override a Single Steering Rule

Create `.kiro/steering/project-overrides.md`:
```markdown
---
inclusion: always
---

# Project-Specific Overrides

## Override: Reduced Test Coverage
For this legacy project, we accept 60% coverage instead of 80%:
- Unit tests: ≥60% coverage (override global 80%)
- Reason: Legacy codebase being incrementally improved

## Override: Larger File Limit
This monolith allows files up to 500 lines:
- Max file size: 500 lines (override global 300)
- Reason: Gradual refactoring in progress
```

### Disable a Hook

Rename or delete the hook file:
```bash
# Disable task hygiene check
mv .kiro/hooks/task-hygiene.kiro.hook .kiro/hooks/task-hygiene.kiro.hook.disabled
```

### Merge Behavior

Kiro merges configurations:
1. **Steering files**: All `inclusion: always` files are combined
2. **fileMatch steering**: Only applies when pattern matches
3. **Hooks**: Each hook runs independently
4. **Templates**: All templates are available

## Backup & Sync Setup

### Version Control Your Config

```bash
# This repo IS your version-controlled config
cd ~/KiroSpecs
git add .
git commit -m "feat: update Kiro global profile"
git push
```

### Sync to Another Machine

```bash
# On new machine
git clone <this-repo-url> ~/KiroSpecs

# Install to projects using symlinks
~/KiroSpecs/install-kiro-profile.sh --symlink /path/to/project
```

### Dotfiles Integration

```bash
# Add to your dotfiles repo
ln -s ~/KiroSpecs ~/.dotfiles/kiro

# In dotfiles install script
ln -s ~/.dotfiles/kiro ~/KiroSpecs
```

## Kiro Settings Configuration

### Enable Hooks (if needed)

1. Open Kiro IDE
2. Open Settings: `Cmd/Ctrl + ,`
3. Search for "kiro hooks"
4. Ensure hooks are enabled

### Configure Agent Behavior

In `.kiro/settings/mcp.json`:
```json
{
  "mcpServers": {
    "fetch": {
      "command": "npx",
      "args": ["-y", "@anthropic-ai/mcp-fetch"],
      "disabled": false,
      "autoApprove": ["fetch"]
    }
  }
}
```

## Troubleshooting

### Problem: Hooks not firing
**Solution:**
1. Restart Kiro IDE completely
2. Check hook file extension is `.kiro.hook`
3. Verify patterns match your file paths

### Problem: Steering rules ignored
**Solution:**
1. Check YAML frontmatter syntax
2. Verify `inclusion: always` or matching `fileMatchPattern`
3. Try referencing steering manually: `#global` in chat

### Problem: Templates not appearing
**Solution:**
1. Check templates are in `.kiro/templates/`
2. Verify `.md` extension
3. Restart Kiro IDE

### Problem: Permission denied on install script
**Solution:**
```bash
chmod +x install-kiro-profile.sh
```

## Customization Guide

### Adding a New Steering File

1. Create file in `.kiro/steering/`:
```markdown
---
inclusion: always
---

# My Custom Rules

[Your rules here]
```

2. For language-specific rules:
```markdown
---
inclusion: fileMatch
fileMatchPattern: "**/*.go"
---

# Go Standards

[Go-specific rules]
```

### Adding a New Hook

1. Create file in `.kiro/hooks/my-hook.kiro.hook`:
```yaml
name: My Custom Hook
description: What this hook does

when:
  type: fileEdit
  patterns:
    - "src/**/*.ts"

then:
  type: askAgent
  prompt: |
    Your prompt to the agent here.
    Can be multi-line.
```

### Adding a New Template

1. Create file in `.kiro/templates/my-template.md`
2. Use placeholder syntax: `[Field Name]`
3. Template will appear in `Kiro: New Spec`

## Core Disciplines Enforced

### 1. Living Architecture Documentation
- `architecture.md` steering requires docs updates with code changes
- `architecture-sync.kiro.hook` detects drift automatically
- C4 model templates in `design.md`

### 2. Prioritized Backlog Management
- `backlog.md` enforces "no task, no code" rule
- `task-hygiene.kiro.hook` validates task context
- MoSCoW prioritization in task templates

### 3. Functional Decomposition
- `decomposition.md` sets size limits (300 lines/file, 50 lines/function)
- `component-check.kiro.hook` validates boundaries
- Clean architecture layers enforced

## Success Criteria

You're done when:
- [ ] `.kiro/` exists in your project
- [ ] Opening a new project shows steering rules active
- [ ] Templates appear in `Kiro: New Spec`
- [ ] Hooks fire on file changes (check Kiro output)
- [ ] You can override globals when needed
- [ ] Config is backed up in git

## License

MIT - Use and modify freely.
