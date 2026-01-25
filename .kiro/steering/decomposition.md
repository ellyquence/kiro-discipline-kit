---
inclusion: always
---

# Functional Decomposition Standards

## Component Boundary Rules

### When to Create a New Component
1. **Single Responsibility**: Component does ONE thing well
2. **Cohesion**: Internal elements highly related
3. **Coupling**: Minimal dependencies on other components
4. **Testability**: Can be tested in isolation
5. **Context Window**: Entire component fits in AI context (~500 lines max)

### Component Structure
```
component-name/
├── index.ts          # Public API exports only
├── types.ts          # Type definitions
├── component.ts      # Main implementation
├── component.test.ts # Unit tests
├── utils.ts          # Internal utilities (if needed)
└── README.md         # Component documentation
```

## Size Constraints

| Element | Max Lines | Action if Exceeded |
|---------|-----------|-------------------|
| File | 300 | Split by responsibility |
| Function/Method | 50 | Extract sub-functions |
| Component | 500 | Decompose into sub-components |
| Class | 200 | Apply SRP, extract collaborators |
| Test file | 400 | Split by test category |

## Interface Documentation Requirements
Every public interface requires:

```typescript
/**
 * Brief description of purpose.
 *
 * @example
 * ```typescript
 * const result = await myFunction(input);
 * ```
 *
 * @param input - Description of input
 * @returns Description of return value
 * @throws {ErrorType} When condition occurs
 */
```

## Shared vs Component-Specific Code

### Goes in `shared/`
- Utility functions used by 3+ components
- Cross-cutting concerns (logging, auth, errors)
- Common type definitions
- Configuration management

### Stays Component-Specific
- Business logic for that domain
- Component-specific types
- Internal utilities used only here

## Coupling Rules
1. **Domain** depends on nothing
2. **Application** depends only on Domain and Ports
3. **Adapters** implement Ports, may use external libs
4. **No circular dependencies** between components

## When to Split a Component
Split when ANY of these occur:
- File exceeds 300 lines
- More than 5 public exports
- Changes to one feature require touching unrelated code
- Test setup becomes complex
- Multiple distinct responsibilities emerge

## Interface Contract Documentation
For each public interface, document in component README:
- Input types and validation rules
- Output types and possible values
- Error conditions and recovery
- Performance characteristics
- Thread/async safety guarantees
