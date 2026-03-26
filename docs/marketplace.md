# Marketplace Guide

The LiCoCo AI Marketplace is the central catalogue for discovering, installing, and updating all AI tools maintained in this repository.

## What is the marketplace?

The marketplace is a YAML-based registry ([`marketplace/registry.yaml`](../marketplace/registry.yaml)) that lists every available tool along with its metadata: name, type, version, description, author, and installation details.

It is designed to be:

- **Browsable** — view all available tools in one place.
- **Machine-readable** — the install script reads the registry to resolve installation commands.
- **Version-controlled** — adding or updating a tool means opening a pull request, giving the team full visibility.

---

## Browsing available tools

### Via GitHub

Open [`marketplace/registry.yaml`](../marketplace/registry.yaml) in your browser.

### Via the CLI

```bash
# List all available tools
./scripts/marketplace-list.sh

# Filter by type
./scripts/marketplace-list.sh --type skill
./scripts/marketplace-list.sh --type plugin

# Search by keyword
./scripts/marketplace-list.sh --search email
```

### Via Backstage

The marketplace is registered in the internal Backstage developer portal. Navigate to the **LiCoCo AI Tools** system in the catalog to see all components.

---

## Installing a tool

Use the install script to install any tool by its registry name:

```bash
./scripts/install.sh <type> <name> [--version <version>]
```

See the [Installation Guide](./installation.md) for full details.

---

## Updating tools

### Update a single tool

```bash
git pull origin main
./scripts/install.sh <type> <name>
```

### Update all installed tools

```bash
./scripts/marketplace-update.sh
```

This script reads the registry, compares installed versions against the latest available, and re-installs any tools that have newer versions.

---

## Publishing a new tool

To add your tool to the marketplace:

1. Create a directory under the appropriate category (`skills/`, `agents/`, `plugins/`, or `workflows/`).
2. Add a `README.md` and a manifest file (`skill.yaml`, `agent.yaml`, etc.) following the [Contributing Guide](./contributing.md).
3. Add an entry to [`marketplace/registry.yaml`](../marketplace/registry.yaml).
4. Open a pull request — once merged, your tool becomes available to the whole team.

---

## Registry format

Each entry in `registry.yaml` follows this structure:

```yaml
- name: summarise-email           # unique identifier
  type: skill                     # skill | agent | plugin | workflow
  title: Summarise Email          # human-readable title
  description: >
    Summarises email threads using an LLM.
  version: 1.0.0
  author: licoco
  tags:
    - email
    - summarisation
  path: skills/summarise-email    # path within this repo
  install:
    method: pip                   # pip | npm | copy | custom
    source: skills/summarise-email
  requires:
    python: ">=3.10"
```

See [`marketplace/registry.yaml`](../marketplace/registry.yaml) for real examples.
