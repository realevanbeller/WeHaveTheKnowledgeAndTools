---
id: goal-000
title: "Short title for goal"
slug: "short-title"
category: "Permits"
status: "active" # active / stalled / completed / cancelled
start_date: 2026-01-01
expected_duration_days: 90
current_stage: "Research"
current_stage_start_date: 2026-01-15
blocker_type: "Process" # Process, Capacity, Legal, Political, Technical, None
impact_score: 7 # 1-10
progress: 20 # percent
---

# {{ page.title }}

## A. Goal overview
What this goal is, why it matters, who it affects.

## B. Progress
- Current stage: **{{ page.current_stage }}**  
- Days in stage: **{{ 'now' | date: "%s" | minus: page.current_stage_start_date | divided_by: 86400 | round }}** (rendered by automation if desired)

## C. Timeline Log
- 2026-01-15 — Research started — [doc link](https://drive.google.com/...)
- 2026-02-01 — Public post — [evidence](https://drive.google.com/...)

## D. Blockers
- Process: explain
- Capacity: explain
- Legal: explain
- Technical: explain

## E. Next actions
- [ ] Action 1 — owner
- [ ] Action 2 — owner

## F. What surprised me
Short lessons learned.

## G. What works here
Things worth preserving.