---
name: project-memory
description: Use this skill always for any task in this project. Carries the tech stack, key architectural decisions and the reasoning behind them, and the active sprint context so Claude doesn't need to be re-briefed every session.
---

<!-- project-memory - Chapter 6. The contents below are the book's own example project, not yours. Replace every line before you use it, or use the blank version at templates/memory-skill.SKILL.md instead. -->

# Project Memory

## Trigger
Always active.

## Project Context
- Framework: Next.js 14 (App Router)
- Database: PostgreSQL via Prisma (schema in prisma/schema.prisma)
- Auth: NextAuth v5 with custom JWT strategy (config in lib/auth.ts)
- State management: Zustand (stores in lib/stores/)
- API: tRPC with Zod validation (routers in server/routers/)
- Deployment: Vercel (config in vercel.json)
- CI: GitHub Actions (workflows in .github/workflows/)

## Key Decisions (and why)
- We chose tRPC over REST because we're a TypeScript-only team
  and the end-to-end type safety eliminates a class of bugs.
- We chose Zustand over Redux because global state is minimal;
  most state lives in server components.
- Auth tokens expire after 15 minutes. Refresh tokens expire
  after 7 days. This is intentional for security compliance.

## Active Context
- Current sprint: migrating from Pages Router to App Router
  (50% complete, /app/ directory has new routes, /pages/ has legacy)
- Known issues: race condition in auth refresh on concurrent
  requests (tracked in issue #247)
- Recent changes: added rate limiting to all API routes (see PR #312)
