#!/usr/bin/env bash

set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if rg -n -P \
  'github\.com/sneat-co/(sportius|ext-(?!sportius)[a-z0-9-]+)|@sneat/extension-(?!sportius)[a-z0-9-]+' \
  "$root_dir/backend/go.mod" \
  "$root_dir/frontend/libs/extensions/sportius/contract/package.json"; then
  echo "Sportius contracts must not depend on the implementation or another extension." >&2
  exit 1
fi

node "$root_dir/scripts/check-catalog-parity.mjs"
