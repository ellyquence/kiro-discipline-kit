# [Feature Name] Requirements

## Overview
[2-3 sentence description of the feature and its value proposition]

## User Personas
- **Primary**: [Who is the main user?]
- **Secondary**: [Other stakeholders affected]

---

## User Stories

### US-001: [Story Title]
**As a** [persona]
**I want to** [capability]
**So that** [benefit]

#### Acceptance Criteria (EARS Notation)

**AC 1.1: [Happy Path]**
WHEN [user action/system event]
THE SYSTEM SHALL [expected behavior]

**AC 1.2: [Validation]**
WHEN [invalid input or state]
THE SYSTEM SHALL [error handling behavior]

**AC 1.3: [Edge Case]**
WHILE [precondition state]
WHEN [trigger event]
THE SYSTEM SHALL [expected behavior]

---

### US-002: [Story Title]
**As a** [persona]
**I want to** [capability]
**So that** [benefit]

#### Acceptance Criteria

**AC 2.1: [Scenario Name]**
WHEN [condition]
THE SYSTEM SHALL [behavior]

---

## Functional Requirements

### FR-001: [Requirement Title]
**Priority**: P0 | P1 | P2 | P3
**Persona**: [Primary user affected]

WHEN [trigger event]
THE SYSTEM SHALL [specific, testable behavior]

**Rationale**: [Why this requirement exists]

---

## Non-Functional Requirements

### NFR-001: Performance
THE SYSTEM SHALL [respond/process] within [X milliseconds/seconds]
WHILE handling [Y concurrent users/requests]

### NFR-002: Availability
THE SYSTEM SHALL maintain [X]% uptime
WHEN [normal operating conditions]

### NFR-003: Security
THE SYSTEM SHALL [security requirement using EARS pattern]

---

## Data Requirements

### DR-001: [Entity Name]
THE SYSTEM SHALL store:
- [field1]: [type] - [description]
- [field2]: [type] - [description]

THE SYSTEM SHALL retain data for [duration/policy]

---

## Out of Scope
- [Explicitly excluded feature 1]
- [Explicitly excluded feature 2]

## Open Questions
- [ ] [Unresolved question 1]
- [ ] [Unresolved question 2]

## Stakeholder Approval
- [ ] Product Owner: _________ Date: _____
- [ ] Tech Lead: _________ Date: _____
