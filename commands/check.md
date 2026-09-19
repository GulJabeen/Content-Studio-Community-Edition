---
description: Re-run the three gates (structure → humanize → evaluate) on a folder you edited by hand
argument-hint: <output folder>
---
Use the `content-studio` skill. For **$ARGUMENTS**: run
`${CLAUDE_PLUGIN_ROOT}/agents/03-reel-structure-agent.md` (reels only) → `04-humanize` →
`05-evaluator` on every content file in the folder (`voiceover.md`, `captions.md`,
`carousel.md`). Fix and loop until SHIP. If a file is already clean, say "already clean"
and change nothing. Rewrite `EVALUATION.md` with the new reports and end with one table:
| File | Hook | Structure | Sourced | Length | No-go | Verdict |
