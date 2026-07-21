---
name: api-patterns
description: Use this skill when designing or modifying HTTP route handlers under src/api/. Covers routing shape, the response envelope, status-code policy and pagination. Security rules live in the api-security skill, not here.
paths:
  - "src/api/**/*.ts"
---

# API Patterns

## Trigger
When designing or modifying a route handler.

## Instructions
- REST, plural nouns, no verbs in paths
- Every handler returns { data, error } - never a bare value
- 4xx for client mistakes, 5xx only when we broke something
- Paginate with cursor, not offset

## Constraints
- Do not add auth or validation rules here. That is the api-security skill's scope
