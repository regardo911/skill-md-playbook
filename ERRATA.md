# Errata

The printed book is a fixed snapshot; this repository is maintained. **Where the two disagree, this file is
the tie-breaker.**

Each entry is the same three things: what the book says, why it's wrong, and what this repo does instead.

---

## Chapter 3: the `commit-messages` skill doesn't load

**The book prints** (ch03, "Your Second Skill"):

```yaml
description: Use this skill when creating git commits ... format (type(scope): description), 72-char limit ...
```

**Why it's wrong.** `(type(scope): description)` puts a colon-followed-by-a-space inside an unquoted YAML
value. YAML reads that as the start of a new key, the frontmatter block fails to parse, and Claude sees **no
`description:` at all**. The skill loads and never fires.

It's a mean one, because `description:` is right there in the file. Chapter 11's Check 2 asks whether a
`description:` is *present*, and it is. Present and valid are different claims.

**The fix.** Wrap the whole value in double quotes. Same words, two extra characters:

```yaml
description: "Use this skill when creating git commits ... format (type(scope): description), 72-char limit ..."
```

Same bug, same fix, in the two Chapter 9 client-template skills (`code-style`, `testing`) whose
`[CLIENT: ...]` markers also carry a colon.

See `chapters/03-your-first-skill/.claude/skills/commit-messages/SKILL.md`.
`tools/skill-doctor.sh` now catches this, and `tools/fixtures/broken-library/api-contract/` is a copy of it
to practise on.

---

## Chapter 5: the migration BUILD STEP fails if you follow it exactly

**The book prints** (ch05, BUILD STEP): step 1 says `cd` into your project's `.claude/skills/` directory.
Steps 2 and 3 then run `mkdir -p .claude/skills/{01-style,...}` and `mv .claude/skills/code-style ...`.

**Why it's wrong.** Those paths are relative to the project root, not to `.claude/skills/`. Run literally,
you build `.claude/skills/.claude/skills/01-style/` and the `mv` fails:

```
mv: rename .claude/skills/code-style to .claude/skills/01-style/code-style: No such file or directory
```

The `mkdir` succeeds, so the error lands on the `mv` and points at the wrong thing.

**The fix.** Stay in the project root. Don't `cd`. The rest of the chapter, including the migration table,
already assumes you did.

See `chapters/05-architecture-that-scales/migrate.sh`, which takes the skills directory as an argument so the
question can't come up.

---

## Chapter 5: the migrated tree is counted wrong

**The book prints** (ch05, after the migration tree): "15 flat files became **12** properly-formatted skills
across **11** category folders."

**Why it's wrong.** Count the tree printed directly above that sentence: **13** skill directories across
**10** category folders. There's no `06-performance/` in it.

Nothing breaks. It's worth knowing only so you don't go hunting for a folder that was never there.

**The fix.** The tree is right, the sentence is wrong. This repo ships the tree as printed.

See `tools/fixtures/healthy-library/`.

---

## Chapter 11 and Appendix A: the context-budget command prints nothing under bash

**The book prints:**

```bash
wc -w .claude/skills/**/SKILL.md
```

**Why it's wrong.** `**` only recurses in zsh. Under bash without `shopt -s globstar` it collapses to a
single `*`, and once your skills are in category folders the path is one level deeper than that matches:

```
$ /bin/bash -c 'wc -w .claude/skills/**/SKILL.md'
wc: .claude/skills/**/SKILL.md: open: No such file or directory
```

The nasty part is that it works fine *before* you organise your library, in both shells. It starts lying at
exactly the point Chapter 5 tells you to reorganise. On a half-migrated library it doesn't even error, it
just quietly returns a smaller number.

**The fix.** Use `find`, which behaves the same everywhere.

See `tools/context-budget.sh`.

---

## Chapter 5: "name files for their purpose" is about directories

**The book prints** (ch05, "Naming Conventions That Scale"): naming advice written about `.md` files, e.g.
"`testing-v3.md` tells you nothing. `unit-tests.md` tells you everything."

**Why it's confusing.** In this edition the filename is fixed: it is always `SKILL.md`. Chapter 10 says so
outright ("the SKILL.md filename itself is fixed by spec"), and Chapter 5's own folder tree names
directories. The naming advice is good, it just applies to the **skill directory** name.

**The fix.** Read `unit-tests.md` as `unit-tests/`. Everything else in that section stands.

---

## Not errors, just differences

**Skills live under a nested `.claude/` in each chapter folder.** Not at the repo root. Claude Code watches
the project-root `.claude/skills/`, so if these sat at the top level, cloning this repo and opening it would
inject twenty skills into your session, including one that's always active. `install.sh` copies them where
you want them instead.

**`skill-doctor.sh` implements Chapter 11's checks 1 to 5.** Check 6 is asking Claude "what skills are
currently loaded" and reading the answer. No script can do that, so it doesn't pretend to; it prints the
question at the end of every run.

**Nothing here tests whether a skill *works*.** Well-formed is not the same as effective. The book's method
for the second one is Chapter 4's: run the same prompt with the skill on and off, and count the difference
yourself.
