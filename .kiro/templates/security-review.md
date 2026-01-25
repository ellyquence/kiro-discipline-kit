# Security Code Review Checklist

**PR/Change:** [Link or description]
**Reviewer:** @username
**Date:** YYYY-MM-DD
**Risk Level:** Low | Medium | High | Critical

---

## Pre-Review Context

### Change Summary
[Brief description of what this change does]

### Security-Relevant Areas
- [ ] Authentication/Authorization
- [ ] User input handling
- [ ] Data storage/retrieval
- [ ] External API calls
- [ ] Cryptography
- [ ] File operations
- [ ] Admin/privileged functions
- [ ] None of the above

---

## 1. Input Validation

### Checklist
- [ ] All user inputs validated on server-side
- [ ] Allowlist validation used (not denylist)
- [ ] Input length limits enforced
- [ ] Special characters properly handled
- [ ] File uploads validated (type, size, content)

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 2. Output Encoding

### Checklist
- [ ] HTML output properly escaped
- [ ] JSON responses use proper serialization
- [ ] URLs properly encoded
- [ ] No `dangerouslySetInnerHTML` without sanitization
- [ ] No `eval()` or `Function()` with user data

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 3. Authentication

### Checklist
- [ ] Passwords hashed with strong algorithm (Argon2, bcrypt 10+)
- [ ] Session tokens are cryptographically random
- [ ] Sessions invalidated on logout
- [ ] Password reset tokens expire quickly
- [ ] MFA implemented for sensitive operations

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 4. Authorization

### Checklist
- [ ] Every endpoint checks authorization
- [ ] Object-level authorization verified
- [ ] Role checks use centralized mechanism
- [ ] No authorization logic in client-side only
- [ ] Admin functions properly protected

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 5. Data Protection

### Checklist
- [ ] Sensitive data encrypted at rest
- [ ] TLS used for all external communications
- [ ] PII not logged
- [ ] Secrets not hardcoded
- [ ] Proper key management used

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 6. SQL/NoSQL Injection

### Checklist
- [ ] Parameterized queries used
- [ ] No string concatenation in queries
- [ ] ORM used correctly
- [ ] Stored procedures validated

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 7. API Security

### Checklist
- [ ] Rate limiting implemented
- [ ] Request size limits enforced
- [ ] CORS configured correctly
- [ ] Security headers present
- [ ] API keys/tokens not exposed in URLs

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 8. Error Handling

### Checklist
- [ ] Errors don't expose stack traces
- [ ] Generic messages for auth failures
- [ ] Exceptions properly caught
- [ ] Fail securely (deny on error)

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 9. Logging

### Checklist
- [ ] Security events logged (auth, access failures)
- [ ] No sensitive data in logs
- [ ] Log injection prevented
- [ ] Correlation IDs for tracing

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## 10. Dependencies

### Checklist
- [ ] No known vulnerabilities in dependencies
- [ ] Dependencies from trusted sources
- [ ] Versions pinned
- [ ] Minimal permissions requested

### Findings
| Dependency | CVE | Severity | Action |
|------------|-----|----------|--------|
| | | | |

---

## 11. Business Logic

### Checklist
- [ ] Race conditions prevented
- [ ] Transaction integrity maintained
- [ ] Price/quantity manipulation prevented
- [ ] Workflow bypasses blocked

### Findings
| Line | Issue | Severity | Notes |
|------|-------|----------|-------|
| | | | |

---

## Summary

### Statistics
- Total issues found: X
- Critical: X
- High: X
- Medium: X
- Low: X

### Blocking Issues
| # | Issue | Line | Must fix before merge |
|---|-------|------|----------------------|
| 1 | | | Yes / No |

### Recommendations
1. [Recommendation 1]
2. [Recommendation 2]

---

## Decision

- [ ] **APPROVED** - No security issues found
- [ ] **APPROVED WITH NOTES** - Minor issues, can merge with follow-up
- [ ] **CHANGES REQUESTED** - Issues must be fixed before merge
- [ ] **REJECTED** - Significant security concerns, needs redesign

**Comments:**
[Additional notes for the developer]

---

**Reviewer Signature:** _________________ Date: _________
