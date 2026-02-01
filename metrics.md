---
title: Stats & Progress
layout: default
summary: "Live metrics and progress bars for goals and actions."
---

# Stats & Progress

- Goals active: **{{ site.data.metrics.goals_active | default: "—" }}**
- Goals completed: **{{ site.data.metrics.goals_completed | default: "—" }}**
- Avg days in stage: **{{ site.data.metrics.avg_days_in_stage | default: "—" }}**

## Progress bars (example)
<div class="card">
  <h3>Faster permit approvals — pilot</h3>
  <div class="progress"><i style="width:35%"></i></div>
  <small>Progress: 35% — Current stage: Pilot</small>
</div>
