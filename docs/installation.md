# Installation Guide

This guide explains how to install, configure, and update AI skills, agents, plugins, and workflows from this repository.

## Prerequisites

Before you begin, make sure you have the following installed:

| Requirement | Minimum version | Purpose |
|-------------|-----------------|---------|
| Git | 2.x | Cloning and updating the repository |
| Python | 3.10 | Python-based skills and agents |
| Node.js | 18 LTS | JavaScript/TypeScript plugins |
| pipx | latest | Isolated Python tool installs |
| jq | 1.6 | Parsing the marketplace registry |

### Install prerequisites on macOS

```bash
brew install git python@3.11 node pipx jq
pipx ensurepath
```

### Install prerequisites on Ubuntu / Debian

```bash
sudo apt-get update
sudo apt-get install -y git python3 python3-pip nodejs npm jq
pip install --user pipx
pipx ensurepath
```

---

## Cloning the repository

```bash
git clone https://github.com/samuel-sanchez-moreno/licoco-ai-tools.git
cd licoco-ai-tools
```

---

## Installing tools with the install script

The [`scripts/install.sh`](../scripts/install.sh) script is the recommended way to install any tool from this repository.

### Usage

```
./scripts/install.sh <type> <name> [--version <version>]
```

| Argument | Description |
|----------|-------------|
| `<type>` | One of: `skill`, `agent`, `plugin`, `workflow` |
| `<name>` | The tool name as listed in the [marketplace registry](../marketplace/registry.yaml) |
| `--version` | (Optional) Pin to a specific version tag. Defaults to `latest`. |

### Examples

```bash
# Install the latest version of a skill
./scripts/install.sh skill summarise-email

# Install a specific version of a plugin
./scripts/install.sh plugin jira-ai-assistant --version 1.2.0

# Install an agent
./scripts/install.sh agent code-reviewer
```

---

## Installing skills manually

1. Browse [`skills/`](../skills/) or the [marketplace registry](../marketplace/registry.yaml) to find the skill you need.
2. Copy the skill directory to your project or install via pip/npm as documented in the skill's own `README.md`.
3. Follow any environment variable or configuration instructions in the skill's `README.md`.

---

## Installing plugins manually

1. Browse [`plugins/`](../plugins/) or the [marketplace registry](../marketplace/registry.yaml).
2. Each plugin directory contains a `README.md` with platform-specific installation instructions.
3. Common plugin types:
   - **VS Code extensions** — install via the VS Code Extensions marketplace or by importing the `.vsix` file.
   - **ChatGPT / OpenAI plugins** — follow the plugin manifest instructions.
   - **Python packages** — `pip install -e plugins/<plugin-name>`
   - **npm packages** — `npm install plugins/<plugin-name>`

---

## Updating tools

To update all tools to their latest versions, pull the latest repository changes and re-run the install script:

```bash
git pull origin main
./scripts/install.sh skill <name>   # re-install to pick up the latest version
```

Or use the marketplace update helper:

```bash
./scripts/marketplace-update.sh
```

---

## Configuration

Most tools expect configuration via environment variables. Copy the provided `.env.example` file (if present in a tool directory) and fill in your values:

```bash
cp skills/summarise-email/.env.example skills/summarise-email/.env
# Edit .env with your API keys and preferences
```

Never commit `.env` files — they are listed in `.gitignore`.

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `Permission denied` on `install.sh` | Run `chmod +x scripts/install.sh` |
| Python version mismatch | Use `pyenv` to manage multiple Python versions |
| Node version mismatch | Use `nvm` to manage multiple Node versions |
| Missing API key errors | Ensure all required environment variables are set |

For further help, open an issue in the [GitHub repository](https://github.com/samuel-sanchez-moreno/licoco-ai-tools/issues).
