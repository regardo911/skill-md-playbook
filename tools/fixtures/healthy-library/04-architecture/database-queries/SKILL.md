---
name: database-queries
description: Use this skill when writing or modifying database access code. Enforces Prisma-only access, explicit column selection, an index per foreign key, transactions for multi-table writes, and no queries inside a loop.
paths:
  - "src/db/**/*.ts"
  - "prisma/**"
---

# Database Queries

## Trigger
When writing or modifying database access code.

## Instructions
- Prisma client only. No raw SQL outside migrations
- Select the columns you need. Never a bare findMany()
- Every foreign key gets an index in the same migration that creates it
- Transactions for anything that writes to more than one table

## Constraints
- No queries inside a loop. Batch or join
