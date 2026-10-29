#!/usr/bin/env bash
# Regenerates the downloadable CV from index.html using headless Chrome
# (uses the @media print styles in assets/css/site.css).
# Run from Git Bash after any change to the resume: ./scripts/build-cv-pdf.sh
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
out="$root/assets/Cristian-Simioni-Milani-CV.pdf"

chrome="${CHROME:-/c/Program Files/Google/Chrome/Application/chrome.exe}"
[ -f "$chrome" ] || chrome="/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"

page="file:///$(cygpath -m "$root/index.html" 2>/dev/null || echo "$root/index.html")"
pdf="$(cygpath -w "$out" 2>/dev/null || echo "$out")"

"$chrome" --headless=new --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=10000 --print-to-pdf="$pdf" "$page"

echo "Written: $out"
