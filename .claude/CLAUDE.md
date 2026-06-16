# CLAUDE.md

Personal preferences that apply to every Claude Code session across all projects.

## Git Operations

- Run `git` without `-C` flag and without `cd` when already inside the repository.
- Do not use `$()` command substitution in commit messages — pass the message directly to `-m`.
- Do not commit or push unless explicitly asked by the user or required by an agreed execution plan. Even
  though `git commit` and `git push` are allowed in permissions, treat them as user-initiated actions only.

## GitHub CLI usage

- Prefer high-level `gh` commands (`gh run view`, `gh pr view`, `gh issue view`, etc.) over raw `gh api`
  calls for reading GitHub data.

## Settings JSON allowed commands ordering

When adding or reordering entries in the `permissions.allow` array in settings.json, sort them in this order:

- Generic commands (`date`, `grep`, `ls`, `make`, `mkdir`, `open`, `sort`, etc.) — sorted alphabetically
- `gh` commands (`gh issue`, `gh pr`, `gh repo`, `gh run`, etc.) — sorted alphabetically
- `git` commands (`git add`, `git checkout`, `git commit`, etc.) — sorted alphabetically
- `gcloud` commands — sorted alphabetically
- `kubectl` commands — sorted alphabetically
- `terraform` commands — sorted alphabetically
- WebSearch / WebFetch entries
- MCP tool entries (`mcp__*`)

## Markdown Style

- Use plain Markdown with clear headings and short actionable steps.
- Keep shell commands in fenced code blocks with `bash` syntax highlighting.
- Prefer minimal emphasis markup (bold, italic) usage in text.
- Use backticks (not bold) for network names, VPC names, hostnames, and similar technical identifiers.
- Wrap long lines in markdown files at 120 characters. When wrapping, prefer breaking after a closing
  parenthesis, comma, or period rather than mid-phrase. When two sentences fit on one line but exceed
  120 characters, break between the sentences (after the period) even if each sentence alone is under
  120 characters.
- Always align table column borders vertically so all `|` delimiters line up across rows.
- Use at least 1 space of padding on each side of cell content. Add a few extra spaces of padding beyond
  the longest cell value so that adding slightly longer values later won't require realigning the entire
  column. Example:

  | Name   | Value |
  |--------|-------|
  | short  | data  |
  | longer | more  |
