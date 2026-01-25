---
inclusion: always
---

# Global Engineering Standards

## Core Philosophy
This project follows spec-driven development with proactive documentation. **Never start coding without a clear task from the backlog.** All changes require linked requirements and updated architecture docs.

## File Organization
```
src/
├── domain/          # Pure business logic, no external dependencies
├── application/     # Use cases, orchestration
├── ports/           # Interface definitions (contracts)
├── adapters/        # External service implementations
├── shared/          # Cross-cutting utilities
└── tests/           # Mirror src/ structure
```

## Naming Conventions
- **Files**: kebab-case (`user-service.ts`, `auth_handler.py`)
- **Classes/Types**: PascalCase (`UserService`, `AuthHandler`)
- **Functions/Variables**: camelCase (TS) or snake_case (Python)
- **Constants**: SCREAMING_SNAKE_CASE
- **Test files**: `*.test.ts` or `*_test.py`

## Error Handling Patterns
1. **Fail fast**: Validate inputs at boundaries
2. **Typed errors**: Use discriminated unions (TS) or custom exceptions (Python)
3. **No silent failures**: Always log or propagate
4. **Graceful degradation**: Define fallback behavior for external dependencies

## Testing Requirements
- Unit tests required for all domain logic
- Integration tests for adapter implementations
- E2E tests for critical user flows
- Minimum **80% coverage** for core packages

## Git Workflow
- **Conventional commits**: `type(scope): description`
- Types: feat, fix, docs, refactor, test, chore
- Branch naming: `type/ticket-id-short-description`
- All PRs require spec reference in description

## Definition of Done
- [ ] Code implements all acceptance criteria
- [ ] Tests pass with required coverage
- [ ] Documentation updated (if API changes)
- [ ] Architecture docs reflect changes
- [ ] PR approved by at least one reviewer
- [ ] No new linting warnings
