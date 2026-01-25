# Threat Model: [Feature/System Name]

**Date:** YYYY-MM-DD
**Author:** @username
**Reviewers:** @security-team
**Status:** Draft | In Review | Approved

---

## 1. System Overview

### Description
[2-3 sentences describing what this system/feature does]

### Assets to Protect
| Asset | Classification | Description |
|-------|----------------|-------------|
| User credentials | Critical | Passwords, API keys, tokens |
| PII | High | Names, emails, addresses |
| Business data | Medium | Orders, transactions |
| [Add more] | [Level] | [Description] |

### Trust Boundaries
```
┌─────────────────────────────────────────────────────────────┐
│                    INTERNET (Untrusted)                      │
├─────────────────────────────────────────────────────────────┤
│                    ┌───────────────────┐                    │
│                    │   Load Balancer   │                    │
│                    │   (DMZ)           │                    │
│                    └─────────┬─────────┘                    │
├──────────────────────────────┼──────────────────────────────┤
│              INTERNAL NETWORK (Trusted)                      │
│                    ┌─────────┴─────────┐                    │
│                    │   Application     │                    │
│                    │   Server          │                    │
│                    └─────────┬─────────┘                    │
│                              │                               │
│                    ┌─────────┴─────────┐                    │
│                    │   Database        │                    │
│                    │   (Most Trusted)  │                    │
│                    └───────────────────┘                    │
└─────────────────────────────────────────────────────────────┘
```

---

## 2. Data Flow Diagram

```
┌──────────┐     HTTPS      ┌──────────┐     Internal     ┌──────────┐
│  User    │ ─────────────► │   API    │ ───────────────► │    DB    │
│ Browser  │ ◄───────────── │  Server  │ ◄─────────────── │          │
└──────────┘   JSON/JWT     └──────────┘    SQL/TLS       └──────────┘
                                  │
                                  │ API Call
                                  ▼
                            ┌──────────┐
                            │ External │
                            │ Service  │
                            └──────────┘
```

### Data Flow Table
| # | From | To | Data | Protocol | Authenticated |
|---|------|-----|------|----------|---------------|
| 1 | User | API | Credentials | HTTPS | No (login) |
| 2 | API | DB | User query | TLS | Yes (service) |
| 3 | API | External | Payment data | HTTPS | Yes (API key) |

---

## 3. STRIDE Analysis

### S - Spoofing Identity

| Threat | Target | Impact | Likelihood | Mitigation |
|--------|--------|--------|------------|------------|
| Stolen JWT token | API | Impersonation | Medium | Short expiry, refresh rotation |
| Credential stuffing | Login | Account takeover | High | Rate limiting, MFA |
| Session hijacking | Browser | Account takeover | Medium | Secure cookies, fingerprinting |
| [Add threats] | | | | |

### T - Tampering with Data

| Threat | Target | Impact | Likelihood | Mitigation |
|--------|--------|--------|------------|------------|
| SQL injection | Database | Data modification | Medium | Parameterized queries |
| Man-in-the-middle | Network | Data interception | Low | TLS 1.3, cert pinning |
| Request tampering | API | Price manipulation | Medium | Server-side validation |
| [Add threats] | | | | |

### R - Repudiation

| Threat | Target | Impact | Likelihood | Mitigation |
|--------|--------|--------|------------|------------|
| Denied transactions | Audit | Dispute resolution | Medium | Immutable audit logs |
| Log tampering | Logging | Evidence destruction | Low | Centralized logging, WORM |
| [Add threats] | | | | |

### I - Information Disclosure

| Threat | Target | Impact | Likelihood | Mitigation |
|--------|--------|--------|------------|------------|
| Error message leakage | API | System info exposure | High | Generic error responses |
| Verbose logging | Logs | PII in logs | Medium | Log sanitization |
| Unencrypted storage | Database | Data breach | Low | Encryption at rest |
| [Add threats] | | | | |

### D - Denial of Service

| Threat | Target | Impact | Likelihood | Mitigation |
|--------|--------|--------|------------|------------|
| API flooding | API Server | Service unavailable | High | Rate limiting, WAF |
| Resource exhaustion | Database | Slow queries | Medium | Query limits, timeouts |
| [Add threats] | | | | |

### E - Elevation of Privilege

| Threat | Target | Impact | Likelihood | Mitigation |
|--------|--------|--------|------------|------------|
| IDOR vulnerability | API | Data access | High | Object-level authorization |
| Missing function auth | Admin API | Admin access | Medium | Role-based access control |
| Privilege escalation | User roles | Elevated permissions | Medium | Strict role validation |
| [Add threats] | | | | |

---

## 4. Risk Assessment Matrix

| Risk ID | Threat | Severity | Likelihood | Risk Score | Priority |
|---------|--------|----------|------------|------------|----------|
| R-001 | [Threat name] | High | Medium | 6 | P1 |
| R-002 | [Threat name] | Medium | High | 6 | P1 |
| R-003 | [Threat name] | Low | Low | 2 | P3 |

**Scoring:**
- Severity: Critical=4, High=3, Medium=2, Low=1
- Likelihood: High=3, Medium=2, Low=1
- Risk Score = Severity × Likelihood
- Priority: 9-12=P0, 6-8=P1, 3-5=P2, 1-2=P3

---

## 5. Mitigation Plan

### Immediate Actions (P0/P1)

| Risk ID | Mitigation | Owner | Due Date | Status |
|---------|------------|-------|----------|--------|
| R-001 | [Action] | @dev | YYYY-MM-DD | TODO |
| R-002 | [Action] | @dev | YYYY-MM-DD | TODO |

### Planned Improvements (P2/P3)

| Risk ID | Mitigation | Owner | Target Release |
|---------|------------|-------|----------------|
| R-003 | [Action] | @dev | v2.1 |

---

## 6. Security Controls Checklist

### Authentication
- [ ] Multi-factor authentication available
- [ ] Secure password policy enforced
- [ ] Account lockout after failed attempts
- [ ] Session timeout configured

### Authorization
- [ ] Role-based access control implemented
- [ ] Object-level authorization on all endpoints
- [ ] Principle of least privilege applied

### Data Protection
- [ ] Encryption in transit (TLS 1.2+)
- [ ] Encryption at rest for sensitive data
- [ ] PII handling compliant with regulations

### Logging & Monitoring
- [ ] Security events logged
- [ ] Alerting configured for anomalies
- [ ] Log retention policy defined

---

## 7. Residual Risks

| Risk | Description | Accepted By | Date |
|------|-------------|-------------|------|
| [Risk] | [Why it's acceptable] | @security-lead | YYYY-MM-DD |

---

## 8. Review Schedule

- **Next Review:** YYYY-MM-DD
- **Review Triggers:**
  - Major architecture changes
  - New external integrations
  - Security incident
  - Annually at minimum

---

## Approval

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Developer | | | |
| Security | | | |
| Product Owner | | | |
