---
name: skill-generator
description: Use this skill when the user says "create a new skill for X" or similar. Drafts a properly-structured SKILL.md (with YAML frontmatter and body) for the user to review and save. Does NOT modify the filesystem on its own.
---

<!-- skill-generator - Chapter 6. This is the skill that writes your other skills. Install it early. -->

# Skill Generator

## Trigger
When the user says "create a new skill for [X]" or similar.

## Instructions
When asked to draft a new skill:

1. Ask for clarification only if the request is genuinely ambiguous.
   If the intent is clear, proceed without questions.
2. Determine the appropriate category folder (01-style through
   11-global) based on the skill's purpose.
3. Output a complete SKILL.md draft with these parts:
   - YAML frontmatter at the top: `name:` (lowercase, hyphenated)
     and `description:` (one specific sentence about when this skill
     applies and what it enforces). Add `paths:` if the skill should
     auto-activate based on file globs.
   - A `# Skill Name` heading
   - Trigger section (when does this skill apply, in prose)
   - Instructions (specific, actionable rules)
   - Constraints (what the skill should NOT do)
   - Example (at least one before/after pair)
4. Keep the body under 40 lines.
5. Check the user's existing skills folder for naming overlap or
   description-field overlap. If overlap exists, note it and suggest
   either modifying the existing skill or sharpening the new skill's
   description field to scope away from the conflict.
6. Output the proposed file path (e.g., `.claude/skills/04-architecture/graphql-resolvers/SKILL.md`)
   and the full file contents inside a code block, so the user can save it manually.
7. Do NOT write to the filesystem on your own. The user reviews the draft
   and saves it.

## Constraints
- Never propose a skill that duplicates an existing skill.
  If the request overlaps with an existing skill, suggest
  modifying the existing one instead.
- Never propose a skill with vague instructions like "write
  good code" or "be helpful." Every instruction must be
  specific and testable.
- Always include YAML frontmatter with at minimum a `description:` field.
  A skill without `description:` won't be auto-invoked by Claude.
