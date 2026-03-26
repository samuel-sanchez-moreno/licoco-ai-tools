# Workflows

Workflows are automated, multi-step AI processes that combine skills and agents to accomplish larger tasks with minimal human intervention.

## Available workflows

| Workflow | Description | Version |
|----------|-------------|---------|
| [daily-standup-summary](./daily-standup-summary/) | Generates a daily standup summary from Jira, Slack, and GitHub activity | 1.0.0 |

## Adding a new workflow

See the [Contributing Guide](../docs/contributing.md#adding-a-new-workflow).

## Structure

```
workflows/
└── <workflow-name>/
    ├── README.md          # Description, trigger, and expected output
    ├── workflow.yaml      # Manifest (name, version, steps, schedule)
    └── ...                # Implementation files
```
