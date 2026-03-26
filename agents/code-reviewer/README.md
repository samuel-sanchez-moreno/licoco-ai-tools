# code-reviewer

An AI agent that automatically reviews pull requests, checks for code quality issues, suggests improvements, and flags potential bugs.

## Usage

```bash
export OPENAI_API_KEY=sk-...
export GITHUB_TOKEN=ghp_...

python agents/code-reviewer/main.py --pr <pull-request-url>
```

## Configuration

| Variable | Required | Description |
|----------|----------|-------------|
| `OPENAI_API_KEY` | ✅ | OpenAI API key |
| `GITHUB_TOKEN` | ✅ | GitHub personal access token with `repo` scope |
| `OPENAI_MODEL` | ❌ | Model to use (default: `gpt-4o`) |
| `MAX_DIFF_LINES` | ❌ | Max diff lines to review per PR (default: 500) |

## What it checks

- Code style and readability
- Potential bugs and edge cases
- Security issues (e.g., hardcoded secrets, SQL injection)
- Test coverage gaps
- Documentation completeness

## Installation

```bash
./scripts/install.sh agent code-reviewer
```

## Version

1.0.0
