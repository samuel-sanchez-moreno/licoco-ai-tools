# Marketplace

The marketplace is the central registry for all LiCoCo AI tools.

## Registry

[`registry.yaml`](./registry.yaml) lists every available tool with its name, type, version, description, and installation instructions.

## How to use

### List all available tools

```bash
./scripts/marketplace-list.sh
```

### Filter by type

```bash
./scripts/marketplace-list.sh --type skill
```

### Search by keyword

```bash
./scripts/marketplace-list.sh --search jira
```

### Install a tool

```bash
./scripts/install.sh <type> <name>
```

See the [Installation Guide](../docs/installation.md) for full details.

## How to publish a tool

See the [Contributing Guide](../docs/contributing.md#updating-the-marketplace-registry).
