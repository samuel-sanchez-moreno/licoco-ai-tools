# Plugins

Plugins integrate external AI platforms, tools, and services into the LiCoCo team's existing systems.

## Available plugins

| Plugin | Description | Version |
|--------|-------------|---------|
| [jira-ai-assistant](./jira-ai-assistant/) | AI-powered Jira ticket assistant — drafts descriptions, suggests labels, and estimates effort | 1.0.0 |

## Adding a new plugin

See the [Contributing Guide](../docs/contributing.md#adding-a-new-plugin).

## Structure

```
plugins/
└── <plugin-name>/
    ├── README.md        # Description and platform-specific installation
    ├── plugin.yaml      # Manifest (name, version, platform, config)
    └── ...              # Implementation files
```
