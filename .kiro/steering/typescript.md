---
inclusion: fileMatch
fileMatchPattern: "**/*.{ts,tsx,js,jsx}"
---

# TypeScript/Node.js Standards

## TypeScript Configuration
```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  }
}
```

## Type Safety Rules
1. **Never use `any`** - use `unknown` and narrow with type guards
2. **Explicit return types** on public functions
3. **Discriminated unions** for state/result types
4. **Branded types** for domain identifiers
5. **Zod/io-ts** for runtime validation at boundaries

## Error Handling Pattern
```typescript
// Prefer Result types over throwing
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

// Domain errors as discriminated unions
type DomainError =
  | { type: 'NOT_FOUND'; id: string }
  | { type: 'VALIDATION'; field: string; message: string }
  | { type: 'CONFLICT'; resource: string };
```

## Import Organization
```typescript
// 1. Node.js built-ins
import { readFile } from 'fs/promises';

// 2. External packages
import { z } from 'zod';

// 3. Internal absolute imports
import { UserService } from '@/services/user';

// 4. Relative imports
import { helper } from './utils';
```

## Testing Framework: Vitest/Jest
```typescript
describe('UserService', () => {
  // Arrange
  const mockRepo = createMockUserRepository();
  const service = new UserService(mockRepo);

  it('should create user with valid data', async () => {
    // Arrange
    const input = { name: 'Test', email: 'test@example.com' };

    // Act
    const result = await service.createUser(input);

    // Assert
    expect(result.success).toBe(true);
    expect(result.data.id).toBeDefined();
  });
});
```

## Linting Rules (ESLint)
- `@typescript-eslint/recommended`
- `@typescript-eslint/strict`
- `import/order` for consistent imports
- `no-console` (use logger instead)
- `prefer-const`
- `no-var`

## Node.js Patterns
- **Async/await** over callbacks
- **Structured logging** with pino or winston
- **Graceful shutdown** handling
- **Health check endpoints** for all services
- **Environment validation** at startup with Zod
