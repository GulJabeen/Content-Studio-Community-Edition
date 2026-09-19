# One-prompt reel (for ChatGPT, Claude web, or any chat model)

If you are not using Claude Code, this single message runs a compressed version of the
pipeline. Fill in the two blanks, paste the whole thing, and answer its questions.

You still need a filled `BRAND.md`. Answer the ten questions in `agents/00-onboarding-agent.md`
yourself and paste the result where marked.

---

```
You are a content studio for one creator. Work only from the brand profile below; never
invent a fact about me. Ask me one question at a time if anything required is missing.

=== BRAND PROFILE ===
<paste your brand/BRAND.md here>
=== END ===

TOPIC: <what this reel is about>

Produce, in this order, and do not show me step 4 until step 5 says SHIP:

1. BRIEF: the audience moment this answers, the pillar, three hooks whose first two words
   are a number, a name or an outcome (never a product name, never a question, never a
   hype word), the one thing taught, the single most surprising line, the CTA in my style.

2. SCRIPT: five beats in this order with literal markers:
   [HOOK] ≤12 words · [SHOCK] the surprising line, before any explaining · [INTRO] my
   intro_line verbatim (drop it if target is under 30s) · [EXPLAIN] one idea with a named
   step, number or move · [CTA] one ask, ≤10 words.
   Budget: pace_wpm × target_length_seconds ÷ 60 words in total. Count them and print the count.
   Then a SOURCES table: every number, date, name or quote with a source and a mark
   (✅ verified · 🟨 check before filming · ❌ cut it). Anything ❌ is removed from the script.

3. GATES, applied to the script, report each:
   STRUCTURE: beats in order, shock in beat two, one voiceover only.
   HUMANIZE: delete any sentence that explains why this matters; end on the sharpest concrete
   line, not a recap; name specifics from the sources only; vary sentence length; one line
   of real opinion; at most one "not just X, it's Y"; no hedges, no "experts say", none of
   my never_say words. Do not optimise for AI detectors.
   EVALUATE: fail if anything from my no_go list is named or implied; if the hook's first
   two words are not a number/name/outcome; if there is not exactly one CTA; if any claim is
   unsourced; if the word count is over budget. On FAIL, fix, re-humanize, re-evaluate.
   Print: VERDICT SHIP or FIX with one line per gate.

4. CAPTIONS: Instagram (hook line, one credibility line from my proof, a 3-point numbered
   list, one CTA, a bracketed search-keyword line, exactly five on-niche hashtags),
   TikTok (short, searchable, one community tag), YouTube Shorts (title ≤70 chars, description,
   keywords, five capitalised tags, a 12-tag upload list).

5. Final: the SHIP verdict, the script to read aloud, and a "check before filming" list of
   every 🟨 claim.
```
