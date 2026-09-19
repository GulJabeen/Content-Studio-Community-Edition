# BRAND.md — the profile every agent reads first

status: not set up

> Written by `/setup` (agents/00-onboarding-agent.md). Edit by hand any time; the agents
> read this file at the start of every job. Fields marked **required** must be filled
> before any content is produced.

## 1. What you offer  (required)

product: ""
# One or two sentences. A product, a service, a course, or just the subject you teach.
# Example: "A 6-week sourdough course for home bakers, plus a Saturday market stall."

offer_type: ""   # product | service | course | community | none-yet (just building an audience)

## 2. Who it is for  (required)

audience: ""
# One real person, not a demographic. What they are trying to do, what keeps going wrong.
# Example: "A home baker who has made five flat loaves and is about to give up."

audience_level: ""   # beginner | intermediate | expert | mixed

## 3. Your brand  (required)

brand_name: ""
handles:
  instagram: ""
  tiktok: ""
  youtube: ""
  linkedin: ""
platforms_in_order: []   # where you post most first, e.g. [instagram, tiktok, youtube]

## 4. What you teach  (required)

pillars:
  - ""   # three subjects you could teach for a year without running dry
  - ""
  - ""

viewer_takeaway: ""
# Finish this sentence: "After a month of watching me, someone can ___."

## 5. What you can honestly claim  (required)

proof:
  - ""   # years doing it, results you can show, what you have personally tested, who you have taught
  - ""
  - ""

intro_line: ""
# One sentence you say in every reel, after the hook. Written with you during setup.
# Keep it under 20 words; it costs about 8 seconds of every reel.
# Example: "I'm Sana — six years running a bakery, and I've taught 400 people to get an open crumb."

## 6. What you never say  (required)

no_go:
  - ""   # employer, clients, confidential work, topics you are not qualified for, anything legal
  - ""
# Everything here is a hard gate. The evaluator fails any piece that touches it.

## 7. Voice  (required)

voice_words: ["", "", ""]        # three words for how you sound: e.g. warm, blunt, practical
never_say: ["", "", ""]          # words or phrases that are not you: e.g. "guys", "game-changer"
languages: ["English"]           # if you mix languages, say where: captions only, or the read too
humour: ""                       # none | dry | playful

## 8. Pace  (required)

pace_wpm: 0
# Read a 100-word paragraph aloud at your normal speaking speed and time it.
# 100 words in 45 seconds = 133 wpm. Do not guess; scripts are budgeted from this number.

target_length_seconds: 45        # finished reel length to aim for; 30–60 is the usable range

## 9. The ask  (required)

cta_style: ""                    # comment-keyword | link-in-bio | follow | dm-me | buy
cta_deliverable: ""              # what the viewer gets: a checklist, a template, a guide, a reply
# With comment-keyword, each reel gets its own keyword, logged in brand/keywords.md.

## 10. References  (optional but strongly recommended)

references:
  - url: ""
    why: ""   # what you liked: the hook, the pace, the honesty, the structure
  - url: ""
    why: ""

## Derived budgets (the studio fills these from pace_wpm and target_length_seconds)

budget:
  total_words: 0          # pace_wpm × target_length_seconds ÷ 60
  intro_words: 0          # word count of intro_line
  teach_words: 0          # total − intro − ~12 for the hook − ~10 for the CTA
  drop_intro_under_seconds: 30
