# Chapter 3: your first skill

Two skills, flat, no category folders yet: `code-style` and `commit-messages`. Pick whichever one you
recognise. If you don't write code, take `commit-messages`. Same shape, and you'll still see the effect.

## The command

```bash
../../install.sh ~/code/your-project 03
```

```
install plan
  from  /path/to/skill-md-playbook
  into  /Users/you/code/your-project/.claude/skills

  code-style/SKILL.md                                   new
  commit-messages/SKILL.md                              new

copied 2 SKILL.md files into /Users/you/code/your-project/.claude/skills
```

## What success looks like

Open Claude Code in that project and ask it to write a function that validates an email address and returns
the domain. Then check the output against the eight rules in `code-style/SKILL.md`. Not "does it feel
better". Go line by line. No `any`, no `var`, no default export, no semicolons, arrow function, 2-space
indent, single quotes, kebab-case in any filename it mentions.

Five of eight is a working skill with one rule that needs an example. Zero of eight means the skill didn't
load, and `../../tools/skill-doctor.sh ~/code/your-project/.claude/skills` will tell you which structural
thing is wrong.

Nothing in this repo can check that for you. A file being well-formed and a file changing Claude's answers
are different claims, and only the second one matters.

## On your own project

Open `code-style/SKILL.md` and rewrite the Instructions block with your own rules. Keep the frontmatter
shape and keep the body under 40 lines. The `description:` is the sentence that decides whether the skill
ever fires, so make it name a specific scope: which files, which activity. "Use this when writing code" is
too broad to be useful.

If your stack isn't TypeScript, the directory layout and frontmatter don't change. Only the body does.
