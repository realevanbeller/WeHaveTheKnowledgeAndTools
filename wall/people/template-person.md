---
slug: "last-first"
display_name: "First L."
city: "City, Neighborhood"
bio: "2–3 line approved bio"
badges:
  - "Mutual Aid"
verified_deeds:
  - "/wall/deeds/deed-example"
layout: default
---

# {{ page.display_name }}

{{ page.bio }}

## Verified deeds
{% raw %}
{% for d in page.verified_deeds %}
- [{{ d }}]({{ d }})
{% endfor %}
{% endraw %}
