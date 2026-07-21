# Chapter 7: skills for people who don't write code

Three skills, flat, no category folders: `brand-design` for a designer, `writing-voice` for a writer,
`weekly-report` for whoever runs the business. Same file format as every other chapter. A skill doesn't
know or care whether its rules are about semicolons or hex codes.

```bash
../../install.sh ~/projects/whatever 07
```

Then open Claude Code in that folder and ask for the thing you'd normally ask for. A card layout. A blog
intro. Monday's report.

You'll know it worked when the output uses your specifics without you supplying them: the actual hex code,
the actual component name from your Figma library, the five sections in the order you always want them. If
Claude gives you a generic answer, the skill is loading and your rules are too vague to act on. "Use brand
colors" does nothing. `#1A1A2E` does.

Every value in these three files belongs to the book's examples. Reema's navy is not your navy. Open each
file and replace the specifics before you use it. That's about ten minutes of typing and it's the entire
job.

Two things transfer from the developer chapters and are worth stealing. The Kill List in `writing-voice` is
a list of phrases you never want to see again; it works better than any amount of "write naturally," and
every profession has its own. And a `paths:` glob keeps two versions of the same skill from fighting. The
technical writer in the chapter runs four writing skills at once, scoped to `docs/**`, `examples/**`,
`blog/**` and `notes/**`, and only ever gets the right voice for the folder.

You don't need a terminal for the editing part. These are text files. Any editor opens them.
