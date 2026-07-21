# Chapter 8: hooks, MCP, and the full stack

This is the chapter with three moving parts instead of one, so the folder has three kinds of thing in it.

- `.claude/skills/`: two skills, `migration-review` and `readme-sync`
- `settings/`: six hook entries, one per file, ready to paste into a `settings.json`
- `mcp/`: two `.mcp.json` server entries
- `HOOK-EVENTS.md`: the 29 real event names, and the three that don't exist

## The two pipelines

**README sync** is the one to build first. A skill plus a hook, no external anything: when Claude edits a
`src/**/*.ts` file, the hook shells out to `claude -p` with the `readme-sync` skill named in the prompt, and
you get told if you changed a public signature and forgot the docs.

**Migration review** is the full three-layer version: skill plus hook plus an MCP server that hands Claude
your live database schema. It catches the missing index on a foreign key that you'd otherwise find in
production, six months later, from a support ticket.

## Skills

```bash
../../install.sh ~/code/your-project 08
```

Two files. Note that `migration-review` carries `paths: ["migrations/**/*.sql"]` and `readme-sync` carries
`paths: ["src/**/*.ts"]`. Those globs are the auto-activation gate. Get one wrong and the skill sits there
looking perfectly healthy while never firing.

## Hooks

`install.sh` deliberately won't touch your JSON. Hook config has to be merged into a file you probably
already have, and a script that silently rewrites your `settings.json` is a script that will eventually eat
something you cared about. Copy the block by hand:

```bash
cat settings/readme-sync-on-edit.json
```

into `.claude/settings.json` at your project root. Three valid locations for that file, and only three:
`~/.claude/settings.json` for everything you do, `.claude/settings.json` for this project (commit it), and
`.claude/settings.local.json` for machine-specific paths (don't).

Not `.claude/hooks/<name>.json`. That directory is where the *shell scripts* live that hooks call out to.
`settings/block-rm-via-script.json` is an example of a hook that references one, and don't copy that one in
without reading it first: it points at `.claude/hooks/block-rm.sh`, a script you have to write. It's here
because it's the schema exactly as the docs print it, and because it's the clearest thing showing what
`.claude/hooks/` is actually for.

`block-destructive-bash.json` is the version you can use today, and it's the one most people want on day
one: it makes an `rm -rf` from Claude exit non-zero before it runs, with the whole block inline.

## MCP

`.mcp.json` goes at the **project root**, not under `.claude/`. The schema is an `mcpServers` object keyed
by name, not a `servers` array, and there's no top-level `capabilities` block. The server negotiates those
itself.

`mcp/project-db.json` ships with `<your-current-postgres-mcp-package>` left in as a literal placeholder, and
that's not laziness. The two obvious packages, `@modelcontextprotocol/server-postgres` and
`@modelcontextprotocol/server-github`, are both deprecated on npm. Printing a package name here would age
into a wrong answer, and you'd find out by running it. Pick the current one from
`https://github.com/modelcontextprotocol/servers`.

`mcp/github.json` needs no such placeholder because the endpoint is stable.

## Run the simple one

Install the skill, paste `settings/readme-sync-on-edit.json` into your settings, then ask Claude to change
the signature of an exported function in `src/`.

## What success looks like

The hook fires after the edit, `claude -p` runs, and either a README suggestion or the single line
`README-IN-SYNC` appears in your session. If nothing happens, work down this list: is the event name
capitalised exactly (`PostToolUse`)? is the matcher `Edit|Write`? does the `if` predicate actually match the
path you edited? does the skill named in the prompt have a `description:` for Claude to match against?

Hook commands run in the background, so if you're getting silence, append `2>&1 | tee /tmp/hook.log` to the
command while you debug and read the log.

## Costs

A hook that runs a linter is free. A hook that calls `claude -p` is a second Claude turn and costs whatever
a Claude turn costs you.

That's the whole honest statement. The chapter estimates fractions of a cent for a small review and labels
it an estimate; this repo can't measure your account and won't pretend to. The lever you have is the `if`
predicate. `FilePath(**/*.ts)` fires on every TypeScript edit Claude makes. `FilePath(src/security/**)`
fires on the ones that matter. Same hook, very different bill.
