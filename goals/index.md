---
title: Goals
layout: default
summary: "Everything currently being worked on."
---

# Goals (active work)

Use filters: Status, Category, Impact, Time stuck.

{% assign goals = site.data.goals | where_exp: "g", "g.status != 'completed'" %}
<ul>
{% for g in goals %}
  <li>
    <a href="/goals/{{ g.slug }}/">{{ g.title }}</a> — <strong>{{ g.status }}</strong>
    <br/>Category: {{ g.category }} • Impact: {{ g.impact_score }}
    <div style="width:200px;background:#eee">
      <div style="width:{{ g.progress | default:10 }}%;background:#2b8aef;height:10px"></div>
    </div>
  </li>
{% endfor %}
</ul>