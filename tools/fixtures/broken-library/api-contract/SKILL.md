---
name: api-contract
description: Use this skill when editing API route handlers. Enforces our envelope format (status(code): body), 200-line file cap, and error-first returns.
---

# API Contract

## Trigger
When editing files under src/api/.

## Instructions
- Wrap every response in the standard envelope
- Return errors before success paths
- Keep handlers under 200 lines
