#!/usr/bin/env bash
# Content Studio — companion installer
#
# Installs the Claude Code plugin set the studio was built with, and the Remotion video
# bed's Node dependencies. Safe to run twice. Normally you never call this directly —
# run /content-studio:install inside Claude Code and it runs this for you.
#
#   install.sh            everything
#   install.sh --minimal  only the superpowers plugin + Remotion
#   install.sh --no-video skip Remotion
#   install.sh --dry-run  print what would run, run nothing
#
# None of the companion plugins are required for /content-studio:reel to work.
#
set -u
cd "$(dirname "$0")"

MINIMAL=0; VIDEO=1; DRY=0
for a in "$@"; do
  case "$a" in
    --minimal) MINIMAL=1 ;;
    --no-video) VIDEO=0 ;;
    --dry-run) DRY=1 ;;
    -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
  esac
done

ok()   { printf '  \033[32m✔\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }
fail() { printf '  \033[31m✘\033[0m %s\n' "$*"; }

echo "Content Studio — companion install"
echo

# ── 1. Claude Code ────────────────────────────────────────────────────────────
if command -v claude >/dev/null 2>&1; then
  ok "Claude Code $(claude --version 2>/dev/null | head -1)"
else
  fail "Claude Code is not installed."
  echo "    Install it, then re-run this script:"
  echo "      npm install -g @anthropic-ai/claude-code"
  echo "    or: curl -fsSL https://claude.ai/install.sh | bash"
  exit 1
fi

# ── 2. Node ───────────────────────────────────────────────────────────────────
if command -v node >/dev/null 2>&1; then
  NODE_MAJOR=$(node -p 'process.versions.node.split(".")[0]')
  if [ "$NODE_MAJOR" -ge 18 ]; then ok "Node $(node --version)"; else warn "Node $(node --version) is older than 18; Remotion needs 18+"; fi
else
  warn "Node is not installed; the video bed will be skipped (https://nodejs.org)"; VIDEO=0
fi

# ── 3. Plugin marketplaces ────────────────────────────────────────────────────
# name|source — the same set the studio's author runs. A marketplace that is already
# added prints a warning from the CLI; that is fine.
MARKETPLACES="superpowers-marketplace|obra/superpowers-marketplace
claude-code-plugins|https://github.com/anthropics/claude-code.git
taches-cc-resources|glittercowboy/taches-cc-resources
thedotmack|thedotmack/claude-mem
yrzhe-skills|https://github.com/Yrzhe/claude-skills.git"

echo; echo "Marketplaces"
while IFS='|' read -r name src; do
  [ -z "$name" ] && continue
  if [ "$MINIMAL" = 1 ] && [ "$name" != "superpowers-marketplace" ]; then continue; fi
  if [ "$DRY" = 1 ]; then echo "  would run: claude plugin marketplace add $src"; continue; fi
  if claude plugin marketplace add "$src" >/dev/null 2>&1; then ok "$name"; else ok "$name (already added)"; fi
done <<< "$MARKETPLACES"

# ── 4. Plugins ────────────────────────────────────────────────────────────────
# id|one line on what it does
PLUGINS="superpowers@superpowers-marketplace|brainstorm → plan → execute workflows, code review, verification
frontend-design@claude-code-plugins|distinctive UI when you build a landing page or a viewer
taches-cc-resources@taches-cc-resources|thinking frameworks, planning, prompt and skill builders
claude-mem@thedotmack|persistent memory across sessions (what you decided, why)
ralph-wiggum@claude-code-plugins|run a task in a loop until it is done
intelligent-web-scraper@yrzhe-skills|research pages and article series without configuration
youtube-data-api@yrzhe-skills|YouTube research (needs your own API key)"

echo; echo "Plugins"
while IFS='|' read -r id what; do
  [ -z "$id" ] && continue
  if [ "$MINIMAL" = 1 ] && [ "$id" != "superpowers@superpowers-marketplace" ]; then continue; fi
  if [ "$DRY" = 1 ]; then echo "  would run: claude plugin install $id --scope user -y   # $what"; continue; fi
  if claude plugin install "$id" --scope user -y >/dev/null 2>&1; then ok "$id — $what"; else ok "$id (already installed) — $what"; fi
done <<< "$PLUGINS"

# ── 5. Remotion video bed ─────────────────────────────────────────────────────
if [ "$VIDEO" = 1 ]; then
  echo; echo "Video bed (Remotion)"
  if [ "$DRY" = 1 ]; then echo "  would run: (cd video && npm install)"; elif (cd video && npm install --no-audit --no-fund >/dev/null 2>&1); then ok "video/node_modules ready"; else fail "npm install failed in video/ — run it by hand to see why"; fi
fi

# ── 6. Done ───────────────────────────────────────────────────────────────────
echo
echo "Done. Next, in the folder you want your content to live in:"
echo "  /content-studio:setup        # the ten-question interview writes brand/BRAND.md"
echo "  /content-studio:reel <topic> # your first reel"
echo
echo "Restart Claude Code so the new plugins load."
