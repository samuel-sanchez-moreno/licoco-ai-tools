# Contributing Guide

Thank you for contributing to the LiCoCo AI Tools repository! This guide explains how to add new tools, update existing ones, and follow the team's conventions.

## Table of contents

1. [Getting started](#getting-started)
2. [Repository structure](#repository-structure)
3. [Adding a new skill](#adding-a-new-skill)
4. [Adding a new agent](#adding-a-new-agent)
5. [Adding a new plugin](#adding-a-new-plugin)
6. [Adding a new workflow](#adding-a-new-workflow)
7. [Updating the marketplace registry](#updating-the-marketplace-registry)
8. [Pull request checklist](#pull-request-checklist)

---

## Getting started

1. Fork or clone the repository.
2. Create a feature branch: `git checkout -b feat/my-new-skill`
3. Make your changes (see sections below).
4. Commit with a clear message: `git commit -m "feat: add summarise-email skill"`
5. Open a pull request against `main`.

---

## Repository structure

```
licoco-ai-tools/
├── catalog.yaml              # Backstage catalog definitions
├── docs/                     # Documentation
├── skills/                   # Reusable AI skills
│   └── <skill-name>/
│       ├── README.md
│       ├── skill.yaml        # Skill manifest
│       └── ...               # Implementation files
├── agents/                   # Autonomous AI agents
│   └── <agent-name>/
│       ├── README.md
│       ├── agent.yaml        # Agent manifest
│       └── ...
├── plugins/                  # Integrations and plugins
│   └── <plugin-name>/
│       ├── README.md
│       ├── plugin.yaml       # Plugin manifest
│       └── ...
├── workflows/                # Automated AI workflows
│   └── <workflow-name>/
│       ├── README.md
│       ├── workflow.yaml     # Workflow manifest
│       └── ...
├── scripts/                  # Utility scripts
└── marketplace/
    └── registry.yaml         # Marketplace catalogue
```

---

## Adding a new skill

1. Create a directory: `skills/<your-skill-name>/`
2. Add a `README.md` describing what the skill does, its inputs/outputs, and usage examples.
3. Add a `skill.yaml` manifest:

```yaml
name: your-skill-name
title: Your Skill Title
description: One-line description.
version: 1.0.0
author: your-github-username
tags:
  - relevant-tag
inputs:
  - name: input_text
    type: string
    description: The text to process.
outputs:
  - name: result
    type: string
    description: The processed result.
install:
  method: pip   # or npm, copy, custom
  source: skills/your-skill-name
requires:
  python: ">=3.10"
```

4. Implement the skill (Python, Node.js, or shell).
5. Add an entry to [`marketplace/registry.yaml`](../marketplace/registry.yaml).

---

## Adding a new agent

1. Create a directory: `agents/<your-agent-name>/`
2. Add a `README.md` and an `agent.yaml` manifest (same structure as `skill.yaml` but with `type: agent`).
3. Include all configuration files the agent needs (prompts, tool definitions, etc.).
4. Add an entry to the marketplace registry.

---

## Adding a new plugin

1. Create a directory: `plugins/<your-plugin-name>/`
2. Add a `README.md` with platform-specific installation instructions.
3. Add a `plugin.yaml` manifest.
4. Add an entry to the marketplace registry.

---

## Adding a new workflow

1. Create a directory: `workflows/<your-workflow-name>/`
2. Add a `README.md` explaining the workflow's purpose and trigger conditions.
3. Add a `workflow.yaml` manifest.
4. Add an entry to the marketplace registry.

---

## Updating the marketplace registry

Open [`marketplace/registry.yaml`](../marketplace/registry.yaml) and add or update your tool's entry. Follow the existing format. Bump the `version` field using [Semantic Versioning](https://semver.org/).

---

## Pull request checklist

Before opening a PR, please make sure:

- [ ] The tool directory contains a `README.md`
- [ ] The manifest file (`skill.yaml`, `agent.yaml`, etc.) is present and valid
- [ ] The marketplace registry has been updated
- [ ] Sensitive data (API keys, passwords) is **not** hard-coded — use environment variables
- [ ] The PR description explains what the tool does and why it is useful

Thank you for making the LiCoCo team more productive! 🚀
