---
name: testing
description: Use this skill when writing or modifying Python test files. Enforces pytest as the framework, src-mirroring file paths, test_-prefixed function names, fixtures for shared setup, parametrize for similar cases, and specific-value assertions over truthiness.
paths:
  - "tests/**/*.py"
  - "**/test_*.py"
---

<!-- testing (pytest) - Chapter 4, the stack-swap example. Same skill, same path, different stack. Install this one OR the Vitest one, never both. -->

# Testing Standards

## Trigger
When writing or modifying test files.

## Instructions
- Framework: pytest (never use unittest)
- Test file location: mirror source path
  src/utils/format.py → tests/utils/test_format.py
- Naming: test functions start with test_ followed by
  descriptive name: test_validate_email_rejects_missing_domain
- Each function gets minimum 3 tests:
  1. Happy path with typical input
  2. Error case (None, empty, invalid type)
  3. Edge case (boundary values, unicode, large inputs)
- Use pytest fixtures for shared setup
- Use parametrize for 3+ similar test cases
- Assert on specific values, not truthiness
  Bad: assert result
  Good: assert result == 'validated'

## Constraints
- Do not import from unittest
- Do not use mock.patch unless the dependency is external (API, DB)
- Do not test private functions (prefix _) directly
