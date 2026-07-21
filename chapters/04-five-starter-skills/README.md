# Chapter 4: the five starter skills

`stop-slop`, `testing`, `documentation`, `git-commits`, `code-review`. With `code-style` from Chapter 3
that's six, which is roughly the point where Claude starts feeling like it read your contributing guide.

`python/` holds the same testing skill written for pytest. Install one or the other, never both. They use
the same skill name and the same path, and two skills called `testing` is a conflict you'd have to debug
later for no reason.

## Run it

```bash
../../install.sh ~/code/your-project 04            # vitest
../../install.sh ~/code/your-project 04-python     # pytest
```

Five files land. The plan prints first, and if any of the five is already in your project the script stops
and tells you which, rather than quietly replacing your version with the book's.

## Did it work

Ask Claude, in one message: write a function that calculates the total price of a shopping cart including
tax, write tests for it, and create a commit message.

Then check four things. The variable names carry their content, not `data` and `result`. The tests import
from your framework and assert on values, not on truthiness. The JSDoc has `@param` and `@returns` and
isn't three words long. The commit message is `type(scope): description`, lowercase, no period.

Four of four means all five skills fired on one prompt. Three of four tells you which skill needs a sharper
rule, and it's usually the one whose `description:` is vaguest.

## Your stack, not the book's

`stop-slop` ships as-is for everyone. Generic-sounding output is generic in every language.

The other four need editing. Testing is the obvious one: swap the framework, the file-path convention and
the assertion style. `documentation` needs your doc format. `git-commits` needs your types and scopes if
they aren't conventional-commits. `code-review` needs your severity language.

One rule while you edit: if a skill file goes past 40 lines, it's doing two jobs. Split it.
