---
inclusion: always
---

# Prioritized Backlog Management

## Cardinal Rule
**Never start coding without a task from the backlog.** Every code change traces to a requirement.

## Task Format (Required Fields)
```markdown
## TASK-XXX: [Title]

**Priority**: P0 | P1 | P2 | P3 (MoSCoW: Must/Should/Could/Won't)
**Complexity**: XS | S | M | L | XL (context-window fit)
**Status**: TODO | IN_PROGRESS | BLOCKED | DONE
**Assignee**: @username
**Spec**: .kiro/specs/[feature]/requirements.md#AC-X.X

### Description
[What needs to be done and why]

### Acceptance Criteria
- [ ] AC1: [Measurable outcome]
- [ ] AC2: [Measurable outcome]

### Dependencies
- Blocked by: TASK-YYY
- Blocks: TASK-ZZZ

### Definition of Ready
- [ ] Requirements reviewed and approved
- [ ] Design document exists
- [ ] Dependencies identified and unblocked
- [ ] Complexity estimated
```

## MoSCoW Prioritization

| Priority | Label | Description | SLA |
|----------|-------|-------------|-----|
| P0 | MUST | Critical path, blocks release | Same sprint |
| P1 | SHOULD | Important, high business value | Next 2 sprints |
| P2 | COULD | Nice to have, lower priority | Backlog |
| P3 | WON'T | Explicitly deferred | Not scheduled |

## Task Granularity Rules
- **XS**: < 1 hour, single function change
- **S**: 1-4 hours, single component
- **M**: 4-8 hours, multiple related components (fits in context window)
- **L**: 1-2 days, cross-cutting concern (split into M tasks)
- **XL**: > 2 days, MUST be decomposed before starting

**Rule**: No task larger than M should be in "IN_PROGRESS"

## Dependency Tracking
1. Before starting a task, verify all blockers resolved
2. Update dependent tasks when completing prerequisites
3. Flag circular dependencies immediately

## Scope Change Rules
1. New requirements go through spec process first
2. Scope creep during implementation → create new task
3. Changes to acceptance criteria require spec update
4. Document scope changes in task comments

## Daily Backlog Hygiene
- Review IN_PROGRESS tasks for staleness (> 2 days)
- Update blocked tasks with blocker status
- Ensure next 3 tasks are READY
