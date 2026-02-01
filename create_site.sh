#!/usr/bin/env bash
# Usage: run from the root of your local repo: ./create_site.sh
set -euo pipefail

BRANCH="design"
COMMIT_MSG="Add site layout, styles, scripts, and page skeletons"

# Safety checks
if ! command -v git >/dev/null 2>&1; then
  echo "git is required. Install git and try again." >&2
  exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "This directory is not a git repo. cd into your repo clone and re-run." >&2
  exit 1
fi

if git show-ref --verify --quiet refs/heads/"$BRANCH"; then
  echo "Branch '$BRANCH' already exists locally. Rename or delete it and try again." >&2
  exit 1
fi

# verify origin remote exists
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "No 'origin' remote found. Please add your remote and retry (e.g., git remote add origin <url>)." >&2
  exit 1
fi

# Create branch
git checkout -b "$BRANCH"

# Create directories
mkdir -p _layouts assets/css assets/js goals wall/people wall/deeds _data scripts .github/workflows

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
  <header class="site-header">
    <div class="wrap header-inner">
      <a class="brand" href="/">{{ site.title | default: "Inspect your government like code." }}</a>

      <button id="nav-toggle" class="nav-toggle" aria-expanded="false" aria-controls="site-nav" aria-label="Open navigation">
        <span class="hamburger"></span>
      </button>

      <nav id="site-nav" class="main-nav" role="navigation" aria-label="Main">
        <a href="/" class="{% if page.url == '/' %}active{% endif %}">Home</a>
        <a href="/manifesto" class="{% if page.url contains '/manifesto' %}active{% endif %}">Manifesto</a>
        <a href="/plan" class="{% if page.url contains '/plan' %}active{% endif %}">My direct plan</a>
        <a href="/immediate" class="{% if page.url contains '/immediate' %}active{% endif %}">If in office (IMMEDIATELY)</a>
        <a href="/metrics" class="{% if page.url contains '/metrics' %}active{% endif %}">Stats & Progress</a>
        <a href="/awards" class="{% if page.url contains '/awards' %}active{% endif %}">Good Citizen Awards</a>
        <a href="/contact" class="{% if page.url contains '/contact' %}active{% endif %}">Contact</a>
      </nav>
    </div>
  </header>

  <main class="wrap content" id="main-content" tabindex="-1">
    {{ content }}
  </main>

  <footer class="site-footer">
    <div class="wrap">
      <small>Last site update: {{ site.time | date: "%Y-%m-%d" }} • Data & privacy disclaimer • <a href="/about">About</a></small>
    </div>
  </footer>

  <script src="/assets/js/site.js" defer></script>
</body>
</html>
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
body{font-family:Inter,system-ui,-apple-system,Segoe UI,Roboto,"Helvetica Neue",Arial,sans-serif;color:#111;background:var(--bg);line-height:1.5;margin:0}
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

@media (max-width:820px){
  .nav-toggle{display:block}
  .main-nav{position:fixed;right:12px;top:64px;background:var(--surface);padding:12px;border-radius:8px;box-shadow:0 6px 24px rgba(0,0,0,0.12);flex-direction:column;gap:6px;display:none}
  .main-nav.open{display:flex}
  .wrap{padding:12px}
}
CSS

cat > assets/js/site.js <<'JS'
// tiny nav toggle for mobile
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

cat > index.md <<'MD'
---
title: Home
layout: default
summary: "Open-source government prototype — live, verifiable, and public-by-default."
---

# Welcome

Inspect your government like code.

This site is a living record of priorities, progress, and evidence. Use the top navigation to jump to the Manifesto, my direct plan, immediate actions, stats/progress, awards, or contact.

- [Read the Manifesto](/manifesto)
- [See the plan](/plan)
- [Stats & Progress](/metrics)
MD

cat > manifesto.md <<'MD'
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
MD

cat > plan.md <<'MD'
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
MD

cat > immediate.md <<'MD'
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
MD

cat > metrics.md <<'MD'
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
MD

cat > awards.md <<'MD'
---
title: Good Citizen Awards
layout: default
summary: "Verified deeds and recognitions — Wall of Honor."
---

# Good Citizen Awards

This is the Wall of Honor index — verified deeds and persons are listed here.

- [Nominate someone](#) (link the Google Form or an issue)
MD

cat > contact.md <<'MD'
---
title: Contact
layout: default
summary: "Email contact for official correspondence and press."
---

# Contact

For inquiries, please email:

contact@yourdomain.example

(Replace with the public campaign email address you want to publish. If you want to avoid spam, obfuscate the address or use a form.)
MD

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

# optional README
cat > README.md <<'TXT'
This repository is the source for the campaign site.
Files added by create_site.sh. Branch created: design
TXT

# git add / commit / push
git add .
git commit -m "$COMMIT_MSG"
git push -u origin "$BRANCH"

# attempt to open a PR if gh is available
if command -v gh >/dev/null 2>&1; then
  echo "Creating a Pull Request using gh..."
  gh pr create --title "Add site layout and pages" --body "Adds base layout, styles, scripts, and skeleton pages for the site." --base main --head "$BRANCH" || echo "gh pr create failed or cancelled."
else
  echo "Branch '$BRANCH' pushed. Create a PR on GitHub from $BRANCH → main when ready."
fi

echo "Done. Edit files on branch '$BRANCH' and open a PR to main when ready."