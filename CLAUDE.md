# CLAUDE.md — developing the Content Studio plugin

This folder is the **plugin source**, not a content folder. If you opened it to use the
studio, you are in the wrong place: install the plugin (see `README.md`), then `cd` to a
folder where you want your content to live.

The operating manual Claude actually loads at runtime is
`skills/content-studio/SKILL.md`. Change behaviour there, not here.

## Layout

| Path | What | Who writes it |
|---|---|---|
| `.claude-plugin/plugin.json` | manifest | you |
| `.claude-plugin/marketplace.json` | single-plugin marketplace, so the repo installs directly | you |
| `commands/*.md` | the eight slash commands | you |
| `skills/content-studio/SKILL.md` | the pipeline, the triggers, the rules | you |
| `hooks/hooks.json` → `scripts/first-open.sh` | SessionStart check, silent outside a studio folder | you |
| `agents/*.md` | the specialists | you |
| `standards/CONTENT-STANDARD.md` | the rulebook the gates score against | you |
| `templates/brand/` | the blank `BRAND.md` copied into the creator's folder on setup | you |
| `video/` | the Remotion bed project | you |
| `examples/demo-brand/` | worked example, a fictional bakery | you |

## The path rule

Anything the plugin owns is addressed as `${CLAUDE_PLUGIN_ROOT}/…` — agents, standards,
templates, the Remotion project. Anything the creator owns is addressed relative to their
working directory — `./brand/BRAND.md`, `./brand/keywords.md`, `./output/`.

Get this wrong and the studio either writes content into the plugin (where it is lost on
the next update) or looks for the brand profile in the wrong folder. When you add an agent
or a command, check both sides.

## Before you publish a change

- `node -e 'JSON.parse(require("fs").readFileSync(".claude-plugin/plugin.json"))'` and the
  same for `marketplace.json` and `hooks/hooks.json`.
- `bash -n scripts/first-open.sh install.sh`
- Run the hook in all three states: a folder with no `brand/`, one with `status: not set up`,
  one set up. It must be silent in the first.
- `./install.sh --dry-run`
- Install it locally and run `/content-studio:setup` then `/content-studio:reel` end to end
  in a scratch folder.
