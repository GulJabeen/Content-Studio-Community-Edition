#!/usr/bin/env bash
# combine.sh — face cam + motion bed -> the finished 9:16 reel.
#
#   scripts/combine.sh <reel-output-folder> <facecam-file> [facecam-height]
#
# Expects <reel-output-folder>/bed.mp4 (from /content-studio:video).
# Writes  <reel-output-folder>/reel-final.mp4
#
# Uses Remotion's bundled ffprobe — there is no system ffmpeg requirement.
set -euo pipefail

FOLDER="${1:?usage: combine.sh <reel-output-folder> <facecam-file> [facecam-height]}"
CAM="${2:?usage: combine.sh <reel-output-folder> <facecam-file> [facecam-height]}"
CAMH="${3:-840}"

HERE="$(cd "$(dirname "$0")/.." && pwd)"
VIDEO="$HERE/video"
BED="$FOLDER/bed.mp4"

[ -f "$CAM" ] || { echo "✋ face cam not found: $CAM"; exit 1; }
[ -f "$BED" ] || { echo "✋ no bed.mp4 in $FOLDER — run /content-studio:video first."; exit 1; }
[ -d "$VIDEO/node_modules" ] || { echo "✋ run /content-studio:install first."; exit 1; }

mkdir -p "$VIDEO/public"
cp "$CAM" "$VIDEO/public/facecam.mp4"
cp "$BED" "$VIDEO/public/bed.mp4"

# duration + fps come from the FACE CAM: the performance is the master, the bed follows.
cd "$VIDEO"
PROBE=$(npx --no-install remotion ffprobe public/facecam.mp4 2>&1 || true)
DUR=$(printf '%s' "$PROBE" | sed -n 's/.*Duration: \([0-9][0-9]\):\([0-9][0-9]\):\([0-9.]*\).*/\1 \2 \3/p' | head -1 \
      | awk '{printf "%.3f", $1*3600 + $2*60 + $3}')
FPS=$(printf '%s' "$PROBE" | sed -n 's/.*, \([0-9.]*\) fps.*/\1/p' | head -1 | awk '{printf "%d", ($1<1?30:$1)}')
[ -n "${DUR:-}" ] || { echo "✋ could not read the face cam duration."; exit 1; }
[ "${FPS:-0}" -gt 0 ] 2>/dev/null || FPS=30

python3 - "$DUR" "$FPS" "$CAMH" <<'PY'
import json,sys
dur,fps,camh = float(sys.argv[1]), int(sys.argv[2]), int(sys.argv[3])
p="src/final.json"
d=json.load(open(p))
d.update(facecam="facecam.mp4", bed="bed.mp4", fps=fps,
         durationInSeconds=round(dur,3), facecamHeight=camh)
json.dump(d, open(p,"w"), indent=2); open(p,"a").write("\n")
print(f"  face cam: {dur:.2f}s @ {fps}fps · face cam height {camh}px")
PY

echo "  rendering ReelFinal (1080x1920)…"
npx --no-install remotion render src/index.ts ReelFinal "$FOLDER/reel-final.mp4" --log=error

echo "✔ $FOLDER/reel-final.mp4"
