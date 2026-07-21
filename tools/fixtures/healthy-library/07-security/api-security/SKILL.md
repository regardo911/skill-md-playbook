---
name: api-security
description: Use this skill when reviewing or modifying authentication, request validation, or anything that touches a token in src/api/. Enforces zod validation on every body, bearer-only auth at the middleware, rate limits on public endpoints, and parameterised queries.
paths:
  - "src/api/**/*.ts"
  - "src/middleware/**/*.ts"
---

# API Security

## Trigger
When reviewing or modifying auth, validation, or token handling.

## Instructions
- Validate every request body with zod. No exceptions for internal routes
- Bearer tokens only. Reject anything else at the middleware
- Rate limit public endpoints at 60 rpm per IP
- Parameterised queries only, no string interpolation into SQL

## Constraints
- Never log tokens, passwords, or full request bodies
