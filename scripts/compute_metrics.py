#!/usr/bin/env python3
import yaml
from datetime import datetime
from pathlib import Path
import sys

DATA_FILE = Path("_data/goals.yml")
OUT_FILE = Path("_data/metrics.yml")

if not DATA_FILE.exists():
    print("No goals data found.", file=sys.stderr)
    sys.exit(0)

goals = yaml.safe_load(DATA_FILE.read_text())
now = datetime.utcnow()

active = [g for g in goals if g.get("status") != "completed"]
completed = [g for g in goals if g.get("status") == "completed"]

def parse_date(s):
    return datetime.strptime(s, "%Y-%m-%d")

days_in_stage = []
for g in goals:
    try:
        start = parse_date(g.get("current_stage_start_date"))
        days = (now - start).days
        days_in_stage.append(days)
    except:
        pass

metrics = {
    "generated_at": now.strftime("%Y-%m-%dT%H:%M:%SZ"),
    "goals_active": len(active),
    "goals_completed": len(completed),
    "avg_days_in_stage": int(sum(days_in_stage)/len(days_in_stage)) if days_in_stage else 0
}

OUT_FILE.write_text(yaml.dump(metrics, sort_keys=False))
print("Metrics written to", OUT_FILE)