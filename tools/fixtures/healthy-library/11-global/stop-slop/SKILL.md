---
name: stop-slop
description: Use this skill always, on every code-generation request. Forces content-specific variable names, useful comments only, realistic sample values, early returns, and code that solves the problem instead of demonstrating it.
---

# Stop Slop

## Trigger
Always active.

## Instructions
- Name variables for what they hold. Not data, result, response, item, temp
- No comments that restate the code
- Realistic sample values, never John Doe or test@test.com
- Early returns over nested branches
- Write the code that solves it, not the code that demonstrates it

## Constraints
- No TODO comments. Implement it or say what's missing in the reply
