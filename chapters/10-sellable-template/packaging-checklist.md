# Packaging checklist

Tick these off before you upload anything.

## The five files a buyer expects

- [ ] `README.md`: what's included, who it's for, what changes after installation, and a before/after image
- [ ] `INSTALL.md`: download to working in under two minutes, tested by you from scratch
- [ ] `CUSTOMIZE.md`: one question per decision, each paired with the file to edit
- [ ] `CHANGELOG.md`: starts at 1.0.0
- [ ] `LICENSE`: say plainly whether they can use it on client work, modify it, and resell it

## The folder

```
skills-template-<stack>/
  README.md
  INSTALL.md
  CUSTOMIZE.md
  CHANGELOG.md
  LICENSE
  .claude/
    settings.json         hook entries the template ships with
    skills/
      01-style/
        <skill-name>/
          SKILL.md
      02-testing/
        <skill-name>/
          SKILL.md
      ...
  .mcp.json               only if the template actually needs a server
  examples/
    before-after-code-style.png
    before-after-testing.png
```

- [ ] every skill is a directory containing a `SKILL.md`, uppercase, dot-md
- [ ] every `SKILL.md` has a `description:` in its frontmatter
- [ ] hooks are entries inside `.claude/settings.json`, not standalone JSON files
- [ ] `.mcp.json` sits at the root, not under `.claude/`
- [ ] 15 to 20 skills, covering style, testing, docs, architecture, errors, deployment
- [ ] two or three hooks

## The three signals a buyer reads first

- [ ] **README that looks like a product.** Sections, a contents list, formatted skill descriptions. Thirty
      minutes of work and it's the difference between "professional" and "someone's dotfiles."
- [ ] **One naming convention, applied everywhere.** Lowercase kebab-case directories. The `SKILL.md`
      filename itself is fixed by the spec and is not yours to style.
- [ ] **A version number.** 1.0.0 in the CHANGELOG. Versioned implies maintained. An unversioned zip implies
      a dump.

## Before you upload

- [ ] unzip into a directory you've never used
- [ ] follow your own `INSTALL.md` literally, no shortcuts
- [ ] `../../tools/skill-doctor.sh <unpacked>/.claude/skills` comes back clean
- [ ] `../../tools/conflict-audit.sh <unpacked>/.claude/skills` shows nothing you can't explain
- [ ] `grep -r "\[CLIENT:" <unpacked>/` returns nothing
- [ ] the two before/after images are real screenshots of real output, not mockups

## Pick a stack nobody has done

Three Next.js templates already listed means don't build a fourth. Being the only template for SvelteKit,
Remix or Astro beats being the fourth for React. Same effort, no competition.
