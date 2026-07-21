# Chapter 9: the client template

A skills library becomes a deliverable the moment every project-specific decision in it turns into a
question you ask the client instead of an answer you guessed.

## What's in the box

`skills-template/` holds two skills, `code-style` and `testing`, with every such decision pulled out and
replaced by a `[CLIENT: ...]` marker. Open one next to its Chapter 3 or Chapter 4 original and the diff is
the entire lesson: the frontmatter shape survives, the section headings survive, and every sentence that
named a preference becomes a question.

Two, not six, and that's deliberate. Generalising `code-style` teaches you the move. Generalising it five
more times teaches you nothing and costs you five more files to keep in sync. `CUSTOMIZE.md` covers all
six with the actual questions, and the other four skills ship unmodified in
`../05-architecture-that-scales/` ready to be copied in and given the same treatment.

`INSTALL.md` and `CUSTOMIZE.md` are the two documents the client gets. They are the deliverable as much as
the skills are.

## The handover

```bash
../../install.sh ~/code/client-project 09
grep -r "\[CLIENT:" ~/code/client-project/.claude/skills/
```

The second command is the point. A template still carrying markers will instruct Claude to follow a rule
that reads `[CLIENT: 2 spaces / 4 spaces / tabs]`, and it will do something with that. Work `CUSTOMIZE.md`
in the kickoff call, then run the grep again and get nothing back.

## What success looks like

Someone who has never seen the template installs it from `INSTALL.md` alone, without messaging you, and
Claude's output on their codebase visibly changes on the first prompt after.

Test that before you invoice, in a directory you've never used, following your own instructions literally.
Every gap you find this way is a support email you don't get.

## What this folder is not

There are no prices in here, no proposal template, no rate card. The chapter has plenty to say about all
three and it's worth reading, but numbers in a repo age badly and none of them would be yours anyway.

What travels is the process: generalise, ask, fill in, verify the grep comes back empty, show the before and
after on their own code.
