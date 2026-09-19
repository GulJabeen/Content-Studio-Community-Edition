---
description: Write or rewrite the three platform captions for an existing reel folder
argument-hint: <output folder>
---
Use the `content-studio` skill. Run `${CLAUDE_PLUGIN_ROOT}/agents/06-caption-agent.md` on
**$ARGUMENTS** (its `voiceover.md` and `resources.md`), then `04-humanize` and
`05-evaluator` from the same folder. Overwrite `captions.md` and append the reports to
`EVALUATION.md`.
