# CONTENT STANDARD — the rulebook the gates score against

Every reel, caption, carousel and cover is checked against this file before the creator
sees it. `./brand/BRAND.md` supplies the creator-specific facts (audience, voice, pace, the
no-go list); this file supplies the shape that holds attention regardless of niche.

The rules are ordered by how much they cost when broken.

---

## 0. The no-go list is absolute

Anything in `BRAND.md → no_go` fails the piece outright. No employer, client, confidential
project or excluded topic is named, implied, or used as authority. "At work we…" is a
disclosure even without a name. The creator's credibility comes from what *they*
personally did, tested and can show.

## 1. The hook: the two-word rule

**The first two words on screen, and the first line spoken, are a number, a name, or an
outcome.** Never a tool or product name. Never a rhetorical question. Never a hype word.

| Shape | Example | Why |
|---|---|---|
| Number + pain + outcome | "Five loaves flat? One fix." | a finite, specific promise |
| Outcome first, tool second | "A full week planned in 20 minutes" | the viewer's result, not your method |
| Contrarian reframe | "Your starter is fine. Your fridge isn't." | breaks an assumption they hold |
| Credibility interrupt | "Six years of baking taught me one thing about proofing" | who you are, spent on the hook |
| Curiosity with a real payoff | "The step every recipe skips" | only if line two pays it off |

Banned shapes: "Meet [tool]", "Introducing…", "[Tool] is amazing", "Have you ever wondered…",
"Will X replace me?", "incredible / mind-blowing / game-changer / you won't believe".

**Rewrite drill.** A weak hook gets five angles before anyone picks: curiosity, contrarian,
problem, outcome, story. Choose the one that puts a number, name or outcome first.

## 2. Structure: five beats, this order

```
HOOK (0–3s) → SHOCK or early CTA (3–8s) → INTRO (one line) → EXPLAIN (one idea) → CTA (one ask)
```

Grab them, spike the tension before you explain anything, say who you are only once the
viewer wants to know, then teach one thing well, then ask once. The most surprising line
in the script sits in beat two. Never open on setup or context. Full detail:
`${CLAUDE_PLUGIN_ROOT}/agents/03-reel-structure-agent.md`.

## 3. Length: short, and timed from your own pace

- Aim for the `target_length_seconds` in `BRAND.md` (default 45). Thirty to sixty is the
  usable range; past sixty, most viewers are gone.
- The word budget is derived from `pace_wpm`, never from a generic number. A script that
  "looks like 60 seconds" is often 90 in a real voice.
- **Short is not thin.** One specific, usable thing per reel: a named step, an actual
  number, where to click, what to say. Overflow teaching goes into the caption, never into
  a longer reel.
- **No runway.** No "hey everyone", no "today I want to talk about". The first line is the hook.
- Under 30 seconds, drop the intro line entirely.

## 4. Credibility: spend it once, near the top

The `intro_line` from `BRAND.md` appears verbatim as beat three, one breath, then move on.
It is not counted in the teaching budget. Do not paraphrase it: repetition is what makes
people remember who you are.

## 5. The ask: one, claimable, value given

Exactly one CTA per piece, and the value is already given in the content; the CTA is a
bonus, never the withheld payoff.

- `comment-keyword`: "Comment WORD and I'll send you the checklist." One keyword per reel,
  registered in `./brand/keywords.md`, deliverable exists before posting.
- `link-in-bio`, `follow`, `dm-me`, `buy`: one plain sentence, said once, at the end.

Never end on "what do you think?" with nothing to claim.

## 6. Captions and discovery

1. Hook line mirrors the on-screen hook.
2. The value, given: a short numbered list of what the reel taught.
3. One line of credibility, employer-safe and from `BRAND.md → proof`.
4. The one CTA.
5. A bracketed keyword line for search: `(sourdough proofing, open crumb, home baking…)`.
6. **Exactly five hashtags**, all on-niche: one broad, two category, one niche, one
   platform or trend tag. Never twenty. Off-niche tags bring viewers who never convert.

## 7. Accuracy

Every number, date, name and quote in a script traces to a row in that folder's
`resources.md` with a source and a confidence mark. Unsourced claims are cut, not softened.
Never round up. Never invent a specific to sound concrete. When a claim is common
knowledge but unverified, say so in `resources.md` and tell the creator to check before
filming.

## 8. Humanize before the gate

Every piece passes `${CLAUDE_PLUGIN_ROOT}/agents/04-humanize-agent.md` after drafting and before evaluation.
The durable tell of machine writing is structure, not vocabulary: the over-explained
moral, the straight line to a tidy ending, the vague "experts say", no opinion. Fix those
first; swap words last. AI-detector scores are never a gate; they falsely flag non-native
English writers.

## 9. Pre-publish scorecard

- [ ] No-go list clean (nothing named, implied or used as authority)
- [ ] Hook: first two words are a number, name or outcome; no tool name, no question
- [ ] First line has no runway
- [ ] Beat order HOOK → SHOCK/CTA → INTRO → EXPLAIN → CTA; the shock is in beat two
- [ ] Intro line verbatim from `BRAND.md`, or dropped because the reel is under 30s
- [ ] One specific, usable thing taught
- [ ] Word count inside the derived budget
- [ ] Exactly one claimable CTA; keyword registered; deliverable exists
- [ ] Exactly five on-niche hashtags in every caption
- [ ] Every claim in `resources.md` with a source
- [ ] Humanized: no moral line, no tidy bow, specifics named, one opinion present
- [ ] Sounds like the creator (`voice_words`, nothing from `never_say`)

Enforced by `${CLAUDE_PLUGIN_ROOT}/agents/05-evaluator-agent.md`, which returns SHIP or FIX and loops until SHIP.
