#!/usr/bin/env bash
# runs the three checkers against both fixtures and asserts what they found.
# no network, no keys, no account. if this needs anything from you, it is broken.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 1

PASS=0
FAIL=0

ok()   { PASS=$((PASS + 1)); printf 'ok   %s\n' "$1"; }
bad()  { FAIL=$((FAIL + 1)); printf 'FAIL %s\n' "$1"; }
check(){ if [ "$2" = "0" ]; then ok "$1"; else bad "$1"; fi; }

contains() { printf '%s' "$1" | grep -qF -- "$2"; echo $?; }

BROKEN="tools/fixtures/broken-library"
HEALTHY="tools/fixtures/healthy-library"

# --- skill-doctor: the fail -> pass pair -------------------------------------
DOC_BROKEN=$(./tools/skill-doctor.sh "$BROKEN" 2>&1); DOC_BROKEN_RC=$?
DOC_HEALTHY=$(./tools/skill-doctor.sh "$HEALTHY" 2>&1); DOC_HEALTHY_RC=$?

if [ "$DOC_BROKEN_RC" -ne 0 ]; then
  ok "skill-doctor exits non-zero on broken-library (got $DOC_BROKEN_RC)"
else
  bad "skill-doctor should have failed on broken-library"
fi
check "skill-doctor exits 0 on healthy-library" "$DOC_HEALTHY_RC"

# --- skill-doctor names each seeded fault ------------------------------------
check "catches the flat style.md"          "$(contains "$DOC_BROKEN" "$BROKEN/style.md")"
check "calls it a flat file, not a skill"  "$(contains "$DOC_BROKEN" "flat file, not a skill directory")"
check "catches the wrong-case Skill.md"    "$(contains "$DOC_BROKEN" "filename is 'Skill.md'")"
check "catches the SKILL.md.txt"           "$(contains "$DOC_BROKEN" "filename is 'SKILL.md.txt'")"
check "catches the missing description:"   "$(contains "$DOC_BROKEN" "no description: field")"
check "catches the unquoted colon-space"   "$(contains "$DOC_BROKEN" "unquoted and contains a colon followed by a space")"
check "points at api-contract for it"      "$(contains "$DOC_BROKEN" "$BROKEN/api-contract/SKILL.md")"
check "points at project-memory for it"    "$(contains "$DOC_BROKEN" "$BROKEN/project-memory/SKILL.md")"
check "prints the manual check 6"          "$(contains "$DOC_BROKEN" "What skills are currently loaded")"
if printf '%s' "$DOC_HEALTHY" | grep -qiE 'skill (works|is working|verified)'; then
  bad "skill-doctor claimed a skill works - it cannot know that"
else
  ok "never claims a skill works"
fi

# --- conflict-audit ----------------------------------------------------------
CONF=$(./tools/conflict-audit.sh "$BROKEN" 2>&1); CONF_RC=$?
check "conflict-audit exits 0 (it is a report, not a verdict)" "$CONF_RC"
check "surfaces the semicolon co-occurrence" "$(contains "$CONF" "'semicolon' appears in 2 files")"
check "names style.md"                       "$(contains "$CONF" "$BROKEN/style.md")"
check "names style-v2.md"                    "$(contains "$CONF" "$BROKEN/style-v2.md")"
check "carries the not-all-overlaps caveat"  "$(contains "$CONF" "co-occurrence is not a verdict")"

CONF_CUSTOM=$(./tools/conflict-audit.sh "$BROKEN" prisma 2>&1)
check "accepts the reader's own keywords"    "$(contains "$CONF_CUSTOM" "keywords: prisma")"

# --- context-budget ----------------------------------------------------------
BUDGET=$(./tools/context-budget.sh "$HEALTHY" 2>&1); BUDGET_RC=$?
check "context-budget exits 0"            "$BUDGET_RC"
check "says UPPER BOUND out loud"         "$(contains "$BUDGET" "UPPER BOUND")"
check "carries the never-happens caveat"  "$(contains "$BUDGET" "never actually happens")"
BUDGET_NUM=$(printf '%s' "$BUDGET" | sed -n 's/^UPPER BOUND: \([0-9][0-9]*\) words.*/\1/p')
if [ -n "$BUDGET_NUM" ] && [ "$BUDGET_NUM" -gt 0 ]; then
  ok "context-budget printed a real number ($BUDGET_NUM words)"
else
  bad "context-budget did not print a word count"
fi

# --- all three take a directory argument -------------------------------------
for tool in skill-doctor conflict-audit context-budget; do
  OUT=$(./tools/"$tool".sh /nonexistent/skills 2>&1); RC=$?
  if [ "$RC" -eq 2 ] && printf '%s' "$OUT" | grep -q "usage:"; then
    ok "$tool.sh takes a directory argument and says so when it is wrong"
  else
    bad "$tool.sh should exit 2 with a usage line on a bad directory (got $RC)"
  fi
