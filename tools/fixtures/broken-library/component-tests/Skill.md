---
name: component-tests
description: Use this skill when writing tests for React components. Enforces Testing Library queries by role, no shallow rendering, and one assertion per behaviour.
---

# Component Tests

## Trigger
When writing or modifying component test files.

## Instructions
- Query by role, then by label, then by text. Never by test id
- Render the real component. No shallow rendering
- One behaviour per it() block
- Assert on what the user sees, not on props or state
