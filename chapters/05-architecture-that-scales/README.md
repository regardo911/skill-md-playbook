# Chapter 5: architecture that scales

The same six skills from Chapters 3 and 4, sitting in category folders instead of flat. Nothing about their
contents changed. That's worth saying out loud, because the folder layout is the part people assume is doing
work, and it isn't.

## The migration

You have two ways in. If you already installed 03 and 04 into a project, move what's there:

```bash
./migrate.sh ~/code/your-project/.claude/skills
```

```
mv .../skills/code-style -> .../skills/01-style/code-style
mv .../skills/testing -> .../skills/02-testing/testing
mv .../skills/documentation -> .../skills/03-documentation/documentation
mv .../skills/git-commits -> .../skills/09-communication/git-commits
mv .../skills/code-review -> .../skills/09-communication/code-review
mv .../skills/stop-slop -> .../skills/11-global/stop-slop

6 moved, 0 skipped.
```

Add `--dry-run` to see the plan without touching anything. If a destination already exists it stops rather
than merging two skills into one directory.

Or skip the flat stage entirely and install the organised version straight in:

```bash
../../install.sh ~/code/your-project 05
```

Six skills only reach five of the eleven category folders. The full set, for when you build your own:

```
01-style  02-testing  03-documentation  04-architecture  05-errors  06-performance
07-security  08-devops  09-communication  10-project  11-global
```

Don't create the ones you have nothing to put in. The migrated client library in
`../../tools/fixtures/healthy-library/` has ten of the eleven, because that client had no performance
skills, and an empty `06-performance/` would have been a folder pretending to be work.

## What success looks like

Run the same compound prompt from Chapter 4 after the move. The output should be identical to what you got
before it. If it changed, something moved that shouldn't have, and `../../tools/skill-doctor.sh` will find
it in a second.

That non-event is the lesson. The numeric prefixes are for you, reading an `ls`. Claude does not sort skills
by folder name and there is no intra-project priority mechanism. The only hierarchy it enforces is
enterprise > personal > project, on same-named skills at different scopes.

What actually decides which skill fires is `description:` and `paths:`. If two skills keep contradicting
each other, tighten the descriptions until they name non-overlapping scopes. Renaming folders will not help
and neither will renumbering them.

## The bug in the book's step 1

Step 1 says `cd` into `.claude/skills/`. Steps 2 and 3 then use project-root-relative paths. Run that
literally and you get `.claude/skills/.claude/skills/01-style` and the `mv` fails with no such file.

Run it from the project root. `migrate.sh` takes the skills directory as an argument, so the question
doesn't arise.

## Doing it to your own library

`migrate.sh` knows the book's six skills by name. For your own library, the categories are just directories
and `mv` is just `mv`. There's no manifest to update and nothing to register. Two things worth doing while
you're in there: delete anything you haven't seen affect Claude's output in two weeks, and check for the
duplicate you forgot about.

```bash
../../tools/conflict-audit.sh ~/code/your-project/.claude/skills
```

Then read `../../tools/fixtures/broken-library/`, the fifteen-file mess from the chapter exactly as
it arrived, and running the checkers over it is a faster way to learn what a bad library looks like than
reading about one.
