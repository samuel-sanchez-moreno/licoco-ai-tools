#!/usr/bin/env bash
# marketplace-update.sh — Update all installed LiCoCo AI tools to their latest versions.
#
# Usage:
#   ./scripts/marketplace-update.sh [--type <type>]
#
# Options:
#   --type  Only update tools of this type: skill, agent, plugin, workflow
#
# Examples:
#   ./scripts/marketplace-update.sh
#   ./scripts/marketplace-update.sh --type skill

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REGISTRY="${REPO_ROOT}/marketplace/registry.yaml"
INSTALL_SCRIPT="${REPO_ROOT}/scripts/install.sh"

usage() {
  grep '^#' "$0" | sed 's/^# \{0,1\}//' | tail -n +2
  exit 1
}

log() { echo "[marketplace-update] $*"; }
err() { echo "[marketplace-update] ERROR: $*" >&2; exit 1; }

TYPE_FILTER=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --type) TYPE_FILTER="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) err "Unknown argument: $1" ;;
  esac
done

[[ -f "$REGISTRY" ]] || err "Registry not found at ${REGISTRY}."
[[ -x "$INSTALL_SCRIPT" ]] || chmod +x "$INSTALL_SCRIPT"

# Pull latest changes first
log "Pulling latest changes from origin..."
git -C "${REPO_ROOT}" pull --ff-only origin main 2>/dev/null || \
  log "Warning: could not pull from origin — using local version."

# Extract tool names and types from registry
TOOLS=$(python3 - <<PYEOF
import re

with open("${REGISTRY}") as f:
    content = f.read()

entries = re.split(r'\n(?=- name:)', content.strip())
for entry in entries:
    if not entry.strip() or entry.strip().startswith('#'):
        continue
    name_m = re.search(r'name:\s*(\S+)', entry)
    type_m = re.search(r'type:\s*(\S+)', entry)
    if name_m and type_m:
        type_filter = "${TYPE_FILTER}"
        if type_filter and type_m.group(1) != type_filter:
            continue
        print(f"{type_m.group(1)} {name_m.group(1)}")
PYEOF
)

if [[ -z "$TOOLS" ]]; then
  log "No tools found in registry."
  exit 0
fi

UPDATED=0
FAILED=0

while IFS=" " read -r type name; do
  log "Updating ${type} '${name}'..."
  if "${INSTALL_SCRIPT}" "${type}" "${name}"; then
    UPDATED=$((UPDATED + 1))
  else
    log "Warning: failed to update ${type} '${name}'"
    FAILED=$((FAILED + 1))
  fi
done <<< "$TOOLS"

log ""
log "✅  Update complete: ${UPDATED} updated, ${FAILED} failed."
