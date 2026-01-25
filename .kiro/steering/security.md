---
inclusion: always
---

# DevSecOps Security Standards

## Core Principle: Shift Left Security
Security is integrated at every phase of development, not bolted on at the end. Every developer owns security for their code.

## OWASP Top 10:2025 Prevention

### A01: Broken Access Control (Priority: Critical)
```typescript
// REQUIRED: Object-level authorization on every data access
async function getResource(userId: string, resourceId: string) {
  const resource = await db.findById(resourceId);

  // ALWAYS verify ownership/permissions
  if (resource.ownerId !== userId && !hasPermission(userId, resource)) {
    throw new ForbiddenError('Access denied');
  }

  return resource;
}
```

**Rules:**
- Deny by default - require explicit grants
- Validate permissions on EVERY request, not just UI
- Use role-based or attribute-based access control
- Log all access control failures
- Rate limit to prevent enumeration attacks

### A02: Security Misconfiguration (Priority: Critical)
**Required checks:**
- [ ] No default credentials in any environment
- [ ] Debug/development features disabled in production
- [ ] Security headers configured (CSP, HSTS, X-Frame-Options)
- [ ] Error messages don't expose stack traces or internals
- [ ] Unnecessary features/endpoints disabled
- [ ] Cloud permissions follow least privilege

### A03: Software Supply Chain Failures (Priority: High)
**Dependency management:**
- Pin exact versions (no floating ^/~)
- Run `npm audit` / `pip-audit` on every build
- Review new dependencies before adding
- Use lockfiles and verify checksums
- Monitor for CVEs in dependencies
- Maintain SBOM (Software Bill of Materials)

### A04: Cryptographic Failures (Priority: High)
**Required practices:**
```typescript
// Use strong, modern algorithms
const APPROVED_ALGORITHMS = {
  symmetric: 'aes-256-gcm',      // NOT aes-128-cbc
  hash: 'sha256',                // NOT md5 or sha1
  password: 'argon2id',          // NOT bcrypt with low rounds
  asymmetric: 'rsa-oaep-256',    // Minimum 2048-bit keys
};

// NEVER hardcode secrets
const apiKey = process.env.API_KEY;  // NOT: const apiKey = "sk-123..."
```

**Rules:**
- Encrypt sensitive data at rest AND in transit
- Use TLS 1.3 (minimum TLS 1.2)
- Rotate keys and secrets regularly
- Use secrets manager (Vault, AWS Secrets Manager)

### A05: Injection (Priority: High)
**Prevention patterns:**
```typescript
// SQL: Use parameterized queries ALWAYS
const user = await db.query(
  'SELECT * FROM users WHERE id = $1',  // Good: parameterized
  [userId]
);
// NEVER: `SELECT * FROM users WHERE id = ${userId}`

// Command injection: Avoid shell execution
import { execFile } from 'child_process';
execFile('convert', [inputFile, outputFile]);  // Good: no shell
// NEVER: exec(`convert ${inputFile} ${outputFile}`);

// XSS: Context-aware output encoding
const safeHtml = DOMPurify.sanitize(userInput);
```

### A06: Insecure Design (Priority: Medium)
**Requirements:**
- Threat model new features before implementation
- Document trust boundaries in design.md
- Define abuse cases alongside use cases
- Rate limit sensitive operations
- Implement defense in depth

### A07: Authentication Failures (Priority: High)
**Required controls:**
- Multi-factor authentication for sensitive operations
- Secure password requirements (NIST 800-63B)
- Account lockout after failed attempts
- Secure session management
- Invalidate sessions on logout/password change

```typescript
// Password requirements
const PASSWORD_POLICY = {
  minLength: 12,
  maxLength: 128,
  requireComplexity: false,  // NIST: length > complexity
  checkBreached: true,       // Check against known breaches
};
```

### A08: Software/Data Integrity Failures (Priority: Medium)
- Verify signatures on all dependencies
- Use Subresource Integrity (SRI) for CDN assets
- Validate data integrity with checksums
- Secure CI/CD pipeline credentials

### A09: Security Logging & Alerting Failures (Priority: Medium)
**Required logging:**
```typescript
// Log security-relevant events
logger.security({
  event: 'AUTH_FAILURE',
  userId: attemptedUserId,
  ip: request.ip,
  userAgent: request.headers['user-agent'],
  timestamp: new Date().toISOString(),
});
```

**Events to log:**
- Authentication successes and failures
- Authorization failures
- Input validation failures
- Application errors and exceptions
- Admin/privileged operations

### A10: Mishandling of Exceptional Conditions (Priority: Medium)
```typescript
// Fail securely
try {
  await processPayment(order);
} catch (error) {
  // Log the real error internally
  logger.error('Payment failed', { error, orderId: order.id });

  // Return generic message to user
  throw new UserFacingError('Payment could not be processed');

  // NEVER: throw new Error(`Payment failed: ${error.message}`);
}
```

## Input Validation Standards

### Validation Rules
1. **Validate on server** - Never trust client-side validation alone
2. **Allowlist over denylist** - Define what IS allowed, reject everything else
3. **Validate type, length, format, range** - All four, every time
4. **Reject invalid input** - Don't try to "fix" malicious input

```typescript
import { z } from 'zod';

// Define strict schemas
const UserInputSchema = z.object({
  email: z.string().email().max(254),
  name: z.string().min(1).max(100).regex(/^[a-zA-Z\s\-']+$/),
  age: z.number().int().min(0).max(150),
});

// Validate at system boundaries
function createUser(input: unknown) {
  const validated = UserInputSchema.parse(input);  // Throws if invalid
  return db.users.create(validated);
}
```

### Output Encoding
- HTML context: HTML entity encoding
- JavaScript context: JavaScript encoding
- URL context: URL encoding
- CSS context: CSS encoding
- Use templating engines with auto-escaping

## Secret Management

### Never Commit Secrets
```gitignore
# .gitignore - REQUIRED entries
.env
.env.*
*.pem
*.key
*credentials*
*secret*
config/local.*
```

### Secret Patterns to Detect
```
# API Keys
AWS: AKIA[0-9A-Z]{16}
GitHub: ghp_[a-zA-Z0-9]{36}
Stripe: sk_live_[a-zA-Z0-9]{24}
Generic: [a-zA-Z0-9]{32,}

# Private Keys
-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----

# Passwords in code
password\s*=\s*["'][^"']+["']
secret\s*=\s*["'][^"']+["']
```

## Security Testing Requirements

### Pre-Commit
- [ ] Secret scanning (gitleaks/detect-secrets)
- [ ] Linting for security anti-patterns

### CI Pipeline
- [ ] SAST scan (SonarQube, Semgrep, CodeQL)
- [ ] Dependency vulnerability scan (npm audit, Snyk)
- [ ] Container image scan (Trivy, Grype)
- [ ] License compliance check

### Pre-Deploy
- [ ] DAST scan on staging (OWASP ZAP)
- [ ] Security review for high-risk changes
- [ ] Penetration testing for major releases

## Compliance Checklist
- [ ] PII identified and protected
- [ ] Data retention policies implemented
- [ ] User consent mechanisms in place
- [ ] Right to deletion supported
- [ ] Audit logs retained appropriately
- [ ] Encryption key management documented
