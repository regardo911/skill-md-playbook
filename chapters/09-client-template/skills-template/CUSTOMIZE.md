# Customize

Ask these in the kickoff call. Write the answers straight into the skill files. Every question maps to one
`[CLIENT: ...]` marker, and the whole list takes about twenty minutes if you have someone technical on the call.

Make customization mechanical, not creative. You're transcribing their existing conventions, not designing
new ones.

## Style: `01-style/code-style/SKILL.md`

1. Which languages and file extensions does this skill cover?
2. Indentation: spaces or tabs, how many?
3. Single or double quotes?
4. Trailing commas in multi-line literals?
5. Named exports only, or are default exports allowed anywhere?
6. What's the import-group order, and are the groups separated by blank lines?
7. File naming convention, with one real filename as the example.
8. Which type or construct is banned outright?
9. Paste one snippet from a recent PR that got corrected in review, plus the correction. That's your
   Bad/Good example, and it's worth more than the other eight answers combined.

## Testing: `02-testing/testing/SKILL.md`

10. Which framework, and which one did you migrate away from? (The second half matters: Claude reaches for
    the old one unless you name it.)
11. Where do test files live relative to source? Give one worked path pair.
12. What's the test-name template?
13. Minimum tests per function?
14. What's the mocking API?
15. Snapshot tests: allowed, discouraged, or banned?
16. What's the test-file glob? This becomes `paths:` and it's the one that silently breaks the skill if
    it's wrong.

## The other four skills

The book's Chapter 4 set (`documentation`, `git-commits`, `code-review`, `stop-slop`) ships unmodified in
`chapters/05-architecture-that-scales/`. Copy them in and generalize the same way: find every sentence that
names a decision, replace it with a `[CLIENT: ...]` marker, ask the question, write the answer back.

Two of them barely need it. `stop-slop` is about generic-sounding output, which is universal, and it usually
ships as-is. `code-review` needs one addition: their severity language, so the review reads like their team
wrote it.

## Sign-off

```bash
grep -r "\[CLIENT:" .claude/skills/
```

Nothing should come back. Then run the compound test from Chapter 4 on their actual codebase and show them
the output on the call. Don't describe the difference. Put both versions on screen.
