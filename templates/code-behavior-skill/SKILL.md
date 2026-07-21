---
name: [skill-name]
description: [One specific sentence about when this skill applies and what it enforces. Example: "Use this skill when writing or editing TypeScript files in src/api/. Enforces our API response shape, error envelope, and rate-limit conventions."]
paths:
  - "[optional: glob to scope auto-activation, e.g. src/api/**/*.ts]"
---

<!-- Appendix C, Template 1 - Code Behavior. Copy the directory, rename it for your skill, fill in the brackets. Delete the paths: block entirely if the skill should be available for any task. -->

# [Skill Name]

## Trigger
[When does this skill apply? Examples: "Always active for TypeScript source",
"When writing or editing API route handlers", "When working in src/api/"]

## Instructions
- [Specific rule 1]
- [Specific rule 2]
- [Specific rule 3]
- [Add more as needed, keep under 15 rules]

## Constraints
- [What should Claude NOT do?]
- [What patterns should Claude avoid?]

## Example
Bad:
  [Show what wrong output looks like]

Good:
  [Show what correct output looks like]
