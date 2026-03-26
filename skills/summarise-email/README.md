# summarise-email

Summarises long email threads into concise bullet points using an LLM.

## Usage

```python
from summarise_email import summarise

result = summarise(email_thread="...")
print(result)
```

## Inputs

| Name | Type | Required | Description |
|------|------|----------|-------------|
| `email_thread` | `string` | ✅ | The raw email thread text |
| `max_bullets` | `integer` | ❌ | Maximum number of bullet points (default: 5) |
| `language` | `string` | ❌ | Output language (default: `en`) |

## Outputs

| Name | Type | Description |
|------|------|-------------|
| `summary` | `string` | Bullet-point summary of the thread |
| `action_items` | `list[string]` | Extracted action items |

## Environment variables

| Variable | Required | Description |
|----------|----------|-------------|
| `OPENAI_API_KEY` | ✅ | Your OpenAI API key |
| `OPENAI_MODEL` | ❌ | Model to use (default: `gpt-4o`) |

## Installation

```bash
./scripts/install.sh skill summarise-email
```

Or manually:

```bash
pip install -e skills/summarise-email
```

## Version

1.0.0
