---
inclusion: fileMatch
fileMatchPattern: "**/*.py"
---

# Python Standards

## Python Version and Configuration
- Python 3.11+ required
- Type hints mandatory for all public functions
- pyproject.toml for project configuration

## Type Hints (Strict Mode)
```python
from typing import TypeVar, Generic, Protocol
from dataclasses import dataclass

# Use modern type hints
def process_user(user_id: str, options: dict[str, Any] | None = None) -> User:
    ...

# Protocols for interfaces
class Repository(Protocol):
    def get(self, id: str) -> Model | None: ...
    def save(self, entity: Model) -> None: ...

# Generic types for reusable patterns
T = TypeVar('T')

@dataclass
class Result(Generic[T]):
    success: bool
    data: T | None
    error: str | None
```

## Error Handling Pattern
```python
from dataclasses import dataclass
from typing import TypeVar, Generic

T = TypeVar('T')

@dataclass
class Success(Generic[T]):
    data: T

@dataclass
class Failure:
    error: str
    code: str

Result = Success[T] | Failure

# Usage
def get_user(user_id: str) -> Result[User]:
    user = repo.find(user_id)
    if user is None:
        return Failure(error="User not found", code="NOT_FOUND")
    return Success(data=user)
```

## Project Structure
```
src/
├── domain/           # Pure business logic
│   ├── models/       # Domain entities
│   ├── services/     # Domain services
│   └── errors.py     # Domain exceptions
├── application/      # Use cases
├── ports/            # Abstract interfaces
├── adapters/         # External implementations
└── main.py           # Application entry
tests/
├── unit/             # Unit tests
├── integration/      # Integration tests
└── conftest.py       # Shared fixtures
```

## Testing Framework: pytest
```python
import pytest
from unittest.mock import Mock, AsyncMock

class TestUserService:
    @pytest.fixture
    def mock_repo(self) -> Mock:
        return Mock(spec=UserRepository)

    @pytest.fixture
    def service(self, mock_repo: Mock) -> UserService:
        return UserService(repository=mock_repo)

    def test_create_user_with_valid_data(
        self, service: UserService, mock_repo: Mock
    ) -> None:
        # Arrange
        mock_repo.save.return_value = None

        # Act
        result = service.create_user(name="Test", email="test@example.com")

        # Assert
        assert result.success
        assert result.data.name == "Test"
```

## Linting and Formatting
- **Ruff** for linting (replaces flake8, isort, black)
- **mypy** for type checking (strict mode)
- **pytest** with coverage plugin

```toml
# pyproject.toml
[tool.ruff]
line-length = 88
select = ["E", "F", "I", "N", "W", "UP", "B", "C4", "SIM"]

[tool.mypy]
strict = true
warn_return_any = true
disallow_untyped_defs = true
```

## Import Organization
```python
# 1. Standard library
import os
from datetime import datetime
from typing import Any

# 2. Third-party packages
import httpx
from pydantic import BaseModel

# 3. Local application
from src.domain.models import User
from src.ports.repository import UserRepository
```

## Dependency Injection
```python
# Use protocols and constructor injection
class UserService:
    def __init__(
        self,
        repository: UserRepository,
        event_bus: EventBus,
        logger: Logger,
    ) -> None:
        self._repository = repository
        self._event_bus = event_bus
        self._logger = logger
```
