---
title: Wall of Honor
layout: default
summary: "Verified community deeds and recognition."
---

# Wall of Honor

A curated list of verified deeds. Each deed is a single permalink with evidence and verification method.

[Nominate someone → nomination form link]

<ul>
{% for person in site.data.people %}
  <li><a href="/wall/people/{{ person.slug }}/">{{ person.display_name }}</a> — Verified deeds: {{ person.verified_deeds_count }}</li>
{% endfor %}
</ul>