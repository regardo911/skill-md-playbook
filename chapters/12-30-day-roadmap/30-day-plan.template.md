# 30-day skills plan

## Baseline (fill these in before day 1)

| | value |
|---|---|
| skills I have right now | `unknown, you must observe this` |
| minutes per day correcting Claude | `unknown, you must observe this` |
| times per week I paste the same instruction | `unknown, you must observe this` |

The first one comes from `tools/skill-doctor.sh <your skills dir>`. The other two come from you, with a
timer, over about three days. Guessing them makes day 30 meaningless.

## Week 1: foundation (target: 10-12 skills)

- [ ] **Day 1.** Use Claude on real work for 30 minutes. Write down every correction, specifically.
      Not "code quality" but "used `var` instead of `const`". Each line becomes a rule.
- [ ] **Day 2-3.** Build 4 to 6 skills from that list.
- [ ] **Day 4.** Move everything into category folders.
- [ ] **Day 5-6.** Add one hook. Lint-after-edit is the easiest one to see working.
- [ ] **Day 7.** Read every skill file. Delete anything that hasn't changed an output this week.

Skills at end of week 1: `____`

Four to six ideas from day 1, written here:

1.
2.
3.
4.
5.
6.

## Week 2: expansion (target: 20+)

- [ ] **Day 8-9.** Project-specific skills. Business rules, domain vocabulary, module conventions.
- [ ] **Day 10.** Memory skill. Stack, decisions and why, current sprint.
- [ ] **Day 11-12.** Stack-specific skills.
- [ ] **Day 13.** Second hook.
- [ ] **Day 14.** Merge anything that overlaps. Split anything doing two jobs. Run the conflict audit.

Skills at end of week 2: `____`   ·   correction minutes/day now: `____`

## Week 3: the advanced patterns (target: 30+)

- [ ] **Day 15-16.** Add self-evaluation, update conventions and manual workflow notes to your most-used
      skill. Run one round. One.
- [ ] **Day 17.** Build the skill generator.
- [ ] **Day 18-19.** MCP, if you have a database or an external API worth reaching.
- [ ] **Day 20.** One non-code skill.
- [ ] **Day 21.** Use Claude hard for a full session and write down every remaining rough edge.

Skills at end of week 3: `____`

## Week 4: polish and package

- [ ] **Day 22-23.** Build skills for the day-21 list.
- [ ] **Day 24.** Quality audit. For every rule, ask whether you could write a lint check for it. If not,
      rewrite it.
- [ ] **Day 25-26.** Package the best of it as a template with README, INSTALL and CUSTOMIZE.
- [ ] **Day 27.** Share one skill publicly with a before and after.
- [ ] **Day 28-29.** Set up whichever of consulting or selling you actually want.
- [ ] **Day 30.** Re-measure the three numbers.

## Day 30

| | day 0 | day 30 |
|---|---|---|
| skills | | |
| minutes per day correcting Claude | | |
| times per week pasting instructions | | |

One monetisation milestone, done or not: `____________________`

## After

Weekly, ten minutes: update the memory skill's Active Context, review anything a self-improvement round
changed. Monthly, fifteen: run the conflict audit, delete stale skills, tighten the descriptions that have
started to overlap. When Claude Code ships a release that touches the spec, re-test the library.
