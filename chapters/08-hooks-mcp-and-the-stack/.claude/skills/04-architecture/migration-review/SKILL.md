---
name: migration-review
description: Use this skill when reviewing or modifying database migration files in `migrations/`. Compares the migration SQL against the current schema (fetched via the project-db MCP server). Checks for missing indexes on foreign keys, NOT NULL gaps, breaking column changes, and absent rollback scripts.
paths:
  - "migrations/**/*.sql"
---

<!-- migration-review - Chapter 8. Half of a three-part pipeline: this skill, settings/migration-review-on-edit.json, mcp/project-db.json. -->

# Migration Review

## Trigger
When reviewing database migration files.

## Instructions
- Compare the migration SQL against the current database schema
  (available via the project-db MCP server)
- Check for: missing indexes on foreign keys, columns that should
  have NOT NULL but don't, breaking changes to existing columns
- Flag any migration that drops a column without a data migration plan
- Verify that the migration has a corresponding down/rollback script

## Constraints
- Do not suggest schema changes beyond what the migration intends
- Do not run the migration. Only review it.
