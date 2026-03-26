#!/usr/bin/env bash
# install.sh — Install a LiCoCo AI tool from the marketplace registry.
#
# Usage:
#   ./scripts/install.sh <type> <name> [--version <version>]
#
# Arguments:
#   type     One of: skill, agent, plugin, workflow
#   name     Tool name as listed in marketplace/registry.yaml
#   --version  (Optional) Specific version to install (default: latest)
#
# Examples:
#   ./scripts/install.sh skill summarise-email
#   ./scripts/install.sh plugin jira-ai-assistant --version 1.2.0

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REGISTRY="${REPO_ROOT}/marketplace/registry.yaml"

# --------------------------------------------------------------------------- #
# Helpers
# --------------------------------------------------------------------------- #

usage() {
  grep '^#' "$0" | sed 's/^# \{0,1\}//' | tail -n +2
  exit 1
}

log()  { echo "[install] $*"; }
err()  { echo "[install] ERROR: $*" >&2; exit 1; }

require_cmd() {
  command -v "$1" &>/dev/null || err "Required command '$1' not found. Please install it first."
}

# --------------------------------------------------------------------------- #
# Parse arguments
# --------------------------------------------------------------------------- #

[[ $# -lt 2 ]] && usage

TYPE="$1"
NAME="$2"
VERSION="latest"
shift 2

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version) VERSION="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) err "Unknown argument: $1" ;;
  esac
done

# Validate type
case "$TYPE" in
  skill|agent|plugin|workflow) ;;
  *) err "Invalid type '$TYPE'. Must be one of: skill, agent, plugin, workflow." ;;
esac

# --------------------------------------------------------------------------- #
# Resolve tool path from registry
# --------------------------------------------------------------------------- #

require_cmd python3

TOOL_PATH=$(python3 - <<PYEOF
import sys, re

registry_file = "${REGISTRY}"
target_name   = "${NAME}"
target_type   = "${TYPE}"

try:
    with open(registry_file) as f:
        content = f.read()
except FileNotFoundError:
    print("REGISTRY_NOT_FOUND", end="")
    sys.exit(0)

# Simple YAML parsing — find the entry block for the target tool.
# Uses regex to avoid a hard dependency on PyYAML.
pattern = re.compile(
    r'- name: ' + re.escape(target_name) + r'.*?'
    r'type: ' + re.escape(target_type) + r'.*?'
    r'path: (\S+)',
    re.DOTALL,
)
m = pattern.search(content)
if m:
    print(m.group(1), end="")
else:
    print("NOT_FOUND", end="")
PYEOF
)

if [[ "$TOOL_PATH" == "REGISTRY_NOT_FOUND" ]]; then
  err "Registry not found at ${REGISTRY}. Run this script from the repository root."
fi

if [[ "$TOOL_PATH" == "NOT_FOUND" ]]; then
  err "No ${TYPE} named '${NAME}' found in the registry. Check 'marketplace/registry.yaml'."
fi

FULL_PATH="${REPO_ROOT}/${TOOL_PATH}"

[[ -d "$FULL_PATH" ]] || err "Tool directory '${FULL_PATH}' does not exist."

# --------------------------------------------------------------------------- #
# Install
# --------------------------------------------------------------------------- #

log "Installing ${TYPE} '${NAME}' (${VERSION}) from ${TOOL_PATH} ..."

MANIFEST="${FULL_PATH}/${TYPE}.yaml"

# Determine install method from manifest
INSTALL_METHOD=$(python3 - <<PYEOF
import re, sys
try:
    with open("${MANIFEST}") as f:
        content = f.read()
    m = re.search(r'method:\s*(\S+)', content)
    print(m.group(1) if m else "copy", end="")
except FileNotFoundError:
    print("copy", end="")
PYEOF
)

case "$INSTALL_METHOD" in
  pip)
    require_cmd pip
    log "Running: pip install -e '${FULL_PATH}'"
    pip install -e "${FULL_PATH}"
    ;;
  npm)
    require_cmd npm
    log "Running: npm install '${FULL_PATH}'"
    npm install "${FULL_PATH}"
    ;;
  copy)
    DEST="${HOME}/.licoco/tools/${TYPE}s/${NAME}"
    log "Copying tool to ${DEST}"
    mkdir -p "${DEST}"
    cp -r "${FULL_PATH}/." "${DEST}/"
    ;;
  *)
    err "Unknown install method '${INSTALL_METHOD}' in manifest. Install manually from '${FULL_PATH}'."
    ;;
esac

log "✅  ${TYPE^} '${NAME}' installed successfully."
