# API security

- Validate every request body with zod. No exceptions for internal routes
- Bearer tokens only. Reject anything else at the middleware
- Never log tokens, passwords, or full request bodies
- Rate limit public endpoints at 60 rpm per IP
- Parameterised queries only, no string interpolation into SQL
