# Style (v2 - use this one)

Agreed in the Feb architecture call, supersedes style.md.

- 2 space indent
- No semicolons anywhere. Prettier is configured with semi: false
- Arrow functions everywhere, including module scope
- Single quotes
- Import order: packages, then @/ aliases, then relative. Blank line between groups
- Named exports only. We removed the last default export in the router refactor
