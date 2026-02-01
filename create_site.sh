#!/usr/bin/env bash
# create_all.sh
# Save at the root of your local repo, then:
# chmod +x create_all.sh
# ./create_all.sh
set -euo pipefail

# Config
BASE_BRANCH="main"
PREFERRED_BRANCH="design"
TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BRANCH="$PREFERRED_BRANCH"
REPO_ROOT="$(pwd)"

# Helper: check command exists
have() { command -v "$1" >/dev/null 2>&1; }

# Ensure inside a git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "ERROR: Not inside a git repo. cd to your repo clone and re-run." >&2
  exit 1
fi

# Ensure working tree is clean (optional safety)
if ! git diff --quiet || ! git diff --cached --quiet; then
  echo "WARNING: You have uncommitted changes. It's safer to commit or stash them before running this script."
  read -p "Continue anyway? (y/N): " yn
  case "$yn" in
    [Yy]*) ;;
    *) echo "Abort."; exit 1;;
  esac
fi

# Determine branch name: if PREFERRED_BRANCH exists locally, append timestamp
if git show-ref --verify --quiet refs/heads/"$PREFERRED_BRANCH"; then
  BRANCH="${PREFERRED_BRANCH}-${TIMESTAMP}"
  echo "Local branch '$PREFERRED_BRANCH' exists — using branch '$BRANCH' instead."
fi

# Create new branch off current HEAD (or optionally off main)
git checkout -b "$BRANCH"
echo "Switched to new branch: $BRANCH"

# Create directories
mkdir -p _layouts _includes assets/css assets/js goals wall/people wall/deeds _data scripts .github/workflows

# Write files
cat > _layouts/default.html <<'HTML'
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>{{ page.title | default: site.title }}</title>
  <link rel="stylesheet" href="/assets/css/style.css" />
  <meta name="description" content="{{ page.summary | default: site.description }}" />
</head>
<body>
  {% include header.html %}
  <main class="wrap content" id="main-content" tabindex="-1">
    {{ content }}
  </main>
  {% include footer.html %}
  <script src="/assets/js/site.js" defer></script>
</body>
</html>
HTML

cat > _includes/header.html <<'HTML'
<header class="site-header" role="banner">
  <div class="wrap header-inner">
    <a class="brand" href="/">{{ site.title | default: "Inspect your government like code." }}</a>

    <button id="nav-toggle" class="nav-toggle" aria-expanded="false" aria-controls="site-nav" aria-label="Open navigation">
      <span class="hamburger"></span>
    </button>

    <nav id="site-nav" class="main-nav" role="navigation" aria-label="Main">
      <a href="/" {% raw %}{% if page.url == "/" %}class="active"{% endif %}{% endraw %}>Home</a>
      <a href="/manifesto" {% raw %}{% if page.url contains "manifesto" %}class="active"{% endif %}{% endraw %}>Manifesto</a>
      <a href="/plan" {% raw %}{% if page.url contains "plan" %}class="active"{% endif %}{% endraw %}>My direct plan</a>
      <a href="/immediate" {% raw %}{% if page.url contains "immediate" %}class="active"{% endif %}{% endraw %}>If in office</a>
      <a href="/metrics" {% raw %}{% if page.url contains "metrics" %}class="active"{% endif %}{% endraw %}>Stats & Progress</a>
      <a href="/goals" {% raw %}{% if page.url contains "goals" %}class="active"{% endif %}{% endraw %}>Goals</a>
      <a href="/awards" {% raw %}{% if page.url contains "awards" %}class="active"{% endif %}{% endraw %}>Good Citizen Awards</a>
      <a href="/contact" {% raw %}{% if page.url contains "contact" %}class="active"{% endif %}{% endraw %}>Contact</a>
    </nav>
  </div>
</header>
HTML

cat > _includes/footer.html <<'HTML'
<footer class="site-footer" role="contentinfo">
  <div class="wrap">
    <div class="footer-left">
      <small>Last update: {{ site.time | date: "%Y-%m-%d" }}</small>
    </div>
    <div class="footer-right">
      <small><a href="/about">About</a> • Data & privacy disclaimer</small>
    </div>
  </div>
</footer>
HTML

