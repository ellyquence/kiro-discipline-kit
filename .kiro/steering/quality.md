---
inclusion: always
---

# Quality Gates and Standards

## Phase Quality Gates

### Gate 1: Requirements Complete
- [ ] User stories follow template
- [ ] All acceptance criteria are testable (EARS format)
- [ ] Edge cases documented
- [ ] Non-functional requirements specified
- [ ] Stakeholder approval recorded

### Gate 2: Design Approved
- [ ] Architecture fits existing patterns
- [ ] Component boundaries defined
- [ ] Interfaces documented
- [ ] Data models specified
- [ ] Security review complete
- [ ] Performance considerations documented
- [ ] Failure modes identified

### Gate 3: Implementation Ready
- [ ] Tasks decomposed to M or smaller
- [ ] Dependencies unblocked
- [ ] Test strategy defined
- [ ] Environment configured

### Gate 4: Code Complete
- [ ] All acceptance criteria implemented
- [ ] Unit tests pass (≥80% coverage)
- [ ] Integration tests pass
- [ ] No linting errors or warnings
- [ ] Documentation updated
- [ ] Security scan clean

### Gate 5: Release Ready
- [ ] E2E tests pass
- [ ] Performance benchmarks met
- [ ] Rollback procedure documented
- [ ] Monitoring/alerting configured
- [ ] Stakeholder sign-off

## Testing Requirements by Layer

| Layer | Coverage | Test Type |
|-------|----------|-----------|
| Domain | ≥90% | Unit |
| Application | ≥80% | Unit + Integration |
| Adapters | ≥70% | Integration |
| E2E Flows | Critical paths | E2E |

## Documentation Requirements

### Code Documentation
- Public APIs: JSDoc/docstrings required
- Complex logic: Inline comments explaining WHY
- Non-obvious decisions: Link to ADR

### Project Documentation
- README.md: Setup, run, deploy instructions
- CONTRIBUTING.md: Development workflow
- CHANGELOG.md: Version history
- API docs: OpenAPI/AsyncAPI specs

## Review Checkpoints

### Self-Review Checklist
- [ ] Code compiles without warnings
- [ ] Tests pass locally
- [ ] No hardcoded secrets or credentials
- [ ] Error handling is complete
- [ ] Logging is appropriate (not excessive)
- [ ] No TODO comments for critical logic

### Peer Review Focus Areas
1. Logic correctness
2. Edge case handling
3. Security vulnerabilities
4. Performance implications
5. Maintainability
6. Test coverage adequacy

## Completion Criteria
A feature is DONE when:
1. All acceptance criteria pass
2. Quality gates satisfied
3. Documentation complete
4. Deployed to staging successfully
5. Product owner accepts
