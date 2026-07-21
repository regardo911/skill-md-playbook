# API patterns

Routing and shape:
- REST, plural nouns, no verbs in paths
- Every handler returns { data, error } - never a bare value
- 4xx for client mistakes, 5xx only when we broke something
- Paginate with cursor, not offset

Auth and validation (moved here temporarily, belongs in api-security):
- Every route validates its body with zod before touching the db
- Bearer token in the Authorization header, checked in middleware
- Never log the token
