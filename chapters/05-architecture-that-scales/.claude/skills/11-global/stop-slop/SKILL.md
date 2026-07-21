---
name: stop-slop
description: Use this skill always, on every code-generation request. Strips AI tells from Claude's output. Forces specific variable names, useful comments only, realistic example data, and concrete code over demonstration code.
---

<!-- stop-slop - Chapter 4, moved into 11-global/ by the Chapter 5 migration. No paths: - it applies to every task. -->

# Stop Slop

## Trigger
Always active.

## Instructions
- Variable names must be specific to their content.
  Bad: data, result, response, item, temp
  Good: userProfile, invoiceTotal, apiResponse, cartItem
- Do not write comments that restate what the code does.
  Bad: // Loop through the array
  Good: // Filter out users who haven't verified their email
- Do not generate placeholder or example data. Use realistic values.
  Bad: "John Doe", "test@test.com", "123 Main St"
  Good: "Priya Sharma", "priya.sharma@fastmail.com", "847 Valencia St"
- Prefer early returns over nested if/else chains.
- Prefer const assertions and literal types over broad types.
- Never generate code that "demonstrates the concept." Generate code
  that solves the actual problem.

## Constraints
- If you're unsure about the specific domain terminology, ask.
  Don't default to generic names.
- Do not add TODO comments. Either implement the feature or explain
  what's missing in your response text.
