---
name: testing
description: "Use this skill when writing or modifying test files in this project. Enforces [CLIENT: framework] as the framework, [CLIENT: their file-path convention], [CLIENT: their structure], and specific-value assertions over truthiness."
paths:
  - "[CLIENT: their test-file glob, e.g. **/*.test.ts]"
---

<!-- testing - Chapter 9. Note that paths: is a [CLIENT: ...] marker too. Getting that glob wrong is the single most common reason a client's testing skill never fires. -->

# Testing Standards

## Trigger
When writing or modifying test files.

## Instructions
- Framework: [CLIENT: e.g. Vitest, import from 'vitest', not 'jest']
- Test file location: [CLIENT: mirror source path? separate tests/ tree? co-located?]
  [CLIENT: give one worked example, e.g. src/utils/format.ts → tests/utils/format.test.ts]
- Structure: [CLIENT: describe()/it()? test()? table-driven?]
- Naming: [CLIENT: their test-name template]
- Each function gets minimum [CLIENT: how many?] tests:
  1. Happy path with typical input
  2. Error/edge case (null, empty, boundary values)
  3. Integration behavior (how it interacts with dependencies)
- Mock external dependencies with [CLIENT: their mocking API]
- Never mock the function being tested
- Assert on specific values, not truthiness

## Constraints
- Do not import from [CLIENT: the framework they migrated away from]
- [CLIENT: snapshot-test policy]
- Do not test private functions directly; test them through
  the public API
