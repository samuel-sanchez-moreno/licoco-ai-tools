# daily-standup-summary

Automatically generates a concise daily standup summary by pulling activity from Jira, Slack, and GitHub, then formatting it into a ready-to-share message.

## What it does

1. Fetches Jira tickets updated in the last 24 hours for your team.
2. Fetches GitHub pull requests opened, reviewed, or merged yesterday.
3. Fetches key Slack messages from designated channels.
4. Summarises all activity into a structured standup format using an LLM.
5. Optionally posts the summary to a Slack channel.

## Output format

```
📅 Standup Summary — 2024-01-15

✅ Done yesterday
- Merged PR #42: Add user authentication
- Closed Jira PROJ-101: Fix login bug

🔄 In progress today
- Reviewing PR #45: Add payment flow
- PROJ-105: Write unit tests for auth module

🚧 Blockers
- Waiting for design approval on PROJ-107
```

## Configuration

| Variable | Required | Description |
|----------|----------|-------------|
| `OPENAI_API_KEY` | ✅ | OpenAI API key |
| `JIRA_URL` | ✅ | Jira instance URL |
| `JIRA_EMAIL` | ✅ | Jira account email |
| `JIRA_API_TOKEN` | ✅ | Jira API token |
| `GITHUB_TOKEN` | ✅ | GitHub personal access token |
| `SLACK_BOT_TOKEN` | ❌ | Slack bot token (required to post output) |
| `SLACK_CHANNEL` | ❌ | Slack channel ID to post summary to |
| `JIRA_PROJECT` | ✅ | Jira project key (e.g. `PROJ`) |
| `GITHUB_REPO` | ✅ | GitHub repo in `owner/repo` format |

## Installation

```bash
./scripts/install.sh workflow daily-standup-summary
```

## Running manually

```bash
python workflows/daily-standup-summary/main.py
```

## Scheduling

To run automatically each morning, add to your crontab:

```cron
0 9 * * 1-5 /path/to/licoco-ai-tools/scripts/run-workflow.sh daily-standup-summary
```

## Version

1.0.0
