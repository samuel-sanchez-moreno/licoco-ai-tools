# Agents

Agents are autonomous AI programs that can plan and execute multi-step tasks, using skills and tools as building blocks.

## Available agents

| Agent | Description | Version |
|-------|-------------|---------|
| [code-reviewer](./code-reviewer/) | Reviews pull requests and suggests improvements using an LLM | 1.0.0 |

## Adding a new agent

See the [Contributing Guide](../docs/contributing.md#adding-a-new-agent).

## Structure

```
agents/
└── <agent-name>/
    ├── README.md        # Description and usage
    ├── agent.yaml       # Manifest (name, version, tools, config)
    └── ...              # Implementation files
```
