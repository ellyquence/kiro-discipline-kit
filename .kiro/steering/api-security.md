---
inclusion: fileMatch
fileMatchPattern: "**/api/**/*.{ts,js,py}"
---

# API Security Standards

## OWASP API Security Top 10 Prevention

### API1: Broken Object Level Authorization
```typescript
// ALWAYS check ownership/permissions before returning data
app.get('/api/users/:id/documents/:docId', async (req, res) => {
  const document = await db.documents.findById(req.params.docId);

  // Verify the document belongs to the authenticated user
  if (document.userId !== req.user.id) {
    logger.security('AUTHZ_FAILURE', { userId: req.user.id, docId: req.params.docId });
    return res.status(403).json({ error: 'Forbidden' });
  }

  return res.json(document);
});
```

**Rules:**
- Check authorization on EVERY object access
- Don't rely on obscure/random IDs for security
- Implement row-level security at database level when possible

### API2: Broken Authentication
**Required controls:**
```typescript
// Use standard authentication libraries
import { verifyToken } from '@auth/core';

// Rate limit authentication endpoints
app.use('/api/auth/*', rateLimit({
  windowMs: 15 * 60 * 1000,  // 15 minutes
  max: 10,                    // 10 attempts
  message: 'Too many attempts, try again later',
}));

// Validate JWT properly
function validateToken(token: string) {
  const decoded = verifyToken(token, {
    algorithms: ['RS256'],      // Specify allowed algorithms
    issuer: 'https://auth.example.com',
    audience: 'api.example.com',
  });

  if (decoded.exp < Date.now() / 1000) {
    throw new TokenExpiredError();
  }

  return decoded;
}
```

### API3: Broken Object Property Level Authorization
```typescript
// Define what fields users can update
const ALLOWED_UPDATE_FIELDS = ['name', 'email', 'preferences'];

app.patch('/api/users/:id', (req, res) => {
  // Filter to only allowed fields
  const updates = Object.keys(req.body)
    .filter(key => ALLOWED_UPDATE_FIELDS.includes(key))
    .reduce((obj, key) => ({ ...obj, [key]: req.body[key] }), {});

  // NEVER directly spread user input
  // BAD: db.users.update(req.params.id, req.body);
  db.users.update(req.params.id, updates);
});
```

### API4: Unrestricted Resource Consumption
```typescript
// Rate limiting configuration
const rateLimits = {
  public: { windowMs: 60000, max: 100 },     // 100/min for public
  authenticated: { windowMs: 60000, max: 1000 }, // 1000/min for auth'd
  sensitive: { windowMs: 60000, max: 10 },   // 10/min for sensitive ops
};

// Pagination limits
const MAX_PAGE_SIZE = 100;

app.get('/api/items', (req, res) => {
  const limit = Math.min(parseInt(req.query.limit) || 20, MAX_PAGE_SIZE);
  const items = await db.items.findMany({ take: limit });
  return res.json(items);
});
```

### API5: Broken Function Level Authorization
```typescript
// Role-based access control middleware
const requireRole = (roles: string[]) => (req, res, next) => {
  if (!roles.includes(req.user.role)) {
    logger.security('ROLE_VIOLATION', {
      userId: req.user.id,
      required: roles,
      actual: req.user.role
    });
    return res.status(403).json({ error: 'Insufficient permissions' });
  }
  next();
};

// Apply to admin endpoints
app.delete('/api/users/:id', requireRole(['admin']), deleteUser);
app.post('/api/system/config', requireRole(['admin']), updateConfig);
```

## Authentication Patterns

### OAuth 2.0 / OpenID Connect
```typescript
// Use proven libraries, never roll your own
import { OAuth2Client } from 'google-auth-library';

// Validate ID tokens properly
async function validateIdToken(token: string) {
  const ticket = await client.verifyIdToken({
    idToken: token,
    audience: CLIENT_ID,
  });

  const payload = ticket.getPayload();

  // Verify claims
  if (payload.iss !== 'https://accounts.google.com') {
    throw new InvalidTokenError('Invalid issuer');
  }

  return payload;
}
```

### API Key Management
```typescript
// API keys for machine-to-machine, NOT user auth
interface ApiKey {
  id: string;
  hashedKey: string;      // Store hashed, not plaintext
  scopes: string[];        // Limit permissions
  rateLimit: number;       // Per-key limits
  expiresAt: Date;         // Force rotation
  lastUsedAt: Date;        // Track usage
}

// Validate API keys
async function validateApiKey(key: string) {
  const hashed = hashKey(key);
  const apiKey = await db.apiKeys.findByHash(hashed);

  if (!apiKey || apiKey.expiresAt < new Date()) {
    throw new InvalidApiKeyError();
  }

  // Update last used
  await db.apiKeys.updateLastUsed(apiKey.id);

  return apiKey;
}
```

## Request/Response Security

### Request Validation
```typescript
import { z } from 'zod';

// Strict request schemas
const CreateOrderSchema = z.object({
  items: z.array(z.object({
    productId: z.string().uuid(),
    quantity: z.number().int().positive().max(100),
  })).min(1).max(50),
  shippingAddress: AddressSchema,
}).strict();  // Reject unknown properties

app.post('/api/orders', (req, res) => {
  const validated = CreateOrderSchema.parse(req.body);
  // Process only validated data
});
```

### Response Security
```typescript
// Remove sensitive fields from responses
const sanitizeUser = (user: User): PublicUser => ({
  id: user.id,
  name: user.name,
  email: user.email,
  // NEVER include: password, passwordHash, internalNotes, etc.
});

// Set security headers
app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('Content-Security-Policy', "default-src 'self'");
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
  next();
});
```

## Error Handling

```typescript
// Generic error responses for security failures
const securityErrors = {
  401: { error: 'Authentication required' },
  403: { error: 'Access denied' },
  404: { error: 'Resource not found' },  // Use for authz failures too
};

// Don't leak information in errors
app.use((err, req, res, next) => {
  // Log full error internally
  logger.error('API Error', {
    error: err,
    path: req.path,
    userId: req.user?.id
  });

  // Return generic message to client
  const status = err.statusCode || 500;
  const message = status === 500
    ? 'Internal server error'
    : err.message;

  res.status(status).json({ error: message });
});
```

## API Documentation Security

### OpenAPI Security Schemes
```yaml
components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT
    apiKey:
      type: apiKey
      in: header
      name: X-API-Key

security:
  - bearerAuth: []
```

### Document Security Requirements
```yaml
paths:
  /api/users/{id}:
    get:
      security:
        - bearerAuth: []
      x-security-requirements:
        - "User must own resource or have admin role"
        - "Rate limited: 100 requests/minute"
```
