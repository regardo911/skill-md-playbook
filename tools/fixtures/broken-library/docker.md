# Docker

- Multi-stage builds. Builder stage installs dev deps, runtime stage does not
- Pin the base image by digest, not by tag
- Non-root user in the runtime stage
- One process per container
- .dockerignore mirrors .gitignore plus node_modules and coverage
