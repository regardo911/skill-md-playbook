---
name: documentation
description: Use this skill when writing or modifying source files. Controls when JSDoc applies (exported functions and classes), required tags (@param, @returns, @throws), what to skip (private helpers under 10 lines, obvious getters/setters), and inline-comment policy (WHY not WHAT).
---

<!-- documentation - Chapter 4, moved into 03-documentation/ by the Chapter 5 migration. -->

# Documentation

## Trigger
When writing or modifying source files.

## Instructions
- Add JSDoc to all exported functions and classes
- Required tags: @param (with type), @returns, @throws (if applicable)
- Add @example for any function with non-obvious usage
- Skip documentation for:
  - Private helper functions under 10 lines
  - Obvious getters/setters
  - Test files
- README updates: if a new feature changes the public API,
  add it to the relevant section in README.md
- Inline comments: only when the WHY is non-obvious.
  Never comment WHAT the code does.

## Example
Bad:
  /** Gets the user */
  export function getUser(id: string): User

Good:
  /**
   * Fetches a user profile from the cache, falling back to
   * the database if the cache entry is stale (>5 min).
   * @param id - UUID of the user
   * @returns The user profile, or null if not found
   * @throws {DatabaseError} If the connection pool is exhausted
   * @example
   * const user = await getUser('a1b2c3')
   * if (!user) redirect('/login')
   */
  export async function getUser(id: string): Promise<User | null>
