#!/usr/bin/env bash
# ship.sh — commit, push, and refresh the installed plugin in one step.
#
# Since the `techwithgul` marketplace now fetches from GitHub (not this folder),
# edits here are NOT live until they are pushed AND the marketplace is updated.
#
#   ./ship.sh "what changed"      commit everything, push, refresh
#   ./ship.sh                     same, with a generic message
set -euo pipefail
cd "$(dirname "$0")"

MSG="${1:-Update content-studio}"

# refuse to publish secrets
if git diff --cached --quiet && [ -z "$(git status --porcelain)" ]; then
  echo "Nothing to commit."
else
  git add -A
  # scan only ADDED lines, and skip this script (it contains the patterns itself)
  if git diff --cached -- . ':(exclude)ship.sh' ':(exclude)test.sh' | grep '^+' \
     | grep -qiE 'sk-ant-|gho_[A-Za-z0-9]{20}|xoxb-|AKIA[0-9A-Z]{16}|BEGIN (RSA|OPENSSH) PRIVATE'; then
    echo "✋ Refusing to commit: a credential-shaped string is in the staged diff."
    echo "   Run: git diff --cached | grep -inE 'sk-ant-|gho_|xoxb-|AKIA|PRIVATE KEY'"
    git reset -q; exit 1
  fi
  git commit -qm "$MSG"
  echo "✔ committed: $MSG"
fi

git push -q
echo "✔ pushed to $(git remote get-url origin)"

claude plugin marketplace update techwithgul
echo "✔ marketplace refreshed — restart Claude Code so the new version loads."
