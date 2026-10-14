#!/usr/bin/env bash
# Renders vertical, bold, transparent-background PNGs. Requires rsvg-convert and Pillow.
set -euo pipefail
cd "$(dirname "$0")/.."  # repo root, so PNGs are written next to index.html
gen() { # file text color
  tmp=$(mktemp).svg
  cat > "$tmp" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" width="800" height="800" viewBox="0 0 800 800">
<text transform="translate(400 400) rotate(-90)" text-anchor="middle" dominant-baseline="central"
 font-family="Helvetica, Arial, sans-serif" font-size="64" font-weight="bold" fill="$3">$2</text></svg>
SVG
  rsvg-convert -w 1600 -h 1600 "$tmp" -o "$1"
  python3 - "$1" <<'PY'
import sys
from PIL import Image
p = sys.argv[1]; im = Image.open(p).convert("RGBA")
bb = im.getchannel("A").getbbox(); pad = 12
im.crop((bb[0]-pad, bb[1]-pad, bb[2]+pad, bb[3]+pad)).save(p)
PY
  rm -f "$tmp"
}
gen overview.png "Overview" "#AAAAAA"
gen elastic-stack.png "Elastic Stack" "#0077CC"
gen azure-resource.png "Azure Resource" "#00BFB3"
