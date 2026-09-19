---
description: Render a motion-graphics bed for a shipped reel (run /content-studio:install once first)
argument-hint: <output folder of a reel that passed the gates>
---
Use the `content-studio` skill. Run `${CLAUDE_PLUGIN_ROOT}/agents/09-video-bed-agent.md`
for **$ARGUMENTS**: write `${CLAUDE_PLUGIN_ROOT}/video/src/reel.json` from its
`voiceover.md`, render a still and read it, render `ReelBed`, copy the MP4 into
**$ARGUMENTS** as `bed.mp4`, and state that the timing is the script's estimate until I
record.

If `${CLAUDE_PLUGIN_ROOT}/video/node_modules` is missing, stop and tell me to run
`/content-studio:install`.
