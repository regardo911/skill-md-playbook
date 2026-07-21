# skill-md-playbook

The skill files from *Claude Code Skills: The SKILL.md Playbook*, laid out chapter by chapter, ready to copy
into your own project.

![Two file paths side by side on a dark background. On the left, marked with a red X and captioned "does not
load", the flat path .claude/skills/code-style.md. On the right, marked with a green check and captioned
"this is a skill", a folder containing a file, at the path .claude/skills/code-style/SKILL.md. The headline
reads: a skill is a directory, not a file.](docs/images/hero.png)

## What this is, honestly

The book's twenty SKILL.md files, the hook and MCP config from Chapter 8, and three shell scripts for
auditing a skills library. Every one is the version printed in the book, at the book's own paths, so if you
followed along you'll recognise them. A few appear more than once on disk because the book itself moves them:
Chapter 5 re-lays six into category folders, Chapter 9 generalizes two into a client template.

The three scripts run on a stock machine. No key, no account, no network, no runtime to install. The skill
files need your own Claude Code, because that's the thing they configure.

**No test here checks whether a skill actually changes Claude's output.** `skill-doctor.sh` tells you a skill
is well-formed, which is a different claim from effective. The book's method for that one is you, running the
same prompt with the skill on and off and counting the difference. Still is.

A few files here differ from the printed page, because the book has bugs: one skill in Chapter 3 doesn't load
as printed, and the Chapter 5 migration fails if you follow it exactly. [`ERRATA.md`](ERRATA.md) lists each
one, what's wrong, and what this repo does instead.

Educational software, provided as-is, no warranty.

## The first command

Point it at a project you actually work in. It copies skills; it doesn't run them.

```bash
git clone https://github.com/regardo911/skill-md-playbook
cd skill-md-playbook
./install.sh ~/code/your-project library
```

```
install plan
  from  /Users/you/skill-md-playbook
  into  /Users/you/code/your-project/.claude/skills

  01-style/code-style/SKILL.md                          new
  02-testing/testing/SKILL.md                           new
  03-documentation/documentation/SKILL.md               new
  09-communication/code-review/SKILL.md                 new
  09-communication/git-commits/SKILL.md                 new
  11-global/stop-slop/SKILL.md                          new
  02-testing/test-quality/SKILL.md                      new
  09-communication/code-review/SKILL.md                 supersedes the copy installed a moment ago
  10-project/project-memory/SKILL.md                    new
  11-global/skill-generator/SKILL.md                    new
  03-documentation/readme-sync/SKILL.md                 new
  04-architecture/migration-review/SKILL.md             new

copied 12 SKILL.md files into /Users/you/code/your-project/.claude/skills
```

