# video/ — the Remotion bed

A small Remotion project that turns a shipped script into a five-beat motion-graphics
background ("bed") in your brand colours. You record your face over it, or use the 9:16
version on its own.

```bash
npm install                     # once (./install.sh at the root does this for you)
npm run studio                  # open the editor in the browser
npm run still                   # render one frame to out/check.png and look at it
npm run render                  # 1080×1080 square  → out/reel-bed.mp4
npm run render:vertical         # 1080×1920 9:16    → out/reel-bed-9x16.mp4
```

Everything is driven by `src/reel.json`: brand name, handle, four colours, and one entry
per beat with its on-screen text and its length in seconds. Change the JSON, re-render.
`agents/09-video-bed-agent.md` writes that JSON from a shipped `voiceover.md`.

The timing in the JSON is an estimate until you have recorded. Once you have a take, put
the real beat times in and render again; the bed then lands on your words.

Requirements: Node 18 or newer. Remotion bundles its own ffmpeg; nothing else to install.
