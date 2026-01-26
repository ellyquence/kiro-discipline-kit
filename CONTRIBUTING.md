# Contributing to Kiro Discipline Kit

Thank you for your interest in contributing! This project enforces engineering disciplines through Kiro IDE configuration.

## Ways to Contribute

- **Report issues** — Found a bug in a hook or steering file?
- **Suggest disciplines** — Ideas for new engineering practices
- **Add steering files** — Language-specific or domain-specific rules
- **Create hooks** — Automated enforcement checks
- **Improve templates** — Spec templates for common patterns

## Getting Started

1. **Fork** this repository
2. **Clone** your fork locally
3. **Create a branch**: `git checkout -b feature/my-improvement`
4. **Make changes** and test in Kiro IDE
5. **Commit** with a clear message
6. **Push** and open a Pull Request

## File Structures

### Steering Files

```markdown
---
inclusion: always
# OR
inclusion: fileMatch
fileMatchPattern: "**/*.ts"
---

# Rule Category

## Rule Name
Clear description of the rule and why it matters.
```

### Hook Files

```yaml
name: Hook Name
description: What this hook enforces

when:
  type: fileEdit  # or: fileSave, fileCreate
  patterns:
    - "src/**/*.ts"

then:
  type: askAgent
  prompt: |
    Your enforcement prompt here.
```

### Templates

- Use `[Placeholder]` syntax for fill-in sections
- Include clear instructions as comments
- Follow existing template conventions

## Testing Your Changes

1. Install to a test project: `./install-kiro-profile.sh /path/to/test`
2. Open the project in Kiro IDE
3. Verify steering rules appear in chat context
4. Trigger hooks by creating/editing matching files
5. Confirm templates appear in "Kiro: New Spec"

## Code of Conduct

- Be respectful and constructive
- Focus on engineering practices, not preferences
- Provide rationale for suggested disciplines

## Questions?

Open an issue with the "question" label.
