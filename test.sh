#!/usr/bin/env bash
# test.sh — prove the viewer's path works BEFORE you hit record.
#
# Runs in a throwaway CLAUDE_CONFIG_DIR and a throwaway folder, so it tests what a
# stranger gets from GitHub — never your local working copy, and it cannot touch
# your real ~/.claude settings.
#
#   ./test.sh          full run
#   ./test.sh --quick  skip the npm/Remotion install (much faster)
set -uo pipefail

REPO="GulJabeen/Content-Studio-Community-Edition"
URL="https://github.com/${REPO}.git"
QUICK=0; [ "${1:-}" = "--quick" ] && QUICK=1

PASS=0; FAIL=0
ok()   { printf "  \033[32m✔\033[0m %s\n" "$1"; PASS=$((PASS+1)); }
bad()  { printf "  \033[31mX\033[0m %s\n" "$1"; FAIL=$((FAIL+1)); }
head_() { printf "\n\033[1m%s\033[0m\n" "$1"; }

TMP=$(mktemp -d)
export CLAUDE_CONFIG_DIR="$TMP/config"
mkdir -p "$CLAUDE_CONFIG_DIR"
trap 'rm -rf "$TMP"' EXIT

head_ "0 · Prerequisites a viewer needs"
command -v claude >/dev/null && ok "claude on PATH ($(claude --version 2>/dev/null | head -1))" || bad "claude not found"
command -v node   >/dev/null && {
  NV=$(node --version); NMAJ=${NV#v}; NMAJ=${NMAJ%%.*}
  [ "$NMAJ" -ge 18 ] && ok "node $NV (>= 18)" || bad "node $NV is below 18"
} || bad "node not found"
command -v git >/dev/null && ok "git present" || bad "git not found"

head_ "1 · The repo is reachable by a stranger"
gh repo view "$REPO" --json visibility --jq .visibility 2>/dev/null | grep -q PUBLIC \
  && ok "repo is PUBLIC" || bad "repo is not public (or gh cannot see it)"
git clone -q --depth 1 "$URL" "$TMP/clone" 2>/dev/null \
  && ok "anonymous HTTPS clone succeeds" || bad "clone failed — the first command in the video dies here"

head_ "2 · The package has what the video promises"
C="$TMP/clone"
[ -f "$C/.claude-plugin/marketplace.json" ] && ok "marketplace.json present" || bad "marketplace.json MISSING"
MP=$(python3 -c "import json;print(json.load(open('$C/.claude-plugin/marketplace.json'))['name'])" 2>/dev/null)
[ "$MP" = "techwithgul" ] && ok "marketplace registers as 'techwithgul'" || bad "marketplace name is '$MP', so 'content-studio@techwithgul' will fail"
NA=$(ls "$C"/agents/*.md 2>/dev/null | wc -l | tr -d ' ')
[ "$NA" -ge 12 ] && ok "$NA agents shipped" || bad "only $NA agents"
NC=$(ls "$C"/commands/*.md 2>/dev/null | wc -l | tr -d ' ')
[ "$NC" -eq 11 ] && ok "11 commands (the dropdown shot)" || bad "$NC commands — the video says eleven"
for c in setup install idea reel video combine assets learn captions carousel check; do
  [ -f "$C/commands/$c.md" ] || bad "command /$c missing"
done
[ -f "$C/install.sh" ] && ok "install.sh present" || bad "install.sh MISSING"
[ -f "$C/scripts/combine.sh" ] && ok "combine.sh present (step 6)" || bad "combine.sh MISSING"
bash -n "$C/scripts/combine.sh" 2>/dev/null && ok "combine.sh parses" || bad "combine.sh has a syntax error"
grep -q 'id="ReelFinal"' "$C/video/src/Root.tsx" 2>/dev/null && ok "ReelFinal composition registered" || bad "ReelFinal not registered"
[ -f "$C/agents/10-asset-agent.md" ] && ok "asset agent shipped" || bad "asset agent MISSING"
grep -q 'Official source first' "$C/agents/10-asset-agent.md" 2>/dev/null && ok "asset agent keeps the rights rules" || bad "asset agent lost its rights rules"
[ -f "$C/agents/11-learn-agent.md" ] && ok "learn agent shipped" || bad "learn agent MISSING"
grep -q 'learned:' "$C/templates/brand/BRAND.md" 2>/dev/null && ok "brand template has the learned: section" || bad "brand template missing learned:"
WIRED=$(grep -l 'learned.recurring_fixes' "$C"/agents/0*.md 2>/dev/null | wc -l | tr -d " ")
[ "$WIRED" -ge 4 ] && ok "$WIRED drafting agents read learned: (the loop closes)" || bad "only $WIRED agents read learned: — the loop is cosmetic"

head_ "3 · Nothing private leaked into the public repo"
if grep -rqiE 'sk-ant-|gho_[A-Za-z0-9]{20}|xoxb-|AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH) PRIVATE' "$C" --exclude-dir=.git --exclude=test.sh --exclude=ship.sh 2>/dev/null
then bad "a credential-shaped string is in the PUBLIC repo"; else ok "no credentials in the public repo"; fi
if grep -rqi 'hyly' "$C" --exclude-dir=.git --exclude=test.sh --exclude=ship.sh 2>/dev/null
then bad "employer name found in the public repo"; else ok "no employer references"; fi
if [ -d "$C/brand" ] && [ -f "$C/brand/BRAND.md" ]
then bad "a filled brand/BRAND.md shipped — that is YOUR profile"; else ok "no personal brand profile shipped"; fi
[ -d "$C/video/node_modules" ] && bad "node_modules was committed (repo bloat)" || ok "node_modules not committed"

head_ "4 · The two commands from the video, in a clean config"
if claude plugin marketplace add "$REPO" >"$TMP/mk.log" 2>&1
then ok "/plugin marketplace add $REPO"
else bad "marketplace add FAILED:"; sed 's/^/      /' "$TMP/mk.log" | head -4; fi
# a real SSH clone shows git@github.com; "SSH not configured, cloning via HTTPS" is the GOOD line
if grep -q 'git@github.com' "$TMP/mk.log"; then
  bad "it cloned over SSH — viewers without keys will fail"
elif grep -qi 'cloning via HTTPS\|https://github.com' "$TMP/mk.log"; then
  ok "cloned over HTTPS — works with no SSH keys (auto-fallback confirmed)"
else
  bad "could not tell which transport was used"
fi
if claude plugin install content-studio@techwithgul --scope user -y >"$TMP/pi.log" 2>&1
then ok "/plugin install content-studio@techwithgul"
else bad "plugin install FAILED:"; sed 's/^/      /' "$TMP/pi.log" | head -4; fi
claude plugin list 2>/dev/null | grep -q 'content-studio@techwithgul' \
  && ok "plugin shows as installed + enabled" || bad "plugin not listed after install"

head_ "5 · The engine install (step 2 of the video)"
if [ "$QUICK" = 1 ]; then
  printf "  \033[33m–\033[0m skipped (--quick)\n"
  bash "$C/install.sh" --dry-run >"$TMP/dry.log" 2>&1 \
    && ok "install.sh --dry-run runs (your on-camera shot)" || bad "install.sh --dry-run failed"
else
  bash "$C/install.sh" --dry-run >"$TMP/dry.log" 2>&1 \
    && ok "install.sh --dry-run runs (your on-camera shot)" || bad "install.sh --dry-run failed"
  grep -qc 'would run' "$TMP/dry.log" && ok "dry-run prints the plan ($(grep -c 'would run' "$TMP/dry.log") actions)" || bad "dry-run printed nothing"
  ( cd "$C/video" && npm install --no-audit --no-fund >"$TMP/npm.log" 2>&1 ) \
    && ok "npm install in video/ succeeds (Remotion can render)" \
    || bad "npm install FAILED — /content-studio:video will not work. Tail: $(tail -2 "$TMP/npm.log" | tr '\n' ' ')"
  if ( cd "$C/video" && npx --no-install remotion compositions src/index.ts 2>/dev/null | grep -q ReelFinal ); then
    ok "Remotion lists ReelFinal (step 6 will render)"
  else bad "Remotion cannot see ReelFinal"; fi
  if ( cd "$C/video" && npx --no-install remotion render src/index.ts ReelBed "$TMP/bed.mp4" --frames=0-14 --log=error >/dev/null 2>&1 ); then
    ok "a real bed renders (step 5 works)"
    ( cd "$C" && ./scripts/combine.sh "$TMP" "$TMP/bed.mp4" >"$TMP/comb.log" 2>&1 ) \
      && [ -f "$TMP/reel-final.mp4" ] && ok "combine produces reel-final.mp4 (step 6 works)" \
      || bad "combine FAILED: $(tail -2 "$TMP/comb.log" | tr '\n' ' ')"
  else bad "bed render failed — step 5 will not work on camera"; fi
fi

head_ "RESULT"
if [ "$FAIL" -eq 0 ]; then
  printf "  \033[32m%s checks passed. The viewer's path works — safe to record.\033[0m\n\n" "$PASS"
  exit 0
else
  printf "  \033[31m%s passed, %s FAILED. Do not record until these are fixed.\033[0m\n\n" "$PASS" "$FAIL"
  exit 1
fi
