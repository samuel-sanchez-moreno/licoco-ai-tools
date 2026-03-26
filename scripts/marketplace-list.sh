#!/usr/bin/env bash
# marketplace-list.sh — List tools available in the LiCoCo AI marketplace.
#
# Usage:
#   ./scripts/marketplace-list.sh [--type <type>] [--search <keyword>]
#
# Options:
#   --type    Filter by type: skill, agent, plugin, workflow
#   --search  Filter by keyword (matches name, title, description, tags)
#
# Examples:
#   ./scripts/marketplace-list.sh
#   ./scripts/marketplace-list.sh --type skill
#   ./scripts/marketplace-list.sh --search email

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REGISTRY="${REPO_ROOT}/marketplace/registry.yaml"

usage() {
  grep '^#' "$0" | sed 's/^# \{0,1\}//' | tail -n +2
  exit 1
}

err() { echo "[marketplace-list] ERROR: $*" >&2; exit 1; }

TYPE_FILTER=""
SEARCH_FILTER=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --type)   TYPE_FILTER="$2";   shift 2 ;;
    --search) SEARCH_FILTER="$2"; shift 2 ;;
    -h|--help) usage ;;
    *) err "Unknown argument: $1" ;;
  esac
done

[[ -f "$REGISTRY" ]] || err "Registry not found at ${REGISTRY}."

python3 - <<PYEOF
import re, sys

registry_file  = "${REGISTRY}"
type_filter    = "${TYPE_FILTER}".strip()
search_filter  = "${SEARCH_FILTER}".strip().lower()

with open(registry_file) as f:
    content = f.read()

# Split into individual tool entries (each starts with '- name:')
entries = re.split(r'\n(?=- name:)', content.strip())

results = []
for entry in entries:
    if not entry.strip() or entry.strip().startswith('#'):
        continue

    def field(key):
        m = re.search(rf'{key}:\s*(.+)', entry)
        return m.group(1).strip() if m else ''

    def multiline_field(key):
        # Match 'key: >' (folded block) followed by indented lines, or single-line value
        m = re.search(rf'{key}:\s*>\n((?:[ \t]+.+\n?)+)', entry)
        if m:
            return re.sub(r'\s+', ' ', m.group(1)).strip()
        return field(key)

    name        = field('name')
    type_       = field('type')
    title       = field('title')
    description = multiline_field('description')
    version     = field('version')

    if type_filter and type_ != type_filter:
        continue

    if search_filter:
        haystack = f"{name} {type_} {title} {description}".lower()
        if search_filter not in haystack:
            continue

    results.append((type_, name, title, version, description[:60] + ('…' if len(description) > 60 else '')))

if not results:
    print("No tools found matching your criteria.")
    sys.exit(0)

# Print table
col_widths = [max(len(r[i]) for r in results + [('TYPE','NAME','TITLE','VERSION','DESCRIPTION')]) for i in range(5)]
fmt = '  '.join(f'{{:<{w}}}' for w in col_widths)
header = fmt.format('TYPE', 'NAME', 'TITLE', 'VERSION', 'DESCRIPTION')
print(header)
print('-' * len(header))
for row in sorted(results):
    print(fmt.format(*row))
PYEOF
