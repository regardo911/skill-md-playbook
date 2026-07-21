# Chapter 11: when skills break

This chapter's deliverable isn't a skill. It's the three checkers in `../../tools/`, and a card you can
keep open while you debug.

## Start here

```bash
../../tools/skill-doctor.sh ~/code/your-project/.claude/skills
```

That covers five of the six checks in the chapter's first failure mode: the entry is a directory and not a
flat `.md`, a `SKILL.md` is inside it, the filename is exactly that and not `Skill.md` or `SKILL.md.txt`,
the file is readable, and nothing in `~/.claude/skills/` is quietly overriding it.

Check 6 is not scriptable and the tool says so rather than faking it. Ask Claude directly: "What skills are
currently loaded for this project?" If it lists a skill whose behaviour you never see, the structure is
fine and the `description:` is too vague to match your tasks. That's a writing problem, and no script can
tell it apart from a working skill.

## The three checkers

| | what it answers | what it will not tell you |
|---|---|---|
| `skill-doctor.sh` | is every skill here well-formed | whether any of them work |
| `conflict-audit.sh` | which keywords appear in more than one skill | whether an overlap is a conflict |
| `context-budget.sh` | worst-case word count across all bodies | your real token usage |

All three take the skills directory as their first argument and default to `.claude/skills`.
`conflict-audit.sh` takes your own keywords after that:

```bash
../../tools/conflict-audit.sh ~/code/your-project/.claude/skills retry cache tenant idempotency
```

The default list is the book's: `semicolon import export test error log`. Yours should be the words your
project argues about.

## See it find something

```bash
../../tools/skill-doctor.sh ../../tools/fixtures/broken-library
```

Eighteen findings on the fifteen-file client library from Chapter 5, with three more faults seeded into it
that the chapter names but doesn't draw. Work out what's wrong before you open
`../../tools/fixtures/WHATS-WRONG.md`; that's the point of a fixture.

Then run it on `healthy-library/` next door, which is the same library after the Chapter 5 migration, and
watch it come back clean.

## On your own library

`TROUBLESHOOTING.md` in this folder is the seven-check list and a symptom-to-command lookup. It's meant to
sit open in a tab, so it's short and has no explanations in it. The explanations are the chapter.

One thing the tools can't reach: file permissions don't survive a git clone, so the readability check has
nothing to find in the fixture. On a real machine, with files that came out of a zip or an archive, it does.
