---
description: Fold what your shipped work proves back into brand/BRAND.md (run it every few pieces)
argument-hint: [reel output folder — omit to scan everything in ./output/]
---
Use the `content-studio` skill. Check `./brand/BRAND.md` exists; if not, tell me to run
`/content-studio:setup` first.

Run `${CLAUDE_PLUGIN_ROOT}/agents/11-learn-agent.md` for **$ARGUMENTS**, or across every
folder in `./output/` if I gave you nothing.

Only pieces whose `EVALUATION.md` says `SHIP` count as evidence. Append to `learned.shipped`
and `learned.recurring_fixes` in `./brand/BRAND.md` — and **nothing else**; my interview
answers stay mine.

Show me the diff and wait for a yes before writing. If fewer than three pieces have shipped,
say there is no pattern yet rather than inventing one.
