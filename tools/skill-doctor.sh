#!/usr/bin/env bash
# skill-doctor.sh - chapter 11, failure mode 1, checks 1 through 5.
# tells you whether every skill in a directory is WELL-FORMED. says nothing about
# whether any of them work - only claude can tell you that, and check 6 at the end
# is how you ask.
set -euo pipefail

SKILLS_DIR="${1:-.claude/skills}"

if [ ! -d "$SKILLS_DIR" ]; then
  echo "no such directory: $SKILLS_DIR" >&2
  echo "usage: $0 [SKILLS_DIR]      (default: .claude/skills)" >&2
  exit 2
fi

FAILURES=0
NOTES=0
SKILL_COUNT=0

fail() { printf 'FAIL  %s\n      %s\n' "$1" "$2"; FAILURES=$((FAILURES + 1)); }
note() { printf 'NOTE  %s\n      %s\n' "$1" "$2"; NOTES=$((NOTES + 1)); }

echo "skill-doctor: $SKILLS_DIR"
echo

# check 1a: loose .md files sitting directly in the skills dir. a skill is a DIRECTORY.
for entry in "$SKILLS_DIR"/*.md; do
  [ -f "$entry" ] || continue
  fail "$entry" "flat file, not a skill directory. skills are directories containing a SKILL.md. \
this is the older slash-command shape and claude will not load it as a skill."
done

# a skill directory is any directory (one or two levels down) holding at least one
# regular file. one level down = a flat library, two = category folders.
skill_dirs=$(
  { find "$SKILLS_DIR" -mindepth 1 -maxdepth 2 -type d -print 2>/dev/null || true; } |
  while IFS= read -r d; do
    if find "$d" -mindepth 1 -maxdepth 1 -type f -print -quit 2>/dev/null | grep -q .; then
      printf '%s\n' "$d"
    fi
  done | LC_ALL=C sort
)

if [ -z "$skill_dirs" ]; then
  echo "no skill directories found under $SKILLS_DIR"
fi

while IFS= read -r dir; do
  [ -n "$dir" ] || continue
  SKILL_COUNT=$((SKILL_COUNT + 1))
  name=$(basename "$dir")
  md="$dir/SKILL.md"

  # check 3 first: a near-miss filename is the reason SKILL.md is missing.
  wrong=$(find "$dir" -mindepth 1 -maxdepth 1 -type f -print 2>/dev/null |
          sed 's|.*/||' |
          grep -E -i '^skill\.md(\..+)?$' |
          grep -v -x 'SKILL.md' |
          LC_ALL=C sort | tr '\n' ' ' || true)
  wrong="${wrong% }"

  if [ -n "$wrong" ]; then
    fail "$dir" "filename is '$wrong', not SKILL.md. capital S, capital K, capital I, capital L, \
capital L, dot, lowercase md. some editors append .txt silently and the finder hides it."
  fi

  # check 1b: SKILL.md present
  if [ ! -f "$md" ]; then
    if [ -z "$wrong" ]; then
      fail "$dir" "no SKILL.md inside. every skill directory needs one at its root."
    fi
    continue
  fi

  # check 4: readable
  if [ ! -r "$md" ]; then
    fail "$md" "not readable. if you cannot cat it, claude cannot read it. run: chmod 644 '$md'"
    continue
  fi

  # check 2: description: in the frontmatter. the load-bearing field.
  fm=$(awk 'NR==1 && $0!="---" {exit} NR==1 {next} /^---[[:space:]]*$/ {exit} {print}' "$md")
  if [ -z "$fm" ]; then
    fail "$md" "no YAML frontmatter. the file needs a --- block at the very top, \
before anything else, carrying at minimum a description: field."
  elif ! printf '%s\n' "$fm" | grep -q '^description:'; then
    fail "$md" "no description: field in the frontmatter. the skill loads and is functionally \
invisible - claude has nothing to match against when picking a skill for a task."
  fi

  # check 2b: the frontmatter has to actually PARSE, not just contain the word description.
  #
  # chapter 11 check 2 asks whether a description: field is present. present and valid are
  # different claims, and the gap is not theoretical: the commit-messages skill in chapter 3
  # ships a description whose text contains "(type(scope): description)". a colon followed by
  # a space inside an unquoted yaml value ends the value early, so the whole block fails to
  # parse and the skill is dead - the exact silent failure chapter 11 teaches you to hunt.
  #
  # this is not a full yaml parser and does not pretend to be one. it catches the one mistake
  # that actually happens when you write a description in prose. a real parser would mean
  # installing something, and this book promises you never have to.
  # values opening with [ or { are skipped on purpose: that is the blank-template placeholder
  # convention this book uses everywhere ([skill-name], [CLIENT: framework]). you are meant to
  # replace the whole bracket, so flagging an unfilled template would be noise, not a finding.
  badline=$(printf '%s\n' "$fm" |
            grep -nE '^[A-Za-z_][A-Za-z0-9_-]*:[[:space:]]+[^"'\''[:space:]{[][^"'\'']*:[[:space:]]' |
            head -1 || true)
  if [ -n "$badline" ]; then
    key=$(printf '%s' "$badline" | sed 's/^[0-9]*://' | cut -d: -f1)
    fail "$md" "the $key: value is unquoted and contains a colon followed by a space, so the \
frontmatter does not parse and claude sees no $key at all. wrap the whole value in double quotes: \
$key: \"...\". see ERRATA.md."
  fi

  # check 5: override-hierarchy collision. informational, not a malformation.
  if [ -f "$HOME/.claude/skills/$name/SKILL.md" ]; then
    note "$dir" "a personal skill of the same name exists at ~/.claude/skills/$name/SKILL.md. \
the priority is enterprise > personal > project, so the personal one wins and this one stays dormant. \
rename one, or accept it."
  fi
done <<EOF
$skill_dirs
EOF

echo
echo "checked $SKILL_COUNT skill directories: $FAILURES failing, $NOTES to look at"
echo
echo "check 6 is not scriptable. open claude code in this project and ask:"
echo '  "What skills are currently loaded for this project?"'
echo "if a skill is listed but its behaviour never shows up, the description: is too vague"
echo "to match your tasks - that is a writing problem, not a structural one."

[ "$FAILURES" -eq 0 ] || exit 1
