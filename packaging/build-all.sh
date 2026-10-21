#!/usr/bin/env bash
# Build both release packages into dist/.
set -euo pipefail

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)

"$ROOT/packaging/build-rpm.sh"
"$ROOT/packaging/build-deb.sh"

(
  cd "$ROOT/dist"
  sha256sum ./*.rpm ./*.deb | sed 's|^\([^ ]*\)  \./|\1  |' > SHA256SUMS
)

echo
echo "Packages:"
ls -lh "$ROOT/dist"/*.rpm "$ROOT/dist"/*.deb
echo
cat "$ROOT/dist/SHA256SUMS"
