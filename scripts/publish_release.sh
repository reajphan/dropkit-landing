#!/usr/bin/env bash
# Publish DropKit v0.1.0 release on GitHub via `gh` CLI.
# Run once you've done `gh auth login` (interactive browser flow).
#
# Usage:  ./scripts/publish_release.sh [path-to-dmg]
#   defaults to ../dj-engine/DropKit-v0.1.0-arm64.dmg

set -euo pipefail

DMG="${1:-$HOME/.openclaw/workspace/projects/dj-engine/DropKit-v0.1.0-arm64.dmg}"
TAG="v0.1.0"

if [ ! -f "${DMG}" ]; then
  echo "ERROR: dmg not found at ${DMG}"
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: gh CLI not installed.  Run: brew install gh"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "ERROR: not logged into gh.  Run: gh auth login"
  exit 1
fi

cd "$(dirname "$0")/.."

# Tag this commit locally (idempotent)
if ! git rev-parse "${TAG}" >/dev/null 2>&1; then
  git tag -a "${TAG}" -m "DropKit v0.1.0 — first public unsigned beta"
  git push origin "${TAG}"
fi

# Create the release + upload .dmg.  Overwrites existing assets on the tag.
gh release create "${TAG}" "${DMG}" \
  --title "DropKit v0.1.0 — first unsigned beta" \
  --notes "$(cat <<'EOF'
First public prototype build of DropKit.

**System requirements**
- macOS 12+
- Apple Silicon (arm64) — Intel build coming later

**Install**
1. Open the `.dmg` and drag DropKit into Applications.
2. In Applications, right-click DropKit → Open.
3. Click Open on the "unidentified developer" warning.
4. Future launches work normally.

**Why is it unsigned?** Apple Developer enrollment is currently stuck in ID verification. The next release will be signed and notarized.

**Known v0 caveats**
- Apple Silicon only.
- ~386 MB download (PyInstaller + scipy/librosa/essentia).
- Engine is still tuning; mixes may drift on some tracks.

This is a prototype. Please send bug reports + screenshots to hello@dropkits.app.
EOF
)" \
  --latest \
  || gh release upload "${TAG}" "${DMG}" --clobber

echo
echo "==> Release published:"
gh release view "${TAG}" --json url -q .url
