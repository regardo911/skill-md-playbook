# the answer key

Read this after you've run `skill-doctor.sh` against `broken-library/` yourself, not before.
The faults are not labelled inside the fixture files, on purpose. That's the whole point of a fixture.

## broken-library/

This is the client library from Chapter 5, as it actually arrived: fifteen loose `.md` files, plus four
directories that someone started converting and got wrong.

**Fifteen flat files.** `style.md` through `database-queries.md`. None of them load. A skill is a *directory*
containing a `SKILL.md`; a flat `.md` file in `.claude/skills/` is the older slash-command shape. This is the
2nd edition's central correction and it's the single most common reason a library does nothing.

**`style.md` vs `style-v2.md`.** Both exist. They disagree about semicolons, indent width, quote style and
exports. `style-v2.md` says it supersedes the other one, in a comment nobody reads. `conflict-audit.sh`
surfaces the pair on its default `semicolon` keyword.

**`testing.md` vs `testing-old.md`.** `testing-old.md` is Jest. The project moved to Vitest. It was supposed
to be deleted and wasn't.

**`api-patterns.md` overlaps `api-security.md`.** The second half of `api-patterns.md` is auth and validation
rules, the same subject as `api-security.md`, different wording. Under the current spec neither of them loads
anyway, but this is the split you have to make before you convert them.

**`project-memory/SKILL.md`**: correct directory, correct filename, and no `description:` in the frontmatter.
It loads. Claude has nothing to match it against, so it never gets invoked for anything. This is the failure
that generated the reader email at the top of Chapter 11: everything looks right, nothing happens.

**`component-tests/Skill.md`**: right directory, right content, wrong capitalisation. Not `Skill.md`.
`SKILL.md`.

**`release-notes/SKILL.md.txt`**: an editor appended `.txt` on save. macOS Finder hides the extension, so
it looks correct in a file browser and is invisible in a GUI diff. `ls` from a terminal is the only way you'll
see it.

**`api-contract/SKILL.md`**: the nastiest one, because it looks perfect. Right directory, right filename,
a `description:` field sitting there in the frontmatter. But the description text contains
`(status(code): body)`, and a colon-followed-by-space inside an unquoted YAML value ends the value early.
The frontmatter doesn't parse, so Claude sees no `description:` at all and the skill never fires. Chapter 11
Check 2 asks whether a `description:` is *present*, which it is, so the book's own checklist passes this file.
The fix is to wrap the whole value in double quotes. The book shipped this exact bug in Chapter 3, see
[`../../ERRATA.md`](../../ERRATA.md).

## what the fixture can't show you

**Check 4, unreadable files.** Git tracks the executable bit and nothing else, so a `chmod 000` fault
can't survive a clone. `skill-doctor.sh` still runs the check. It just has nothing to find here. It will
find it on a real machine where a file came out of an archive with odd permissions.

**Check 6.** Not scriptable at all. Ask Claude "What skills are currently loaded for this project?" and
compare its answer to your directory listing. No tool in this repo can do that for you, and any tool that
claims to is lying.

## healthy-library/

The same library after the Chapter 5 migration: thirteen skills across ten category folders, every one a
directory with a `SKILL.md`, every one carrying a `description:`. `style.md` and `testing-old.md` are gone.
`api-patterns` and `api-security` were split cleanly and each got a `paths:` glob so they stop competing.

Two things worth noticing. There is no `06-performance/` folder, and the book's own migrated tree doesn't have
one either, because that client had no performance skills to move, and inventing an empty folder to round the
number up to eleven would be the wrong instinct. And `code-review` lost its "check for Jest best practices"
line: that sentence was the actual conflict, and the fix was deleting it, not renaming a folder.
