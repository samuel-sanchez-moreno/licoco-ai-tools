# Skills

Skills are reusable, single-purpose AI modules — prompt templates, LLM chains, or task functions — that can be embedded into agents, workflows, or used standalone.

## Available skills

| Skill | Description | Version |
|-------|-------------|---------|
| [summarise-email](./summarise-email/) | Summarises email threads using an LLM | 1.0.0 |

## Adding a new skill

See the [Contributing Guide](../docs/contributing.md#adding-a-new-skill).

## Structure

Each skill lives in its own directory:

```
skills/
└── <skill-name>/
    ├── README.md        # Usage instructions
    ├── skill.yaml       # Manifest (name, version, inputs, outputs)
    └── ...              # Implementation (Python, JS, shell, etc.)
```
