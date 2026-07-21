---
name: component-structure
description: Use this skill when creating or modifying React components. Enforces one component per file, exported props interface, server-components-by-default, and no barrel files inside component folders.
paths:
  - "src/components/**/*.tsx"
---

# Component Structure

## Trigger
When creating or modifying a React component.

## Instructions
- One component per file, named the same as the file
- Props interface declared above the component, exported
- Server components by default. 'use client' only when there is state or an event handler
- Co-locate the component's test and its styles in the same folder

## Constraints
- No barrel index.ts inside component folders. It breaks tree shaking
