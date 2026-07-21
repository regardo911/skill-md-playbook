# gotchas

things that bit while building this, with what they printed.

## `wc -w .claude/skills/**/SKILL.md` reports nothing under bash

the book prints that line in chapter 11 and in the appendix troubleshooting section. it works. in zsh.

under `/bin/bash` without `shopt -s globstar`, `**` collapses to a single `*`, and once your skills are in
category folders the path is three levels deep, so it matches nothing:

```
$ /bin/bash -c 'wc -w .claude/skills/**/SKILL.md'
wc: .claude/skills/**/SKILL.md: open: No such file or directory

$ /bin/zsh -c 'wc -w .claude/skills/**/SKILL.md'
    1308 total
```

the nasty part is that it does not look like a failure. before the chapter 5 migration, when skills are flat,
the same line works fine in both shells. it starts lying exactly at the point you organise your library.

`tools/context-budget.sh` uses `find` instead. the book's line is still transcribed verbatim wherever it is
quoted, because it is what the book says.

## the chapter 5 migration, run literally, builds a path inside itself

step 1 says `cd` into `.claude/skills/`. steps 2 and 3 then use project-root-relative paths. do exactly that
and you get:

```
$ cd .claude/skills
$ mkdir -p .claude/skills/{01-style,02-testing,...}
$ mv .claude/skills/code-style .claude/skills/01-style/code-style
mv: rename .claude/skills/code-style to .claude/skills/01-style/code-style: No such file or directory
```

leaving `.claude/skills/.claude/skills/01-style/` sitting there. the `mkdir` succeeds, which is why it takes
a minute to spot: the error is on the `mv` and it points at the wrong thing.

run it from the project root. `migrate.sh` takes the skills directory as an argument so the question never
comes up.

## every skill in here lives under a nested `.claude/`

`chapters/03-your-first-skill/.claude/skills/code-style/SKILL.md`, not `.claude/skills/code-style/SKILL.md`
at the repo root.

that is on purpose and it cost some thought. claude code watches the project-root `.claude/skills/`. if these
files sat at the root, cloning this repo and opening it in claude code would inject twenty skills into your
session, including one called `stop-slop` that is always active and one carrying somebody else's brand colors.
nesting keeps every path byte-identical to the book while making the repo inert when you open it.

the cost is that you cannot just symlink the repo into a project. `install.sh` copies instead.

## the chapter citation sits below the frontmatter, not above it

every artifact in here names its chapter in an html comment. the obvious place is the top of the file, above
the `---`.

did not do that. yaml frontmatter has to be the first thing in the file for every frontmatter parser I have
ever met, and I have no way to test claude code's parser without claiming a verification I did not run. so the
comment goes on the first line of the body instead, after the closing `---`. slightly uglier, cannot break
anything.

## `case` inside `$( )` blew up on macos bash

skill-doctor's filename check was originally a `case` statement inside a command substitution inside a while
loop. bash 3.2, which is still what ships on macos, could not parse it:

```
./tools/skill-doctor.sh: line 61: syntax error near unexpected token `;;'
```

the closing paren of a `case` pattern gets read as the end of the `$( )`. it parses fine in bash 5. rewrote it
as `grep -E -i '^skill\.md(\..+)?$'`, which is shorter anyway.

worth knowing if you edit these scripts: they are written for bash 3.2, so no associative arrays, no `${x,,}`,
no `mapfile`.

## the permissions check has nothing to find in the fixture

chapter 11 check 4 is "can you `cat` it". `skill-doctor.sh` runs it. it will never fire on
`tools/fixtures/broken-library/`, because git tracks the executable bit and nothing else, so a `chmod 000`
does not survive a clone.

left the check in rather than dropping it. it fires on real machines, on files that came out of an archive
with odd permissions, which is where that failure actually happens. it just cannot be demonstrated here, and
`tools/fixtures/WHATS-WRONG.md` says so instead of pretending.
