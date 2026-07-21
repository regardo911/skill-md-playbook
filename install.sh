#!/usr/bin/env bash
# install.sh - copies the book's skill directories into a project you name.
# this is the front door. it installs the BOOK's skills, not this repo's tooling.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

usage() {
  cat <<'EOF'
usage: ./install.sh TARGET_PROJECT WHAT [--force] [--dry-run]

  TARGET_PROJECT   path to the project you want Claude to follow rules in.
                   skills land in TARGET_PROJECT/.claude/skills/.

  WHAT             03          code-style + commit-messages          (chapter 3)
                   04          the five starter skills, flat         (chapter 4)
                   04-python   the same testing skill, for pytest    (chapter 4)
                   05          the six skills in category folders    (chapter 5)
                   06          self-improvement, memory, generator   (chapter 6)
                   07          brand-design, writing-voice, report   (chapter 7)
                   08          migration-review + readme-sync        (chapter 8)
                   09          the client template, [CLIENT:] intact (chapter 9)
                   templates   the three blank starters              (appendix C)
                   library     05 then 06 then 08 - the book's assembled library

  --force          overwrite skills already in the target. off by default.
  --dry-run        print the plan and stop.

start with:  ./install.sh ~/code/your-project library
EOF
}

[ "$#" -ge 2 ] || { usage; exit 2; }

TARGET="$1"; shift
WHAT="$1"; shift
FORCE=0
DRY=0
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    --dry-run) DRY=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown option: $arg" >&2; usage; exit 2 ;;
  esac
done

[ -d "$TARGET" ] || { echo "no such project directory: $TARGET" >&2; exit 2; }

sources_for() {
  case "$1" in
    3|03)        echo "chapters/03-your-first-skill/.claude/skills" ;;
    4|04)        echo "chapters/04-five-starter-skills/.claude/skills" ;;
    04-python|4-python|python)
                 echo "chapters/04-five-starter-skills/python/.claude/skills" ;;
    5|05)        echo "chapters/05-architecture-that-scales/.claude/skills" ;;
    6|06)        echo "chapters/06-self-improvement-and-memory/.claude/skills" ;;
    7|07)        echo "chapters/07-skills-for-non-coders/.claude/skills" ;;
    8|08)        echo "chapters/08-hooks-mcp-and-the-stack/.claude/skills" ;;
    9|09)        echo "chapters/09-client-template/skills-template/.claude/skills" ;;
    templates)   echo "templates" ;;
    library)     echo "chapters/05-architecture-that-scales/.claude/skills
chapters/06-self-improvement-and-memory/.claude/skills
chapters/08-hooks-mcp-and-the-stack/.claude/skills" ;;
    *)           return 1 ;;
  esac
}

SOURCES=$(sources_for "$WHAT") || { echo "don't know what '$WHAT' is." >&2; usage; exit 2; }

DEST_ROOT="$TARGET/.claude/skills"

# snapshot what is in the target BEFORE this run. only these count as overwrites -
# a later chapter superseding an earlier one inside the same run is the point.
PREEXISTING=""
if [ -d "$DEST_ROOT" ]; then
  PREEXISTING=$(cd "$DEST_ROOT" && find . -type f -name 'SKILL.md' -print 2>/dev/null | sed 's|^\./||' | LC_ALL=C sort)
fi

echo "install plan"
echo "  from  $REPO_ROOT"
echo "  into  $DEST_ROOT"
echo

PLAN=""
CLASH=0
SEEN=""
while IFS= read -r src; do
  [ -n "$src" ] || continue
  abs="$REPO_ROOT/$src"
  [ -d "$abs" ] || { echo "missing source (repo is incomplete): $src" >&2; exit 3; }
  rels=$(cd "$abs" && find . -type f -name 'SKILL.md' -print | sed 's|^\./||' | LC_ALL=C sort)
  while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    tag="new"
    if printf '%s\n' "$PREEXISTING" | grep -qxF -- "$rel"; then
      tag="OVERWRITE (already in your project)"
      CLASH=1
    elif printf '%s\n' "$SEEN" | grep -qxF -- "$rel"; then
      tag="supersedes the copy installed a moment ago, from $src"
    fi
    SEEN="$SEEN
$rel"
    printf '  %-52s  %s\n' "$rel" "$tag"
    PLAN="$PLAN
$src|$rel"
  done <<EOF
$rels
EOF
done <<EOF
$SOURCES
EOF

echo

if [ "$CLASH" -eq 1 ] && [ "$FORCE" -eq 0 ]; then
  cat >&2 <<EOF
refusing to overwrite skills that are already in $DEST_ROOT.
look at the OVERWRITE lines above. if you meant it, re-run with --force.
if you did not, install a different chapter, or move the existing skill out first.
EOF
  exit 1
fi

if [ "$DRY" -eq 1 ]; then
  echo "dry run, nothing copied."
  exit 0
fi

COPIED=0
while IFS='|' read -r src rel; do
  [ -n "${rel:-}" ] || continue
  mkdir -p "$DEST_ROOT/$(dirname "$rel")"
  cp "$REPO_ROOT/$src/$rel" "$DEST_ROOT/$rel"
  COPIED=$((COPIED + 1))
done <<EOF
$PLAN
EOF

echo "copied $COPIED SKILL.md files into $DEST_ROOT"
echo

case "$WHAT" in
  8|08|library)
    echo "chapter 8 also ships hook and MCP config. those are JSON that has to be merged"
    echo "into files you may already have, so this script will not touch them. copy the one"
    echo "you want by hand:"
    echo "  $REPO_ROOT/chapters/08-hooks-mcp-and-the-stack/settings/  ->  $TARGET/.claude/settings.json"
    echo "  $REPO_ROOT/chapters/08-hooks-mcp-and-the-stack/mcp/       ->  $TARGET/.mcp.json"
    echo
    ;;
esac

echo "next: open claude code in $TARGET and ask it"
echo
echo '    "What skills are currently loaded for this project?"'
echo
echo "if a skill is missing from the answer, run"
echo "  $REPO_ROOT/tools/skill-doctor.sh $DEST_ROOT"
echo
echo "one gotcha: if .claude/skills/ did not exist when your session started, you need a"
echo "fresh session before claude begins watching it. skills added after that are picked up live."
