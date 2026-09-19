---
description: Install the studio's companion plugins and the Remotion video bed (run once)
argument-hint: [--minimal | --no-video | --dry-run]
---
Run `bash "${CLAUDE_PLUGIN_ROOT}/install.sh" $ARGUMENTS` and show me the output.

It adds the plugin marketplaces and installs the companion plugins the studio was built
with (superpowers, frontend-design, taches-cc-resources, claude-mem, ralph-wiggum,
intelligent-web-scraper, youtube-data-api), then runs `npm install` in
`${CLAUDE_PLUGIN_ROOT}/video/` so `/content-studio:video` can render.

None of them are required for `/content-studio:reel` — they widen what the studio can do.
`--minimal` installs only superpowers, `--no-video` skips Remotion, `--dry-run` prints
what it would do. Afterwards tell me to restart Claude Code so the new plugins load.
