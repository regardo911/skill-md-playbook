# Error handling

- Custom error classes extending AppError, one per domain
- Throw early, catch at the route boundary
- Every catch either handles or rethrows. Never swallow
- Log with the request id attached, level=error, structured JSON
- User-facing messages never leak internals
