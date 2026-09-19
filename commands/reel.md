---
description: Topic → brief → script → structure → humanize → evaluate → captions, shown only when it passes
argument-hint: <topic>
---
Use the `content-studio` skill. Check `./brand/BRAND.md` is set up; if not, run
`/content-studio:setup` first. Then run the full reel pipeline for: **$ARGUMENTS**.

Order, with every agent under `${CLAUDE_PLUGIN_ROOT}/agents/`:
`01-idea` (one brief) → `02-reel-script` (`voiceover.md` + `resources.md`) →
`03-reel-structure` → `04-humanize` → `05-evaluator` (loop on FIX via humanize) →
`06-caption` → `04-humanize` → `05-evaluator`.

Write everything to `./output/<YYYY-MM-DD>-<slug>/` including `EVALUATION.md`. Register the
keyword in `./brand/keywords.md` if the CTA style is comment-keyword.

Show me: the verdict, the folder path, the script to read aloud, and the
`Check before filming` list from `resources.md`.
