---
name: jira
description: Fetch information from a Jira ticket using the Atlassian CLI (`acli`). Use whenever the user references a Jira issue key (e.g. ABC-123, PROJ-4567) or asks to "look up", "read", "fetch", "summarise", or "get details on" a ticket. Also use when the user pastes a Jira URL like https://<site>.atlassian.net/browse/KEY-123.
---

# jira

Pull ticket information from Jira via the Atlassian CLI (`acli`). The CLI is the source of truth — do not guess ticket contents from the key alone, and do not fall back to the REST API or web fetch unless the user asks for it.

## Prerequisites

1. `acli` must be on PATH. If `command -v acli` returns nothing, stop and tell the user:
   - macOS: `brew install atlassian/acli/acli`
   - Other platforms: https://developer.atlassian.com/cloud/acli/guides/install/
2. The user must be logged in. If a command fails with an auth error, tell the user to run `acli jira auth login` themselves (it's interactive — don't try to run it for them).

## Resolving the ticket key

- If the user gives a key like `PROJ-123`, use it directly.
- If the user gives a URL like `https://<site>.atlassian.net/browse/PROJ-123`, extract `PROJ-123`.
- If the user is vague ("that ticket I mentioned"), ask for the key — don't search blind.

## Getting ticket info

Default command:

```
acli jira workitem view <KEY>
```

Useful variants — pick based on what the user actually asked for:

- **Just the summary / a quick look** → default `view` is enough.
- **Specific fields only** (e.g. status, assignee, sprint): `acli jira workitem view <KEY> --fields summary,status,assignee`
- **Machine-readable for further processing**: `acli jira workitem view <KEY> --json` and parse with `jq`.
- **Comments**: the `--fields comment` flag *includes* comments but the plain-text renderer silently drops their bodies, so always combine with `--json` and extract:
  ```
  acli jira workitem view <KEY> --fields comment --json | jq -r '
    .fields.comment.comments[] |
    "── \(.author.displayName) — \(.created[:10]) ──\n" +
    ([.. | .text? // empty] | join(" ")) + "\n"
  '
  ```
  The body is in Atlassian Document Format (a nested tree of `content` nodes); the recursive `.. | .text?` flattens it to plain text. Mermaid / code blocks come through as inline text — fine for reading, ugly for rendering.
- **Linked issues / subtasks**: not in the default field set. Add `--fields '*all'` and grep, or `--fields summary,issuelinks,subtasks --json`.

There is no top-level `--comments` flag. If the user asks something the default output doesn't cover, run `acli jira workitem view --help` to discover the right flag rather than guessing.

## Reporting back

- Lead with the one-line answer to what the user asked (status, assignee, summary, whatever).
- Include the key and a clickable URL if you have the site.
- Quote the ticket fields you used — don't paraphrase status names or field values.
- If the ticket has a lot of comments or a long description, summarise but offer to dump the full text.

## Don't

- Don't open a browser or use `WebFetch` on the Jira URL when `acli` would work — it's slower and the output is harder to parse.
- Don't invent fields. If a field isn't in the CLI output, say so.
- Don't run write commands (`edit`, `transition`, `comment`, `assign`) unless the user explicitly asks. Reading is safe; writing is not.
