---
slug: "last-first"
display_name: "First L."
city: "City, Neighborhood"
bio: "2–3 line approved bio"
badges:
  - "Mutual Aid"
  - "Cleanup"
verified_deeds:
  - "/wall/deeds/deed-example"
---

# {{ page.display_name }}

{{ page.bio }}

## Verified deeds
{% for d in page.verified_deeds %}
- [{{ d }}]({{ d }})
{% endfor %}