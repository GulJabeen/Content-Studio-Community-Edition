# Start here

Ten minutes from an empty folder to a reel script that has passed three quality gates.

## 1. Install the plugin

Inside Claude Code:

```
/plugin marketplace add guljabeen/content-studio
/plugin install content-studio@techwithgul
```

Restart Claude Code. Type `/content-studio:` and you should see eight commands.

Optional, once — the companion plugins and the Remotion video bed:

```
/content-studio:install
```

Restart again. Skip this if you only want scripts and captions; `/content-studio:video`
is the only thing that needs it.

## 2. Make a folder for your content, and run the interview

```bash
mkdir my-content && cd my-content && claude
```

```
/content-studio:setup
```

Claude asks ten questions, **one at a time**. Answer in your own words; short is fine.
It will ask you to:

- describe what you sell or teach, and one real person it is for
- name your brand, handle and platforms
- list the three things you could teach for a year
- say what you can honestly claim about yourself (years, results, what you have tested)
- list what you can **never** say publicly (employer, clients, anything confidential)
- describe how you sound in three words, and three things you would never say
- time yourself reading a paragraph, so scripts are budgeted for *your* pace
- choose what a viewer should do after watching

At the end it shows you `brand/BRAND.md` and a proposed one-line intro for your reels.
Edit anything. When you say it is right, the studio is set up.

From then on, every session in this folder starts by telling you the profile is ready.
In any other folder the plugin stays quiet.

## 3. Make a reel

```
/content-studio:reel how I plan a week of content in 20 minutes
```

Claude runs the pipeline and shows you the result only when it passes:

```
output/2026-09-19-plan-a-week-of-content/
├── brief.md        the angle, three hooks, the one thing taught
├── voiceover.md    the script with beat markers, timing, on-screen text, delivery notes
├── resources.md    every claim and where it came from; the CTA keyword
├── captions.md     Instagram · TikTok · YouTube Shorts, paste-ready
└── EVALUATION.md   the three gate reports and the final SHIP verdict
```

Read `voiceover.md` out loud once. If a line does not sound like you, say so:
"line 3 isn't how I talk" is enough. Claude rewrites and re-runs the gates.

## 4. Optional: render a bed

```
/content-studio:video output/2026-09-19-plan-a-week-of-content
```

A 45-second motion-graphics background in your brand colours, one scene per beat,
lands in the folder as `bed.mp4`. Record your face over it, or post the 9:16 version.

## 5. Record and post

Record to the script. Paste the caption for the platform you are posting to. If your
CTA is a comment keyword, make sure the thing you promised exists before you post.

## Other commands

| Command | What it does |
|---|---|
| `/content-studio:idea <topic or "this week">` | three content briefs to choose from, no script yet |
| `/content-studio:captions <output folder>` | re-generate captions for an existing reel |
| `/content-studio:carousel <topic>` | a slide-by-slide carousel plan with exact copy |
| `/content-studio:check <output folder>` | re-run the three gates on something you edited by hand |

## If something feels off

- **Nothing happens when you type `/content-studio:`.** The plugin did not load — restart
  Claude Code, and check `/plugin` lists `content-studio` as enabled.
- **It says the brand is not set up, in a folder that is.** You are in a different folder
  than the one you ran `/content-studio:setup` in. The profile lives with your content, not
  with the plugin.
- **Scripts run long when you record them.** Your pace in `BRAND.md` is wrong. Re-time
  yourself and update the `pace_wpm` field; every budget recalculates from it.
- **It keeps writing hooks you would not say.** Add two or three of your own posts you
  liked to the `references` section of `BRAND.md`. The idea agent studies them.
- **It used a fact you did not give it.** Run `/content-studio:check`. Every number must
  appear in `resources.md` with a source, or it is removed.
- **`/content-studio:video` says it cannot render.** Run `/content-studio:install`.
