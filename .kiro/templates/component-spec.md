# [Component Name] Specification

**Location**: `src/[path]/[component-name]/`
**Owner**: @[username]
**Created**: [YYYY-MM-DD]
**Last Updated**: [YYYY-MM-DD]

---

## Purpose
[One paragraph explaining what this component does and why it exists]

## Responsibilities
- [Primary responsibility 1]
- [Primary responsibility 2]
- [Primary responsibility 3]

## Non-Responsibilities (explicitly excluded)
- [What this component does NOT do]
- [Responsibility delegated to another component]

---

## Public Interface

### Exports
```typescript
// Main exports from index.ts
export { ComponentService } from './service';
export type { ComponentConfig, ComponentResult } from './types';
```

### API Definition
```typescript
interface ComponentService {
  /**
   * Brief description of method.
   *
   * @param input - Description of input parameter
   * @returns Description of return value
   * @throws {ValidationError} When input is invalid
   * @throws {NotFoundError} When resource doesn't exist
   *
   * @example
   * ```typescript
   * const result = await service.doSomething({ id: '123' });
   * if (result.success) {
   *   console.log(result.data);
   * }
   * ```
   */
  doSomething(input: InputType): Promise<Result<OutputType>>;

  /**
   * Another method description.
   */
  anotherMethod(id: string): Promise<Entity | null>;
}
```

---

## Types

### Input Types
```typescript
interface InputType {
  requiredField: string;
  optionalField?: number;
}

// Validation constraints
// - requiredField: non-empty string, max 255 chars
// - optionalField: positive integer, max 1000
```

### Output Types
```typescript
interface OutputType {
  id: string;
  status: 'success' | 'pending' | 'failed';
  data: ProcessedData;
}
```

### Internal Types (not exported)
```typescript
// Document internal types that help understand implementation
interface InternalState {
  cache: Map<string, CacheEntry>;
  config: ResolvedConfig;
}
```

---

## State Management

### Stateless vs Stateful
[Is this component stateless or does it maintain state?]

### State Description (if stateful)
| State | Type | Purpose | Lifecycle |
|-------|------|---------|-----------|
| cache | Map | Performance optimization | Per-instance |
| config | Object | Runtime configuration | Initialization |

### State Invariants
- [Invariant 1: e.g., "Cache size never exceeds maxCacheSize"]
- [Invariant 2: e.g., "Config is immutable after initialization"]

---

## Dependencies

### Required Dependencies (injected)
| Dependency | Interface | Purpose |
|------------|-----------|---------|
| repository | IRepository | Data persistence |
| logger | ILogger | Structured logging |
| eventBus | IEventBus | Event publishing |

### External Dependencies (packages)
| Package | Version | Purpose |
|---------|---------|---------|
| zod | ^3.22 | Input validation |

### Peer Components
| Component | Interaction | Direction |
|-----------|-------------|-----------|
| AuthService | Validates tokens | Inbound call |
| NotificationService | Sends events | Outbound event |

---

## Error Handling

### Error Types Thrown
```typescript
class ComponentError extends Error {
  constructor(
    message: string,
    public readonly code: ErrorCode,
    public readonly details?: Record<string, unknown>
  ) {
    super(message);
  }
}

type ErrorCode =
  | 'VALIDATION_FAILED'
  | 'NOT_FOUND'
  | 'CONFLICT'
  | 'EXTERNAL_SERVICE_ERROR';
```

### Error Recovery
| Error | Recovery Strategy |
|-------|-------------------|
| VALIDATION_FAILED | Return error, no retry |
| NOT_FOUND | Return null or error based on context |
| EXTERNAL_SERVICE_ERROR | Retry with exponential backoff |

---

## Testing Strategy

### Unit Tests
**Location**: `[component]/[component].test.ts`

| Test Category | Coverage Target |
|---------------|-----------------|
| Happy paths | 100% |
| Validation | All constraints |
| Error handling | All error types |
| Edge cases | Identified cases |

### Test Fixtures
```typescript
// Standard test fixtures
const validInput: InputType = { requiredField: 'test' };
const invalidInput: InputType = { requiredField: '' };
```

### Mocking Strategy
- Mock all injected dependencies
- Use real implementations for pure utility functions
- Test error paths by configuring mock failures

---

## Performance Characteristics

### Time Complexity
| Operation | Complexity | Notes |
|-----------|------------|-------|
| doSomething | O(n) | Where n is input size |
| anotherMethod | O(1) | Direct lookup |

### Resource Usage
- Memory: [Expected memory footprint]
- Connections: [Database/network connections held]

### Caching
- [Caching strategy if applicable]
- [Cache invalidation rules]

---

## Thread/Async Safety

### Concurrency Model
[Describe how component handles concurrent access]

### Safe Operations
- [Operation 1]: Thread-safe, can be called concurrently
- [Operation 2]: Not thread-safe, requires external synchronization

---

## Configuration

### Required Configuration
```typescript
interface ComponentConfig {
  timeout: number;      // Request timeout in ms (default: 5000)
  maxRetries: number;   // Max retry attempts (default: 3)
  cacheSize: number;    // Max cache entries (default: 1000)
}
```

### Environment Variables
| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| COMPONENT_TIMEOUT | No | 5000 | Timeout in ms |

---

## Usage Examples

### Basic Usage
```typescript
import { ComponentService } from './component';
import { createRepository, createLogger } from '../infrastructure';

const service = new ComponentService({
  repository: createRepository(),
  logger: createLogger(),
});

const result = await service.doSomething({ requiredField: 'example' });
```

### Error Handling
```typescript
try {
  const result = await service.doSomething(input);
  if (!result.success) {
    // Handle business logic failure
    console.error(result.error);
  }
} catch (error) {
  if (error instanceof ComponentError) {
    // Handle component-specific error
    switch (error.code) {
      case 'VALIDATION_FAILED':
        // Handle validation error
        break;
    }
  }
  throw error; // Re-throw unexpected errors
}
```

---

## Changelog
| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | YYYY-MM-DD | Initial implementation |
