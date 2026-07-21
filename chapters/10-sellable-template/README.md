# Chapter 10: packaging one to sell

No skills in this folder. A sellable template is a Chapter 9 template plus the packaging that makes a
stranger trust it, and the packaging is what's here.

## The checklist

`packaging-checklist.md` is the five required files, the folder shape, and the three signals a buyer reads
in the first thirty seconds after download. Work down it and tick things off. It's a checklist, not an
essay.

## What's not here

The nine-step Gumroad walkthrough. It was written and then cut. It described someone else's web UI, which
this repo has no way to keep current and no way to verify, and a stale click-path is worse than sending you
to the chapter. The steps are in Chapter 10 and they take about twenty minutes.

## What success looks like

Copy your zip to a directory you've never opened, follow your own `INSTALL.md` literally, and have Claude
producing different output inside two minutes. If it takes five, you'll get support email. If it takes ten,
you'll get refund requests.

Then run the checkers over the unpacked template, because the buyer will not:

```bash
../../tools/skill-doctor.sh /tmp/unpacked/.claude/skills
../../tools/conflict-audit.sh /tmp/unpacked/.claude/skills
```

Shipping a paid template containing a `Skill.md` with a lowercase k is a bad afternoon.

## Prices

Not in this repo. The chapter has tiers, revenue arithmetic and a bundling argument, and it says out loud
that those are observed market ranges rather than promises. Ranges printed in a public repo turn into
quotes, and a quote from a year ago is just wrong. Read them in the book and pick your own number.
