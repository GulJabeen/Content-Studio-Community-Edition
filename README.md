# Content Studio — a Claude Code plugin

A reel-first content pipeline that lives inside Claude Code. It interviews you about your
brand once, writes a brand profile, and from then on every reel, caption and carousel it
produces is built for *your* product, *your* audience and *your* voice — and checked by
three quality gates before you see it.

It is not a template pack. Nothing here is written until you have answered the interview.

```
you  →  /content-studio:setup (interview)  →  brand/BRAND.md
you  →  /content-studio:reel "topic"       →  script → structure → humanize → evaluate → captions
you  →  record it, post it
```

---

## Install

```
/plugin marketplace add guljabeen/content-studio
/plugin install content-studio@techwithgul
```

Or from a local clone:

```
/plugin marketplace add /path/to/content-studio
/plugin install content-studio@techwithgul
```

Then restart Claude Code.

**Optional, once:** `/content-studio:install` adds the companion plugins the studio was
built with (superpowers, frontend-design, taches-cc-resources, claude-mem, ralph-wiggum,
intelligent-web-scraper, youtube-data-api) and runs `npm install` for the Remotion video
bed. None of them are needed for `/content-studio:reel` — but `/content-studio:video`
will not render until Remotion is installed.

## Use it

`cd` to the folder you want your content to live in — a new empty folder is fine — and:

```
/content-studio:setup                    # ten questions, one at a time
/content-studio:reel how I plan a week of content in 20 minutes
```

The studio writes two things into *your* folder and nothing else:

```
your-folder/
├── brand/
│   ├── BRAND.md      your profile — every agent reads it first and refuses to run without it
│   └── keywords.md   the CTA keywords you have used, so none collide
└── output/
    └── 2026-09-19-plan-a-week-of-content/
        ├── brief.md        the angle, three hooks, the one thing taught
        ├── voiceover.md    the script with beat markers, timing, on-screen text
        ├── resources.md    every claim and where it came from; the CTA keyword
        ├── captions.md     Instagram · TikTok · YouTube Shorts, paste-ready
        └── EVALUATION.md   the three gate reports and the final SHIP verdict
```

`START-HERE.md` walks the first run line by line.

## Commands

| Command | What it does |
|---|---|
| `/content-studio:setup` | the interview; writes `brand/BRAND.md`. Run this first. |
| `/content-studio:idea <topic \| this week>` | three content briefs to choose from, no script yet |
| `/content-studio:reel <topic>` | the full pipeline: brief → script → three gates → captions |
| `/content-studio:captions <folder>` | re-generate the three platform captions for a reel |
| `/content-studio:carousel <topic>` | a slide-by-slide carousel plan with exact copy |
| `/content-studio:check <folder>` | re-run the gates on something you edited by hand |
| `/content-studio:video <folder>` | render the Remotion motion-graphics bed |
| `/content-studio:install` | the companion plugins + Remotion (once) |

You can also just talk to it — "write me a reel about X", "caption this", "is this
accurate" — the skill picks the right specialist.

## What is inside the plugin

```
content-studio/
├── .claude-plugin/plugin.json   the plugin manifest
├── commands/                    the eight slash commands
├── skills/content-studio/       how Claude operates the studio (the pipeline, the rules)
├── hooks/hooks.json             a SessionStart check — silent unless you are in a studio folder
├── agents/                      the specialists, numbered in pipeline order
│   ├── 00-onboarding-agent.md      the interview
│   ├── 01-idea-agent.md            topic → content brief with three hooks
│   ├── 02-reel-script-agent.md     brief → voiceover.md + resources.md
│   ├── 03-reel-structure-agent.md  gate 1: beat order
│   ├── 04-humanize-agent.md        gate 2: strip the AI-writing shape
│   ├── 05-evaluator-agent.md       gate 3: SHIP or FIX
│   ├── 06-caption-agent.md         Instagram · TikTok · YouTube Shorts captions
│   ├── 07-carousel-agent.md        slide-by-slide plan you lay out in any design tool
│   ├── 08-fact-check-agent.md      verify every claim before you post
│   └── 09-video-bed-agent.md       shipped script → Remotion bed in your brand colours
├── standards/CONTENT-STANDARD.md   the rulebook the gates score against
├── templates/brand/                the blank BRAND.md copied into your folder on setup
├── video/                          the Remotion project: src/reel.json in, bed.mp4 out
├── examples/demo-brand/            a complete worked example for a fictional bakery
├── prompts/                        one paste-in prompt for people not using Claude Code
└── install.sh                      what /content-studio:install runs
```

Plugin files are read-only. The studio writes only to `brand/` and `output/` in your folder.

## The one rule under all of it

Nothing is shown to you until it has passed three gates, in this order:

```
draft → 🎬 STRUCTURE → 🧬 HUMANIZE → 🧪 EVALUATE → shown to you
                            ↑              │
                            └──── FIX ─────┘   loops until SHIP
```

- **Structure** puts the beats in the order that holds attention: hook, then the
  surprise, then who you are, then the teaching, then one ask.
- **Humanize** removes the shape of machine writing: the over-explained moral, the tidy
  ending, the vague "experts say". It does not chase AI-detector scores, which are
  biased against people writing English as a second language.
- **Evaluate** scores the piece against `standards/CONTENT-STANDARD.md` and your own
  no-go list from `BRAND.md`. A FIX verdict goes back through Humanize, not straight to you.

## What this does not do

- It does not film or edit your take. It renders a **bed** (the motion-graphics
  background) from the script; you record over it, or post the 9:16 bed alone.
- It does not render carousel images. The carousel agent gives you a slide-by-slide plan
  with exact copy and a layout note per slide; you build it in Canva, Figma or Keynote.
- It does not post. Captions are paste-ready; posting is yours.
- It does not scrape competitors or fetch logos.

## Requirements

Claude Code, and Node 18+ if you want the video bed. Remotion bundles its own ffmpeg;
no Python, no API keys (youtube-data-api is the one companion plugin that wants a key,
and only if you use it).

If you use ChatGPT or the Claude web app instead, `prompts/one-prompt-reel.md` compresses
the whole pipeline into one message you paste with your `BRAND.md`.

---

Made by Gul (@techwithgul.ai) for the Tech With Gul community. Use it, change it, ship with it.
