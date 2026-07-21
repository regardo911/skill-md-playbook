---
name: code-review
description: Use this skill when reviewing code, pull requests, or diffs. Prioritizes bugs and security over style. Issues stated in one sentence with risk and a specific fix. Praise suppressed. Top-5 limit. Includes self-evaluation criteria the user can prompt against on demand.
---

<!-- code-review (upgraded) - Chapter 6. Same path as the Chapter 4 skill; this version replaces it. The three new sections below are the whole upgrade. -->

# Code Review

## Trigger
When reviewing code or pull requests.

## Instructions
- Focus on bugs, security, and performance (in that order)
- State each issue in one sentence
- Include a specific fix with code
- Limit to 5 highest-priority items

## Self-Evaluation Criteria
When the user explicitly asks you to evaluate this skill's output, assess:
1. Did the review catch a real bug? (not just style)
2. Did each suggested fix compile and make sense in context?
3. Were any obvious issues missed that the developer later flagged manually?

## Update Conventions
When the user explicitly asks you to propose edits to this skill, follow these conventions:
- If the review consistently misses a category of bug (e.g., race conditions),
  the proposal should add that category to the priority checklist
- If a suggested fix was wrong, the proposal should add the correction as
  an example in the Examples section
- Maximum skill file size: 60 lines. If a proposed addition would exceed
  this, the proposal must remove the least-useful existing rule first to make room
- Output the proposed edits as a unified diff the user can review and apply

## Manual Workflow Notes
- This skill does NOT modify itself. It only generates proposed edits when prompted.
- The user runs the workflow on demand, reads the proposal, and applies it manually
  (or asks Claude to apply it after explicit approval).
