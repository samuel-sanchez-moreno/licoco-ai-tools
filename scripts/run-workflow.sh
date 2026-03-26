#!/usr/bin/env bash
# run-workflow.sh — Run a LiCoCo AI workflow by name.
#
# Usage:
#   ./scripts/run-workflow.sh <workflow-name> [-- <extra-args>]
#
# Arguments:
#   workflow-name  The workflow name as listed in marketplace/registry.yaml
#   extra-args     Additional arguments passed to the workflow's main.py
#
# Examples:
#   ./scripts/run-workflow.sh daily-standup-summary
#   ./scripts/run-workflow.sh daily-standup-summary -- --dry-run

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  grep '^#' "$0" | sed 's/^# \{0,1\}//' | tail -n +2
  exit 1
}

err() { echo "[run-workflow] ERROR: $*" >&2; exit 1; }
log() { echo "[run-workflow] $*"; }

[[ $# -lt 1 ]] && usage

WORKFLOW_NAME="$1"
shift

EXTRA_ARGS=()
if [[ $# -gt 0 && "$1" == "--" ]]; then
  shift
  EXTRA_ARGS=("$@")
fi

WORKFLOW_DIR="${REPO_ROOT}/workflows/${WORKFLOW_NAME}"

[[ -d "$WORKFLOW_DIR" ]] || \
  err "Workflow '${WORKFLOW_NAME}' not found at '${WORKFLOW_DIR}'."

ENTRYPOINT="${WORKFLOW_DIR}/main.py"

[[ -f "$ENTRYPOINT" ]] || \
  err "No 'main.py' found in '${WORKFLOW_DIR}'. Please add an entrypoint."

log "Running workflow '${WORKFLOW_NAME}'..."
python3 "${ENTRYPOINT}" "${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}"
