#!/usr/bin/env bash
# context-budget.sh - chapter 11, failure mode 4. the worst-case word count.
# the book prints this as `wc -w .claude/skills/**/SKILL.md`. that line works in zsh
# and silently matches nothing under /bin/bash without `shopt -s globstar`, which is
# how you get a 0 for a library that is very much not empty. this uses find instead.
set -euo pipefail

SKILLS_DIR="${1:-.claude/skills}"

if [ ! -d "$SKILLS_DIR" ]; then
  echo "no such directory: $SKILLS_DIR" >&2
  echo "usage: $0 [SKILLS_DIR]      (default: .claude/skills)" >&2
  exit 2
fi

files=$(find "$SKILLS_DIR" -type f -name 'SKILL.md' -print 2>/dev/null | LC_ALL=C sort)

if [ -z "$files" ]; then
  echo "no SKILL.md files under $SKILLS_DIR"
  echo "if you expected some, run skill-doctor.sh first - the filename is probably wrong."
  exit 0
fi

echo "context-budget: $SKILLS_DIR"
echo

total=0
count=0
while IFS= read -r f; do
  [ -n "$f" ] || continue
  w=$(wc -w < "$f" | tr -d ' ')
  total=$((total + w))
  count=$((count + 1))
  printf '%8s  %s\n' "$w" "$f"
done <<EOF
$files
EOF

echo
printf 'UPPER BOUND: %s words across %s skill bodies.\n' "$total" "$count"
cat <<EOF

that is the worst case - every skill body loaded into the same turn at once - and it
never actually happens, because of progressive disclosure. only the frontmatter is
always loaded, and a body loads when claude invokes that skill, then unloads.

always-on cost, using the book's ~100 tokens per skill: $count skills is roughly
$((count * 100)) tokens of permanent context. that is the book's figure applied to your
count, not a measurement of your session. the real number is between claude and your
usage page.

if the upper bound bothers you, the fix is not deleting skills. it is tightening the
description: and paths: fields on the ones that get invoked when they should not.
EOF
