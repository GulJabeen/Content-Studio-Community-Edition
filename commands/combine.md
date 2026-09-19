---
description: Face cam + motion bed -> the finished 9:16 reel (run after /content-studio:video)
argument-hint: <reel output folder> <your face cam file>
---
Use the `content-studio` skill.

Run `bash "${CLAUDE_PLUGIN_ROOT}/scripts/combine.sh" $ARGUMENTS` and show me the output.

It reads `bed.mp4` from the reel's output folder and the face cam file I give you, measures
the **face cam's** duration and fps (the performance is the master; the bed follows it),
writes `${CLAUDE_PLUGIN_ROOT}/video/src/final.json`, renders the `ReelFinal` composition and
writes **`reel-final.mp4`** next to the bed.

Layout is 1080×1920: face cam cropped to fill the top 840px, the square bed underneath.
Pass a third argument to change the face cam height (e.g. `960` for a bigger face).

If there is no `bed.mp4`, tell me to run `/content-studio:video` first. If `video/node_modules`
is missing, tell me to run `/content-studio:install` first.

Afterwards, say plainly that this does not cut, caption or de-silence the take — it composites
the two layers. The performance is still mine.
