#!/usr/bin/env bash
# migrate.sh - chapter 5's mkdir + mv, done for you.
# takes the skills directory as an argument, which is deliberate: the book's step 1
# says cd into .claude/skills/ and then steps 2-3 use project-root-relative paths.
# run literally, that makes .claude/skills/.claude/skills/01-style and the mv fails.
# passing the directory in means the question never comes up.
set -euo pipefail

SKILLS_DIR="${1:-.claude/skills}"
DRY=0
[ "${2:-}" = "--dry-run" ] && DRY=1

if [ ! -d "$SKILLS_DIR" ]; then
  echo "no such directory: $SKILLS_DIR" >&2
  echo "usage: $0 [SKILLS_DIR] [--dry-run]      (default: .claude/skills)" >&2
  exit 2
fi

# skill -> category. the six from chapters 3 and 4, in the book's own layout.
MOVES="code-style:01-style
testing:02-testing
documentation:03-documentation
git-commits:09-communication
code-review:09-communication
stop-slop:11-global"

moved=0
skipped=0

while IFS=: read -r skill category; do
  [ -n "$skill" ] || continue
  src="$SKILLS_DIR/$skill"
  dst="$SKILLS_DIR/$category/$skill"

  if [ ! -d "$src" ]; then
    if [ -d "$dst" ]; then
      echo "already moved: $category/$skill"
    else
      echo "not here, skipping: $skill"
    fi
    skipped=$((skipped + 1))
    continue
  fi

  if [ -e "$dst" ]; then
    echo "REFUSING: $dst already exists. move or delete it first." >&2
    exit 1
  fi

  echo "mv $src -> $dst"
  if [ "$DRY" -eq 0 ]; then
    mkdir -p "$SKILLS_DIR/$category"
    mv "$src" "$dst"
  fi
  moved=$((moved + 1))
done <<EOF
$MOVES
EOF

echo
if [ "$DRY" -eq 1 ]; then
  echo "dry run. $moved would move, $skipped skipped."
  exit 0
fi
echo "$moved moved, $skipped skipped."
echo
echo "the category folder a skill sits in changes nothing about how claude behaves."
echo "the numeric prefixes are for you, reading an ls. what actually decides which"
echo "skill fires is the description: and paths: fields in the frontmatter."
echo
echo "verify: $(cd "$(dirname "$0")/../.." && pwd)/tools/skill-doctor.sh $SKILLS_DIR"