done

# --- every shipped SKILL.md is well-formed -----------------------------------
# the broken fixture is excluded on purpose: being malformed is its whole job.
BADNAME=0
BADDESC=0
SHIPPED=0
for f in $(find chapters templates tools/fixtures/healthy-library -type f -name '*.md' -o -type f -name '*.md.*' | grep -iE 'skill\.md' | LC_ALL=C sort); do
  SHIPPED=$((SHIPPED + 1))
  [ "$(basename "$f")" = "SKILL.md" ] || { BADNAME=$((BADNAME + 1)); echo "     wrong filename: $f"; }
  awk 'NR==1 && $0!="---" {exit 1} NR==1 {next} /^---[[:space:]]*$/ {exit 1} /^description:/ {found=1; exit 0} END {exit found?0:1}' "$f" \
    || { BADDESC=$((BADDESC + 1)); echo "     no description: $f"; }
done
if [ "$SHIPPED" -gt 0 ]; then
  ok "found $SHIPPED shipped SKILL.md files to check"
else
  bad "found no shipped SKILL.md files - the glob is wrong"
fi
check "every shipped skill file is named exactly SKILL.md" "$BADNAME"

# every shipped frontmatter has to survive a parser, not just contain the word description.
# the chapter 3 commit-messages skill shipped unparseable for one release: its description
# carried "(type(scope): description)" unquoted. see ERRATA.md.
BADYAML=0
for f in $(find chapters templates tools/fixtures/healthy-library -type f -name 'SKILL.md' | LC_ALL=C sort); do
  if awk 'NR==1 && $0!="---" {exit} NR==1 {next} /^---[[:space:]]*$/ {exit} {print}' "$f" |
     grep -qE '^[A-Za-z_][A-Za-z0-9_-]*:[[:space:]]+[^"'\''[:space:]{[][^"'\'']*:[[:space:]]'; then
    BADYAML=$((BADYAML + 1)); echo "     unquoted colon-space in frontmatter: $f"
  fi
done
check "no shipped frontmatter has an unquoted colon-space value" "$BADYAML"
check "every shipped skill file has a description: in its frontmatter" "$BADDESC"

# --- install.sh does real work and refuses to clobber ------------------------
TMP=$(mktemp -d)
INST=$(./install.sh "$TMP" 04 2>&1); INST_RC=$?
check "install.sh exits 0 on a fresh project" "$INST_RC"
check "install.sh prints the plan first"      "$(contains "$INST" "install plan")"
check "install.sh prints the ch11 next step"  "$(contains "$INST" "What skills are currently loaded")"
COPIED=$(find "$TMP/.claude/skills" -name SKILL.md | wc -l | tr -d ' ')
if [ "$COPIED" = "5" ]; then
  ok "install.sh copied the 5 chapter-4 skills"
else
  bad "expected 5 skills in the target, found $COPIED"
fi

REDO=$(./install.sh "$TMP" 04 2>&1); REDO_RC=$?
if [ "$REDO_RC" -ne 0 ]; then
  ok "install.sh refuses to overwrite without --force (exit $REDO_RC)"
else
  bad "install.sh overwrote an existing skill without --force"
fi
check "and says why"  "$(contains "$REDO" "re-run with --force")"

./install.sh "$TMP" 04 --force >/dev/null 2>&1; FORCED_RC=$?
check "install.sh --force goes through" "$FORCED_RC"

# --- migrate.sh --------------------------------------------------------------
./chapters/05-architecture-that-scales/migrate.sh "$TMP/.claude/skills" >/dev/null 2>&1; MIG_RC=$?
check "migrate.sh exits 0" "$MIG_RC"
if [ -f "$TMP/.claude/skills/11-global/stop-slop/SKILL.md" ]; then
  ok "migrate.sh moved stop-slop into 11-global/"
else
  bad "stop-slop is not in 11-global/ after the migration"
fi
DOC_MIG_RC=0; ./tools/skill-doctor.sh "$TMP/.claude/skills" >/dev/null 2>&1 || DOC_MIG_RC=$?
check "the migrated library still passes skill-doctor" "$DOC_MIG_RC"
rm -rf "$TMP"

# -----------------------------------------------------------------------------
TOTAL=$((PASS + FAIL))
echo
echo "$TOTAL assertions: $PASS passed, $FAIL failed"
[ "$TOTAL" -gt 0 ] || { echo "no assertions ran - that is a failure by itself" >&2; exit 1; }
[ "$FAIL" -eq 0 ] || exit 1
