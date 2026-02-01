---
title: "Inspect your government like code."
layout: default
last_updated: 2026-02-01
summary: "Open-Source Government for the 21st Century — a living prototype of civic transparency."
---

# Inspect your government like code.

## Short manifesto
Legibility over polish. Process over personalities. Receipts over rhetoric. Progress over perfection. Public by default.

## How this works (3 steps)
1. We publish goals, decisions, and evidence as plain files (Markdown + YAML).
2. Every update is a git commit — public changelog.
3. Community can verify, propose fixes, or volunteer.

## Live snapshot
- Goals active: **{{ site.data.metrics.goals_active | default: "—" }}**
- Goals completed: **{{ site.data.metrics.goals_completed | default: "—" }}**
- Avg days in stage: **{{ site.data.metrics.avg_days_in_stage | default: "—" }}**

[See active goals](/goals)

---
Last site update: `{{ page.last_updated }}`
Data & privacy disclaimer: Public by default. Redactions applied where legally required.
Contact: [contact@evanbeller.com](mailto:contact@evanbeller.com)