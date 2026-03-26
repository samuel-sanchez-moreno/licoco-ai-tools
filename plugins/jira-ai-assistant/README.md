# jira-ai-assistant

An AI-powered plugin for Jira that helps the team write better tickets faster. It drafts descriptions, suggests labels, and estimates story points.

## Features

- 📝 **Auto-draft ticket descriptions** — provide a brief idea and get a fully-formed Jira ticket.
- 🏷️ **Label suggestions** — automatically suggests relevant labels based on the ticket content.
- ⏱️ **Effort estimation** — estimates story points using historical data patterns.
- 🔍 **Duplicate detection** — warns when a new ticket may duplicate an existing one.

## Installation

### Via the install script

```bash
./scripts/install.sh plugin jira-ai-assistant
```

### Manual installation

```bash
pip install -e plugins/jira-ai-assistant
```

## Configuration

| Variable | Required | Description |
|----------|----------|-------------|
| `OPENAI_API_KEY` | ✅ | OpenAI API key |
| `JIRA_URL` | ✅ | Your Jira instance URL (e.g. `https://myteam.atlassian.net`) |
| `JIRA_EMAIL` | ✅ | Jira account email |
| `JIRA_API_TOKEN` | ✅ | Jira API token |

## Usage

```python
from jira_ai_assistant import JiraAssistant

assistant = JiraAssistant()
ticket = assistant.draft_ticket(
    summary="Users cannot log in after password reset",
    project="PROJ"
)
print(ticket)
```

## Version

1.0.0
