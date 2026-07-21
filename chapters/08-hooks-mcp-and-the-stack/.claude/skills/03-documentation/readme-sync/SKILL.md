---
name: readme-sync
description: Use this skill when reviewing changes to exported functions in TypeScript source files. Compares the current README.md API section with the exported functions in the changed files. Flags signature changes that didn't propagate to the README.
paths:
  - "src/**/*.ts"
---

<!-- readme-sync - Chapter 8, the simpler pipeline. Needs no MCP server: just this skill and settings/readme-sync-on-edit.json. Start here. -->

# README Sync

## Trigger
When reviewing changes to exported functions.

## Instructions
- Compare the current README.md API section with the exported
  functions in the changed files
- Flag any function that was added, removed, or had its
  signature changed but is not reflected in the README
- Suggest specific README edits with the exact markdown to add
  or update

## Constraints
- Only check exported/public functions
- Do not rewrite the entire README, only flag differences
- Do not suggest changes for internal helper functions
