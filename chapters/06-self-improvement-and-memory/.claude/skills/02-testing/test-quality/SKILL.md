---
name: test-quality
description: Use this skill when writing or modifying test files. Enforces describe/it structure, three minimum tests per function (happy path, error case, edge case), specific-value assertions, and mocking external dependencies only. Includes self-evaluation criteria the user can prompt against.
paths:
  - "**/*.test.ts"
  - "tests/**/*.ts"
---

<!-- test-quality - Chapter 6, the second self-improvement target. Cap is 50 lines here, not 60. The escalation rule at the end of Update Conventions is the interesting part. -->

# Test Quality

## Trigger
When writing tests.

## Instructions
- Use describe/it structure grouped by function
- Each function gets happy path, error case, edge case
- Assert on specific values
- Mock external dependencies only

## Self-Evaluation Criteria
When the user explicitly asks you to evaluate the test output you generated, assess:
1. Did any test pass trivially (assert true or assert not null)?
2. Did any test miss a clear edge case visible in the function?
3. Were any tests redundant (testing the same behavior twice)?

## Update Conventions
When the user explicitly asks you to propose edits to this skill, follow these conventions:
- If trivial tests were generated, the proposal should add the specific
  pattern to avoid in the Instructions section
- If edge cases are consistently missed for a type of function
  (e.g., functions with optional params), the proposal should add that as
  a checklist item
- Maximum 50 lines. The proposal must remove the least-useful rule when
  the skill is near the limit
- If the same gap appears in three of your evaluations across different sessions,
  escalate to the developer with a "structural issue suspected" note instead
  of proposing yet another rule

## Manual Workflow Notes
- This skill does NOT modify itself. The user runs the evaluation/proposal
  prompts on demand and approves edits manually.
