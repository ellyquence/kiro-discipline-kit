---
inclusion: always
---

# Living Architecture Documentation

## When to Update Architecture Docs
Update `.kiro/specs/[feature]/design.md` when:
- Adding new external dependencies or services
- Changing data flow between components
- Modifying API contracts
- Adding new infrastructure components
- Changing security boundaries

## Required Architecture Sections (C4 Model)

### Level 1: System Context
- System boundaries and external actors
- Integration points with external systems
- Data flows across trust boundaries

### Level 2: Container Diagram
- Applications, services, databases
- Technology choices for each container
- Communication protocols

### Level 3: Component Diagram (per container)
- Internal modules and their responsibilities
- Dependency graph between components
- Interface definitions

## Architecture Decision Records (ADRs)
Store in `.kiro/specs/architecture/decisions/`

Every significant technical decision requires an ADR:
- Framework/library selections
- Data storage choices
- API design patterns
- Security model changes
- Performance trade-offs

ADR format: Use `.kiro/templates/decision-record.md`

## Drift Detection Rules
Flag architecture drift when:
1. Import from `adapters/` into `domain/` (layer violation)
2. Direct external calls from `domain/` (should go through ports)
3. New dependencies not listed in design.md
4. Undocumented environment variables
5. New API endpoints without OpenAPI spec update

## External Dependencies Documentation
For each external dependency, document:
- Purpose and justification
- Version constraints and update policy
- Failure modes and fallback behavior
- SLA expectations
- Data classification (PII, confidential, public)

## Observability Requirements
All services must expose:
- Health check endpoint
- Structured logging with correlation IDs
- Metrics: latency, error rate, throughput
- Distributed tracing integration