cat > assets/css/style.css <<'CSS'
:root{
  --accent:#0b76ff;
  --muted:#666;
  --bg:#fff;
  --surface:#fafafa;
  --max-width:980px;
  --radius:8px;
  --gap:16px;
}
*{box-sizing:border-box}
body{font-family:system-ui,-apple-system,Segoe UI,Roboto,"Helvetica Neue",Arial,sans-serif;color:#111;background:var(--bg);line-height:1.5;margin:0}
.wrap{max-width:var(--max-width);margin:0 auto;padding:18px}
.header-inner{display:flex;align-items:center;gap:12px}
.brand{font-weight:700;color:var(--accent);text-decoration:none;font-size:1.125rem}
.site-header{border-bottom:1px solid #eee;background:var(--surface);position:sticky;top:0;z-index:30}
.main-nav{margin-left:auto;display:flex;gap:10px;align-items:center}
.main-nav a{padding:8px 10px;color:var(--muted);text-decoration:none;border-radius:6px}
.main-nav a:hover{background:#fff;border:1px solid #eee;color:#000}
.main-nav a.active{background:var(--accent);color:#fff}

.nav-toggle{display:none;background:transparent;border:0;padding:8px;border-radius:6px;margin-left:auto}
.hamburger{width:22px;height:2px;background:var(--muted);display:inline-block;position:relative}
.hamburger::before,.hamburger::after{content:"";position:absolute;left:0;width:22px;height:2px;background:var(--muted)}
.hamburger::before{top:-7px} .hamburger::after{top:7px}

.content h1{margin-top:0}
.card{border:1px solid #eee;padding:12px;border-radius:var(--radius);background:#fff;margin-bottom:12px}
.progress{height:12px;background:#eee;border-radius:8px;overflow:hidden}
.progress > i{display:block;height:100%;background:var(--accent)}

.site-footer{border-top:1px solid #eee;background:#fff;padding:12px 0;margin-top:24px}
.site-footer .wrap{display:flex;justify-content:space-between;align-items:center;font-size:0.95rem;color:var(--muted)}

@media (max-width:820px){
  .nav-toggle{display:block}
  .main-nav{position:fixed;right:12px;top:64px;background:var(--surface);padding:12px;border-radius:8px;box-shadow:0 6px 24px rgba(0,0,0,0.12);flex-direction:column;gap:6px;display:none}
  .main-nav.open{display:flex}
  .wrap{padding:12px}
}
CSS

cat > assets/js/site.js <<'JS'
// small nav toggle for mobile
document.addEventListener("DOMContentLoaded", function(){
  var btn = document.getElementById("nav-toggle");
  var nav = document.getElementById("site-nav");
  if(!btn || !nav) return;
  btn.addEventListener("click", function(){
    var open = nav.classList.toggle("open");
    btn.setAttribute("aria-expanded", open ? "true" : "false");
  });
});
JS

cat > index.md <<'MARKDOWN'
---
title: Home
layout: default
summary: "Landing page and quick links."
---

# Welcome

This site is a living, public-by-default record of priorities, progress, and evidence.

Quick links:
- [Manifesto](/manifesto) — Principles that guide every decision.
- [My direct plan](/plan) — Priorities, timelines, outcomes.
- [If in office — IMMEDIATELY](/immediate) — Actionable first steps.
- [Stats & Progress](/metrics) — Live metrics and progress bars.
- [Goals](/goals) — All active initiatives.
- [Good Citizen Awards](/awards) — Wall of Honor & verified deeds.
- [Contact](/contact) — Email and contact instructions.

Tip: add `layout: default` to any new page's front matter to include the header/footer automatically.
MARKDOWN

cat > manifesto.md <<'MARKDOWN'
---
title: Manifesto
layout: default
summary: "Principles: Legibility, Process, Receipts, Progress, Public by Default"
---

# Manifesto

- Legibility over polish — clarity beats aesthetics.
- Process over personalities — systems are accountable.
- Receipts over rhetoric — link to evidence.
- Progress over perfection — show iteration.
- Public by default — private only when required.

Every page answers: "Can a normal person understand what is happening and why?"
MARKDOWN

cat > plan.md <<'MARKDOWN'
---
title: My direct plan
layout: default
summary: "A concise plan of priorities, timelines, and measurable outcomes."
---

# My direct plan

This page lists the prioritized initiatives, target outcomes, and timelines.

- Priority 1 — Short goal title
  - Outcome: What success looks like
  - Timeline: 90 days
  - Metric: Measurable target
MARKDOWN

cat > immediate.md <<'MARKDOWN'
---
title: If in office (IMMEDIATELY)
layout: default
summary: "Actions I would take in the first 100 days, with executable steps."
---

# If in office — IMMEDIATELY

This is a short checklist of direct, executable steps I would do on day 1–100 (examples):

1. Issue a transparency executive memo — publish all active requests and workflows.
2. Stand up a two-person rapid-response team for permits and critical business intake.
3. Publish a 30/60/90 day public scoreboard and commit to weekly updates.
MARKDOWN

cat > metrics.md <<'MARKDOWN'
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
MARKDOWN

cat > awards.md <<'MARKDOWN'
---
title: Good Citizen Awards
layout: default
summary: "Verified deeds and recognitions — Wall of Honor."
---

# Good Citizen Awards

This is the Wall of Honor index — verified deeds and persons are listed here.

- [Nominate someone](#) (link the Google Form or an issue)
MARKDOWN

cat > contact.md <<'MARKDOWN'
---
title: Contact
layout: default
summary: "Email contact for official correspondence and press."
---

# Contact

For inquiries, please email:

contact@yourdomain.example

(Replace with the public campaign email address you want to publish. If you want to avoid spam, obfuscate the address or use a form.)
MARKDOWN

cat > goals/index.md <<'MARKDOWN'
---
title: Goals
layout: default
summary: "Everything currently being worked on."
---

# Goals (active work)

Use filters: Status, Category, Impact, Time stuck.

(Each goal should be a Markdown file under goals/ with front matter and a slug. You can also use _data/goals.yml as a canonical data store.)
MARKDOWN

cat > goals/templates/goal-template.md <<'MARKDOWN'
---
id: goal-000
title: "Short title for goal"
slug: "short-title"
category: "Permits"
status: "active"
start_date: 2026-01-01
expected_duration_days: 90
current_stage: "Research"
current_stage_start_date: 2026-01-15
blocker_type: "Process"
impact_score: 7
progress: 20
layout: default
---

# {{ page.title }}

## A. Goal overview
What this goal is, why it matters, who it affects.

## B. Progress
- Current stage: **{{ page.current_stage }}**
- Days in stage: (automation will compute)

## C. Timeline Log
- 2026-01-15 — Research started — [doc link](https://drive.google.com/...)

## D. Blockers
...

## E. Next actions
- [ ] Action 1
MARKDOWN

cat > wall/people/template-person.md <<'MARKDOWN'
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
MARKDOWN

cat > wall/deeds/template-deed.md <<'MARKDOWN'
---
slug: "beach-cleanup-2026-01"
title: "Beach Cleanup — Santa Monica"
date: 2026-01-10
person_slug: "last-first"
verification_level: "Verified (Documented)"
proof_links:
  - "https://drive.google.com/..."
consent_obtained: true
redacted: false
layout: default
---

# {{ page.title }}

**What happened:** Short, plain description.

**Impact:** Collected 1,200 lbs trash; 56 volunteers.

**Proof**
- [Link](https://drive.google.com/...)

**Verification method:** {{ page.verification_level }}
MARKDOWN

cat > _data/goals.yml <<'YAML'
# sample goals data
- id: goal-001
  title: "Faster permit approvals — pilot"
  slug: "faster-permit-approvals-pilot"
  category: "Permits"
  status: "active"
  start_date: "2025-12-01"
  expected_duration_days: 120
  current_stage: "Pilot"
  current_stage_start_date: "2026-01-05"
  blocker_type: "Process"
  impact_score: 8
  progress: 35
YAML

cat > README.md <<'TEXT'
This repository is the source for the campaign site.
Files created by create_all.sh:
- shared layout: _layouts/default.html
- header/footer includes: _includes/header.html _includes/footer.html
- CSS/JS: assets/css/style.css assets/js/site.js
- pages: index.md manifesto.md plan.md immediate.md metrics.md awards.md contact.md
- goals and wall templates
- sample _data/goals.yml

Branch created: $BRANCH
Commit created: "Add site layout, styles, scripts, and page skeletons"
TEXT

# Optionally add .nojekyll to allow files beginning with underscores if desired (uncomment if needed)
# touch .nojekyll

# Git add & commit
git add .
git commit -m "Add site layout, styles, scripts, and page skeletons"

echo "Files created and committed on branch: $BRANCH"

# Offer to push & open a PR if gh is available
if have gh; then
  echo
  echo "GitHub CLI (gh) detected."
  read -p "Push branch '$BRANCH' to origin and open a PR now? (y/N): " yn
  case "$yn" in
    [Yy]*)
      git push -u origin "$BRANCH"
      # open PR using gh and prefill description
      gh pr create --title "Add site layout and page skeletons" --body "Adds base layout, header/footer includes, CSS, JS, and skeleton pages for the site." --base "$BASE_BRANCH" --head "$BRANCH"
      echo "Pushed and PR attempted via gh."
      ;;
    *)
      echo "Skipping push. To push later: git push -u origin $BRANCH"
      ;;
  esac
else
  echo
  echo "gh (GitHub CLI) not found. You can push the branch using GitHub Desktop or from terminal:"
  echo "  git push -u origin $BRANCH"
  echo "Then open a PR from '$BRANCH' → '$BASE_BRANCH' on GitHub."
fi

echo
echo "NEXT STEPS:"
echo "- Open the branch in GitHub Desktop and Push origin, or run the git push command printed above."
echo "- Preview locally: use Docker (no Ruby install) in project root:"
echo "    docker run --rm -it -p 4000:4000 -v \"\$(pwd)\":/srv/jekyll -e JEKYLL_ENV=development jekyll/jekyll:4 jekyll serve --watch --drafts"
echo "- Edit page files in PyCharm and iterate. When ready, open/merge the PR to main to publish."