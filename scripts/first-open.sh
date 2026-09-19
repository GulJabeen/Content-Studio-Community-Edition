#!/usr/bin/env bash
# SessionStart hook for the content-studio plugin.
#
# Runs in whatever folder the creator opened, in every session. It is deliberately SILENT
# unless this folder is a studio folder — i.e. ./brand/BRAND.md exists. A plugin installed
# user-wide must not talk in projects that have nothing to do with it.
#
#   $1 = plugin root (passed by hooks.json as ${CLAUDE_PLUGIN_ROOT})
PLUGIN_ROOT="${1:-}"

[ -f brand/BRAND.md ] || exit 0

if grep -q '^status: not set up' brand/BRAND.md; then
  cat <<MSG
[Content Studio] brand/BRAND.md exists but is NOT set up. Before doing anything else this
session, greet the creator in one line and start the onboarding interview from
${PLUGIN_ROOT}/agents/00-onboarding-agent.md: one question at a time, wait for each
answer. Do not produce any content until the profile is written and confirmed.
MSG
else
  status=$(grep -m1 '^status:' brand/BRAND.md | sed 's/^status: *//')
  name=$(grep -m1 '^brand_name:' brand/BRAND.md | sed 's/^brand_name: *//')
  echo "[Content Studio] Brand profile ready: ${name:-unnamed} (${status}). Commands: /content-studio:reel <topic> · :idea · :captions · :carousel · :check · :video."
fi

if [ -n "$PLUGIN_ROOT" ] && [ ! -d "$PLUGIN_ROOT/video/node_modules" ]; then
  echo "[Content Studio] The Remotion bed has no node_modules; /content-studio:install has not been run. /content-studio:video will not render until it is."
fi
exit 0
