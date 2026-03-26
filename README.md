# licoco-ai-tools

Central repository for the **LiCoCo** team's AI tools — skills, agents, plugins, workflows, and scripts used in day-to-day work.

## Overview

This repository serves as the single source of truth for all AI-powered tooling used by the LiCoCo team. It includes:

| Directory | Description |
|-----------|-------------|
| [`skills/`](./skills/) | Reusable AI skills (e.g., prompts, chains, task modules) |
| [`agents/`](./agents/) | Autonomous AI agents and their configurations |
| [`plugins/`](./plugins/) | Integrations and plugins for external AI platforms |
| [`workflows/`](./workflows/) | Automated workflows powered by AI |
| [`scripts/`](./scripts/) | Utility scripts for installation, maintenance, and automation |
| [`marketplace/`](./marketplace/) | Marketplace registry for discovering and installing tools |
| [`docs/`](./docs/) | Documentation, guides, and references |

## Quick Start

### Prerequisites

- Python ≥ 3.10 (for Python-based skills/agents)
- Node.js ≥ 18 (for JavaScript-based plugins)
- [pipx](https://pypa.github.io/pipx/) (recommended for isolated installs)

### Install a skill

```bash
# Using the install script
./scripts/install.sh skill <skill-name>

# Example
./scripts/install.sh skill summarise-email
```

### Install a plugin

```bash
./scripts/install.sh plugin <plugin-name>

# Example
./scripts/install.sh plugin jira-ai-assistant
```

### Browse the marketplace

See [`marketplace/registry.yaml`](./marketplace/registry.yaml) for the full list of available tools, or read the [Marketplace guide](./docs/marketplace.md).

## Documentation

- [Installation Guide](./docs/installation.md) — step-by-step setup instructions
- [Marketplace Guide](./docs/marketplace.md) — how to discover, install, and update tools
- [Contributing Guide](./docs/contributing.md) — how to add new tools to this repository
- [Skills Guide](./skills/README.md)
- [Agents Guide](./agents/README.md)
- [Plugins Guide](./plugins/README.md)
- [Workflows Guide](./workflows/README.md)
- [Scripts Guide](./scripts/README.md)

## Backstage

This repository is registered in the internal developer portal (Backstage). See [`catalog.yaml`](./catalog.yaml) for the catalog definition.

## Contributing

Please read the [Contributing Guide](./docs/contributing.md) before opening a pull request.

## License

Internal use only — © LiCoCo team.
