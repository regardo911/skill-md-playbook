---
name: error-handling
description: Use this skill when writing error paths, catch blocks, or logging. Enforces one custom error class per domain, throw-early/catch-at-the-boundary, structured error logs carrying the request id, and no internals in user-facing messages.
---

# Error Handling

## Trigger
When writing error paths, catch blocks, or logging.

## Instructions
- Custom error classes extending AppError, one per domain
- Throw early, catch at the route boundary
- Every catch either handles or rethrows
- Log with the request id attached, level=error, structured JSON

## Constraints
- Never swallow an error
- User-facing messages never leak internals
