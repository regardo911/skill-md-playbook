---
name: project-memory
description: Use this skill always for any task in this project. Carries the tech stack, the architecture decisions and their reasoning, and the current sprint context so Claude does not need re-briefing each session.
---

# Project Memory

## Trigger
Always active.

## Project Context
- Next.js 14 App Router, Postgres via Prisma, NextAuth, deployed on Vercel

## Key Decisions
- tRPC over REST, the team is TypeScript-only
- Zustand over Redux, global state is small

## Active Context
- Pages Router to App Router migration, about half done
