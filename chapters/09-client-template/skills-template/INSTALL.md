# Install

Two minutes. Run everything from the client project's root.

```bash
mkdir -p .claude/skills
cp -R /path/to/skills-template/.claude/skills/* .claude/skills/
ls -la .claude/skills/
```

You should see the category folders, each holding one directory per skill, each holding a `SKILL.md`.

Then open Claude Code in the project and ask:

> What skills are currently loaded for this project?

If a skill is missing from Claude's answer, run `../../tools/skill-doctor.sh .claude/skills` before you go
looking anywhere else. It catches the five structural things that break this, and it catches them in about a second.

One thing to warn the client about on the handover call: if `.claude/skills/` didn't exist when their session
started, they need a fresh session for Claude to begin watching it. Individual skills added later are picked
up live.

## Before you hand it over

Nothing in this template is finished. Every `[CLIENT: ...]` marker is a decision you have to make with them,
and a skill still carrying markers will happily instruct Claude to follow a rule that reads
`[CLIENT: 2 spaces / 4 spaces / tabs]`. Work `CUSTOMIZE.md` first, then verify:

```bash
grep -r "\[CLIENT:" .claude/skills/
```

Empty output means you're done.
