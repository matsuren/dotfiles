---
paths:
  - "**/*.py"
  - "**/*.pyi"
---

# Python Testing

> This file extends [common/testing.md](../common/testing.md) with Python specific content.

## Framework

Use **pytest** as the testing framework.

## Coverage

```bash
pytest --cov=src --cov-report=term-missing
```

## pytest Fundamentals

### Basic Test Structure

Avoid test class if it's not necessary.

```python
import pytest

def test_addition():
    """Test basic addition."""
    assert 2 + 2 == 4

def test_list_append():
    """Test list append."""
    items = [1, 2, 3]
    items.append(4)
    assert 4 in items
    assert len(items) == 4
```
