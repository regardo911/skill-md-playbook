---
name: [skill-name]
description: [One specific sentence about the skill's job AND the self-evaluation it supports on demand. Example: "Use this skill when reviewing code or pull requests. Prioritizes bugs and security. Includes self-evaluation criteria the user can prompt against to refine the skill over time."]
---

<!-- Appendix C, Template 2 - Self-Improvement Workflow. Use sparingly: build 3-5 standard skills first, then upgrade your most-used one. The 60-line cap is the guardrail, not a suggestion. -->

# [Skill Name]

## Trigger
[When does this skill apply?]

## Instructions
- [Your base rules]

## Self-Evaluation Criteria
When the user explicitly asks you to evaluate this skill's output, assess:
1. [Specific question about output quality, binary if possible]
2. [Specific question about missed cases]
3. [Specific question about accuracy]

## Update Conventions
When the user explicitly asks you to propose edits to this skill, follow these conventions:
- If [condition], the proposal should add [specific rule type] to Instructions
- Maximum file size: 60 lines
- Before adding a rule, the proposal must remove the least-useful existing rule
  if the file is at the limit
- Output proposed edits as a unified diff for the user to review

## Manual Workflow Notes
- This skill does NOT modify itself. The user runs the evaluation/proposal
  prompts on demand and approves edits manually.
