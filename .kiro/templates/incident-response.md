# Security Incident Response Runbook

**Incident ID:** INC-YYYY-XXXX
**Severity:** SEV1 (Critical) | SEV2 (High) | SEV3 (Medium) | SEV4 (Low)
**Status:** Detected | Investigating | Contained | Eradicated | Recovered | Closed

---

## Incident Summary

| Field | Value |
|-------|-------|
| **Date Detected** | YYYY-MM-DD HH:MM UTC |
| **Detected By** | [Person/System] |
| **Incident Type** | [Data Breach / Unauthorized Access / Malware / DDoS / Other] |
| **Affected Systems** | [List systems] |
| **Incident Commander** | @username |
| **Current Status** | [Status] |

### Brief Description
[2-3 sentence summary of what happened]

---

## 1. Detection & Initial Assessment

### How Was It Detected?
- [ ] Automated alerting
- [ ] User report
- [ ] Security scan
- [ ] Third-party notification
- [ ] Other: _______________

### Initial Indicators of Compromise (IOCs)
| Type | Value | Source |
|------|-------|--------|
| IP Address | | |
| Domain | | |
| File Hash | | |
| User Account | | |
| API Key | | |

### Severity Assessment

**Impact:**
- [ ] Data breach (PII, credentials, financial)
- [ ] Service disruption
- [ ] Unauthorized access
- [ ] Compliance violation
- [ ] Reputational damage

**Scope:**
- [ ] Single user affected
- [ ] Multiple users affected
- [ ] All users potentially affected
- [ ] External parties affected

---

## 2. Containment (Immediate Actions)

### Checklist
- [ ] **Isolate affected systems** (network segmentation, disable access)
- [ ] **Revoke compromised credentials** (API keys, tokens, passwords)
- [ ] **Block malicious IPs/domains** (firewall, WAF rules)
- [ ] **Preserve evidence** (logs, memory dumps, disk images)
- [ ] **Notify incident response team**
- [ ] **Enable enhanced logging**

### Actions Taken
| Time | Action | Performed By | Result |
|------|--------|--------------|--------|
| HH:MM | | @username | |
| HH:MM | | @username | |

### Credentials Revoked
| Credential Type | Identifier | Status |
|-----------------|------------|--------|
| API Key | key_xxxx | Revoked |
| User Password | user@example.com | Reset |
| Service Account | | |

---

## 3. Investigation

### Timeline of Events
| Time (UTC) | Event | Source | Notes |
|------------|-------|--------|-------|
| | First suspicious activity | | |
| | | | |
| | Incident detected | | |

### Root Cause Analysis
**What happened:**
[Detailed description]

**How it happened:**
[Attack vector, vulnerability exploited]

**Why it happened:**
[Contributing factors, gaps in controls]

### Affected Data

| Data Type | Records Affected | Encryption Status |
|-----------|------------------|-------------------|
| User emails | | |
| Passwords | | Hashed with bcrypt |
| PII | | |
| Financial | | |

### Attack Vector
```
[Diagram or description of how the attack progressed]

1. Initial Access: [How attacker got in]
2. Persistence: [How they maintained access]
3. Lateral Movement: [How they spread]
4. Exfiltration: [How data was stolen]
```

---

## 4. Eradication

### Checklist
- [ ] Remove attacker access
- [ ] Patch exploited vulnerabilities
- [ ] Remove malware/backdoors
- [ ] Reset all potentially compromised credentials
- [ ] Update security rules
- [ ] Verify removal with scans

### Vulnerabilities Patched
| Vulnerability | System | Fix Applied | Verified |
|---------------|--------|-------------|----------|
| | | | [ ] |

---

## 5. Recovery

### Checklist
- [ ] Restore systems from clean backups
- [ ] Verify system integrity
- [ ] Re-enable disabled services
- [ ] Monitor closely for re-infection
- [ ] Validate security controls

### Recovery Steps
| Step | Description | Status | Verified By |
|------|-------------|--------|-------------|
| 1 | | [ ] | |
| 2 | | [ ] | |

---

## 6. Notification Requirements

### Internal Notifications
| Role | Notified | Time | Method |
|------|----------|------|--------|
| CISO | [ ] | | |
| Legal | [ ] | | |
| PR/Comms | [ ] | | |
| Executive Team | [ ] | | |

### External Notifications
| Party | Required | Deadline | Notified | Notes |
|-------|----------|----------|----------|-------|
| Affected Users | [ ] | | [ ] | |
| Regulators (GDPR) | [ ] | 72 hours | [ ] | |
| Law Enforcement | [ ] | | [ ] | |
| Partners/Vendors | [ ] | | [ ] | |

### Notification Templates
**User Notification:**
```
Subject: Important Security Notice from [Company]

Dear [User],

We are writing to inform you of a security incident that may have affected your account...

What happened: [Brief description]
What we're doing: [Actions taken]
What you should do: [Password reset, monitor accounts]

Questions? Contact security@company.com
```

---

## 7. Lessons Learned

### What Went Well
- [List positive aspects of response]

### What Could Be Improved
- [List areas for improvement]

### Action Items
| # | Action | Owner | Due Date | Status |
|---|--------|-------|----------|--------|
| 1 | Implement [control] | @username | YYYY-MM-DD | TODO |
| 2 | Update [process] | @username | YYYY-MM-DD | TODO |
| 3 | Train team on [topic] | @username | YYYY-MM-DD | TODO |

---

## 8. Evidence Preservation

### Preserved Artifacts
| Artifact | Location | Hash (SHA256) | Preserved By |
|----------|----------|---------------|--------------|
| Server logs | s3://evidence/... | | |
| Memory dump | | | |
| Disk image | | | |

### Chain of Custody
| Date | Item | From | To | Purpose |
|------|------|------|-----|---------|
| | | | | |

---

## 9. Incident Closure

### Closure Checklist
- [ ] Root cause identified and documented
- [ ] All vulnerabilities remediated
- [ ] Affected users notified (if required)
- [ ] Regulatory notifications complete
- [ ] Lessons learned documented
- [ ] Action items assigned and tracked
- [ ] Post-incident review conducted
- [ ] Documentation complete

### Final Report
**Total Duration:** X hours/days
**Total Impact:** [Description]
**Cost Estimate:** $X

---

## Approval

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Incident Commander | | | |
| Security Lead | | | |
| Legal | | | |

**Incident Closed:** YYYY-MM-DD HH:MM UTC
