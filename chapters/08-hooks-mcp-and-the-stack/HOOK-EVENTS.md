# Hook event names

Copy from here. Don't type them from memory. They're case-sensitive and a wrong one fails silently.
Source: Chapter 8.

## The 29 real events

```
SessionStart, Setup, UserPromptSubmit, UserPromptExpansion,
PreToolUse, PermissionRequest, PermissionDenied,
PostToolUse, PostToolUseFailure, PostToolBatch,
Notification, SubagentStart, SubagentStop, TaskCreated, TaskCompleted,
Stop, StopFailure, TeammateIdle, InstructionsLoaded,
ConfigChange, CwdChanged, FileChanged, WorktreeCreate, WorktreeRemove,
PreCompact, PostCompact, Elicitation, ElicitationResult, SessionEnd
```

## The five you'll actually use

| Event | Fires | Use it for |
|---|---|---|
| `PreToolUse` | before Claude runs a tool | gating destructive operations |
| `PostToolUse` | after a tool runs successfully | "react when Claude just edited a file" |
| `FileChanged` | when files in watched directories change | file-glob triggers |
| `SessionStart` | once, when a session starts | setup tasks |
| `Stop` | when Claude stops mid-turn | cleanup |

## Names that do not exist

`file:save` · `git:pre-commit` · `command:fail`

They show up in older third-party blog posts. A hook configured against any of them never fires and never
warns you. For "react when a file is saved," use `PostToolUse` matched against `Edit|Write`, or `FileChanged`
against the glob.

## Where the config goes

`~/.claude/settings.json` (all projects) · `.claude/settings.json` (this project, commit it) ·
`.claude/settings.local.json` (this project, gitignored).

Not `.claude/hooks/<name>.json`. That directory is for the **shell scripts** your hooks shell out to.
`settings/block-rm-via-script.json` in this folder is an example of a hook that calls one.

## Fields that do not exist on a handler

There is no `event:` field. There is no `pattern:` field. There is no `action:` block. There is no
`options.silent` or `options.blocking`. A handler has `type` (always `"command"`), an optional `if`
predicate, and `command`.

And there is no `action.type: "skill"`. A hook fires a **shell command**. If you want it to invoke a skill,
the command calls `claude -p` with a prompt that names the skill. See `settings/security-review-on-edit.json`.
