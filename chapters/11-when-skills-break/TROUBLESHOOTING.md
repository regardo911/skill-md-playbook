# Troubleshooting card

Seven checks, in order. Stop at the first one that fails.

1. Is the skill a directory under `.claude/skills/` with a `SKILL.md` inside it?
2. Does that `SKILL.md` have a `description:` field in its YAML frontmatter?
3. Does `grep -r "[your rule]" .claude/skills/` show the rule in exactly one `SKILL.md`?
4. Are the conflicting skills' `description:` fields scoped to non-overlapping tasks?
5. Is each `paths:` glob narrow enough to avoid auto-invoking on unrelated files?
6. Are your hooks in `settings.json` with real event names and a matcher that targets the right tool calls?
7. Has Claude Code been updated recently? Check the changelog at `https://code.claude.com/docs/en/`.

If all seven pass and it still doesn't work, cut it down to one skill directory, one prompt, one expected
behaviour, and post that with your `claude --version` output. Someone has seen it.

## Symptom to command

| what you're seeing | run this |
|---|---|
| nothing loads at all | `tools/skill-doctor.sh .claude/skills` |
| one skill never fires | `head -10 .claude/skills/<cat>/<name>/SKILL.md` and read the `description:` |
| output flips between two rules | `tools/conflict-audit.sh .claude/skills <the word they argue about>` |
| a skill worked an hour ago, not now | nothing to run. that's auto-compaction. re-prompt to re-invoke |
| context feels tight | `tools/context-budget.sh .claude/skills` |
| a self-improvement round went wrong | `git log --oneline .claude/skills/<cat>/<name>/SKILL.md` |
| ...then restore it | `git checkout <commit> -- .claude/skills/<cat>/<name>/SKILL.md` |
| a hook is silent | append `2>&1 \| tee /tmp/hook.log` to the command and read the log |

## Things that are true and counter-intuitive

**enterprise > personal > project.** The more global location wins. A `code-style` in `~/.claude/skills/`
overrides the project's. Everyone guesses this backwards.

Folder names carry no priority. `11-global` doesn't outrank `01-style`; the numbers are for your `ls`.
Composition happens through `description:` and `paths:`, nowhere else.

Compaction drops old skill invocations. When a long session compacts, the most recent invocation of each
skill carries forward keeping its first 5,000 tokens, and re-attached skills share a combined budget of
25,000. Anything older can go. Nothing is broken; re-prompt and the skill comes back.

**You don't need to restart.** Changes to skills are picked up inside the session. The one exception is
creating the top-level `.claude/skills/` directory itself when it didn't exist at session start; that needs
a fresh session.

`wc -w .claude/skills/**/SKILL.md` lies under bash. Without `shopt -s globstar` the `**` collapses to
`*` and matches nothing once your skills are two levels deep. It works in zsh. Use
`tools/context-budget.sh`, which uses `find`.

**These event names don't exist:** `file:save`, `git:pre-commit`, `command:fail`. A hook bound to any of
them never fires and never complains.

## What skills cannot do

They can't execute code, reach the network, call an API, remember your last session, or make Claude smarter.
They're instructions, not programs. Data comes from MCP servers, actions come from hooks, and reasoning is
the model's.
