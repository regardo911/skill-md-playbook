---
name: docker
description: Use this skill when writing or modifying a Dockerfile, .dockerignore, or container build config. Enforces multi-stage builds, digest-pinned base images, a non-root runtime user, and one process per container.
paths:
  - "**/Dockerfile*"
  - "**/.dockerignore"
---

# Docker

## Trigger
When writing or modifying container build config.

## Instructions
- Multi-stage builds. Builder stage installs dev deps, runtime stage does not
- Pin the base image by digest, not by tag
- Non-root user in the runtime stage
- One process per container
- .dockerignore mirrors .gitignore plus node_modules and coverage
