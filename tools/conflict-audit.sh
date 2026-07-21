#!/usr/bin/env bash
# conflict-audit.sh - chapter 11, failure mode 2. the monthly audit loop, scripted.
# reports which keywords appear in more than one SKILL.md. it does NOT tell you a
# conflict exists: "not all overlaps are conflicts" (ch11:73). two files can mention
# import for entirely different reasons. this narrows where to look, nothing more.
set -euo pipefail

SKILLS_DIR="${1:-.claude/skills}"
shift || true

# the book's default list, verbatim. pass your own after the directory:
#   ./conflict-audit.sh .claude/skills semicolon retry cache tenant
if [ "$#" -gt 0 ]; then
  KEYWORDS="$*"
else
  KEYWORDS="semicolon import export test error log"
fi

if [ ! -d "$SKILLS_DIR" ]; then
  echo "no such directory: $SKILLS_DIR" >&2
  echo "usage: $0 [SKILLS_DIR] [keyword ...]      (default dir: .claude/skills)" >&2
  exit 2
fi

echo "conflict-audit: $SKILLS_DIR"
echo "keywords: $KEYWORDS"
echo

overlaps=0
for keyword in $KEYWORDS; do
  # -i is deliberate. the book's loop is case-sensitive, which hides a rule written
  # as "Semicolons" in a heading. an audit that misses those is worse than useless.
  hits=$(grep -ril -- "$keyword" "$SKILLS_DIR" 2>/dev/null | LC_ALL=C sort || true)
  count=$(printf '%s' "$hits" | grep -c . || true)
  if [ "$count" -gt 1 ]; then
    overlaps=$((overlaps + 1))
    echo "'$keyword' appears in $count files:"
    printf '%s\n' "$hits" | sed 's/^/  /'
    echo
  fi
done

if [ "$overlaps" -eq 0 ]; then
  echo "no keyword appears in more than one file."
else
  echo "$overlaps keyword(s) co-occur across files."
fi

cat <<'EOF'

co-occurrence is not a verdict. open each pair and read the two description: fields.
if both could plausibly match the same task, that is your conflict, and the fix is
tightening the descriptions until they name non-overlapping scopes - not renaming a
folder. claude does not read priority off folder names.
EOF