Eleven skills land (Chapter 6 replaces Chapter 4's `code-review` with the upgraded one, at the same path).
The plan prints before anything is written, and if a skill of that name is already in your project the
script stops rather than overwriting it. `--force` if you meant it.

Then open Claude Code in that project and ask it:

> What skills are currently loaded for this project?

That question is the only real verification step, and no script can do it for you.

If you'd rather work through the book one chapter at a time, pass a chapter number instead of `library`:
`./install.sh ~/code/your-project 03`.

## The chapters

| | what you get | the command | you'll know it worked when |
|---|---|---|---|
| 1 | nothing. it's the why | | |
| 2 | nothing. it's the spec, and image 2 below is the part worth keeping | | |
| [3](chapters/03-your-first-skill/) | `code-style`, `commit-messages` | `./install.sh <proj> 03` | Claude's next function follows all eight rules, not five |
| [4](chapters/04-five-starter-skills/) | the five starter skills, plus a pytest variant | `./install.sh <proj> 04` | one prompt produces code, tests and a commit message that all match your conventions |
| [5](chapters/05-architecture-that-scales/) | the same six, in category folders, plus `migrate.sh` | `chapters/05-*/migrate.sh <proj>/.claude/skills` | output is identical after the move. that non-event is the lesson |
| [6](chapters/06-self-improvement-and-memory/) | self-evaluating `code-review` and `test-quality`, `project-memory`, `skill-generator` | `./install.sh <proj> 06` | one round of prompts produces a diff you can read, and then it stops |
| [7](chapters/07-skills-for-non-coders/) | `brand-design`, `writing-voice`, `weekly-report` | `./install.sh <proj> 07` | the output uses your hex codes and your section order without being asked |
| [8](chapters/08-hooks-mcp-and-the-stack/) | two pipeline skills, six hook entries, two MCP entries | `./install.sh <proj> 08` | you edit a `src/**/*.ts` file and a review appears without asking for one |
| [9](chapters/09-client-template/) | the client template, `[CLIENT: ...]` markers intact | `./install.sh <proj> 09` | someone installs it from `INSTALL.md` alone and doesn't message you |
| [10](chapters/10-sellable-template/) | packaging checklist, listing recipe | read them | your zip goes from download to working in under two minutes |
| [11](chapters/11-when-skills-break/) | the troubleshooting card. the tools are in `tools/` | `tools/skill-doctor.sh <proj>/.claude/skills` | you find the fault in seconds instead of half an hour |
| [12](chapters/12-30-day-roadmap/) | the 30-day plan template | `cp chapters/12-*/30-day-plan.template.md <proj>/` | three real numbers written down before day 1 |

Chapters 1 and 2 have no folder on purpose. Neither has a build step in the book, and manufacturing one so
every chapter has a directory would be padding.

[`templates/`](templates/) holds Appendix C: three blank starters for skills of your own.

## The three checkers

Each takes the skills directory as its first argument and defaults to `.claude/skills`.

```bash
tools/skill-doctor.sh    ~/code/your-project/.claude/skills   # is every skill well-formed
tools/conflict-audit.sh  ~/code/your-project/.claude/skills   # which words appear in more than one skill
tools/context-budget.sh  ~/code/your-project/.claude/skills   # worst-case words across all bodies
```

None of them will tell you a skill works. `conflict-audit.sh` won't tell you an overlap is a conflict, and
takes your own keywords after the directory. `context-budget.sh` prints an upper bound and says so.

To watch them find something real, run the first one against `tools/fixtures/broken-library/`, which is the
fifteen-file client library from Chapter 5 as it arrived, plus four directories someone started converting
and got wrong. It comes back with 19 findings. Then run it against `healthy-library/` next door, the same
library after the migration, and it comes back clean.

## How it works underneath

![A flow diagram. Level 1 metadata, described as every skill always loaded at about 100 tokens each, feeds
into a decision diamond labelled description colon, asking does it match the task. That feeds Level 2, the
body, described as one skill on invoke capped at about 5,000 tokens, which then unloads at the end of the
turn. Below a divider, a pyramid of three bars labelled enterprise, personal and project, with an upward
arrow and the caption: the more global location wins.](docs/images/how-claude-picks-a-skill.png)

Two mechanisms decide which skill is live at any moment, and no command can show you either one, because
both happen inside Claude. Progressive disclosure is why a thirty-skill library doesn't cost you thirty
skill bodies of context. The override hierarchy is why a personal skill silently beats the project's.

![A six-stage pipeline. An Edit or Write tool call, captioned Claude touches a file, flows into a decision
diamond reading if FilePath of migrations glob dot sql, then into a shell command that the hook runs, then
into claude dash p, highlighted in orange and captioned a second Claude turn, this one costs. That reaches a
project-db MCP server which returns the live schema, and finally stdout back into your original session. The
headline reads: one edit, two Claude turns.](docs/images/hook-pipeline.png)

Chapter 8's pipeline has a step nobody sees: the hook shells out to `claude -p`, which is a whole second
Claude turn. It doesn't show up in any output you can read, and it's the entire cost model. Scope your `if`
predicates accordingly.

## Contributing

Fixes welcome: a broken path, a script that misbehaves on your shell, a fixture that doesn't reproduce.

New skills are out of scope, and not because they wouldn't be good. This repo mirrors one book on purpose,
so that a reader who followed along recognises every file. Adding a twenty-first skill breaks the only
promise it makes. Build yours in your own project, from `templates/`, and share it in one of the communities
in Appendix B.

## License

MIT. See [LICENSE](LICENSE).
