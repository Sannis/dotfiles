# Dotfiles

Dotfiles managed with [yadm](https://yadm.io).

## Quick start

```bash
curl -fsSL https://raw.githubusercontent.com/Sannis/dotfiles/master/setup.sh | bash
```

## Manual setup

```bash
brew install yadm
yadm clone git@github.com:Sannis/dotfiles.git
```

## How yadm works

yadm stores its bare repo at `~/.local/share/yadm/repo.git`. Dotfiles are tracked in-place in the home directory — no symlinks needed.

On a fresh clone, yadm runs `.config/yadm/bootstrap`, which enables sparse checkout to keep repo-only files (`README.md`, `setup.sh`, `CLAUDE.md`) out of the home directory.

## Adding files to tracking

To start tracking a new dotfile:

```bash
yadm add ~/.vimrc
yadm commit -m "Add .vimrc"
yadm push
```

Files in subdirectories work the same way:

```bash
yadm add ~/.config/starship.toml
yadm commit -m "Add starship config"
yadm push
```

To see what's currently tracked:

```bash
yadm list -a
```

To check for uncommitted changes in tracked files:

```bash
yadm status
```

## Tracked files

### Shell

#### `.zprofile`

Runs once per login shell (e.g. when you open a new terminal window or SSH in). Contains environment setup that only needs to happen once and should be inherited by child processes: Homebrew shell environment (`brew shellenv`) and OrbStack CLI integration.

#### `.zshrc`

Runs for every interactive shell (login shells and subshells like `zsh` typed inside a terminal). Contains per-session configuration: PATH modifications (`~/.local/bin`), aliases, prompt settings, completions.

In practice on macOS, Terminal.app and iTerm2 open login shells, so both files run. But if you spawn a subshell (`zsh` inside zsh), only `.zshrc` runs again — which is why expensive one-time setup (like `brew shellenv`) belongs in `.zprofile`.

### Git

#### `.gitconfig`

User identity and a set of short aliases for everyday git commands.

#### `.config/git/ignore`

Global gitignore rules applied to all repositories. Currently ignores `.claude/settings.local.json` (local Claude Code settings that should not be committed).

### SSH

#### `.ssh/config`

Includes OrbStack SSH configuration for seamless access to OrbStack Linux VMs via `ssh orb`.

### Claude Code

#### `.claude/CLAUDE.md`

Global Claude Code instructions applied to all projects: git operation conventions and Markdown style preferences.

#### `.claude/settings.json`

Claude Code settings: pre-approved bash command permissions and a `PreToolUse` hook that auto-approves read-only `gcloud` commands.

#### `.claude/hooks/gcloud-permissions.sh`

`PreToolUse` hook script that intercepts Bash tool calls and auto-approves read-only `gcloud` commands. Write commands are deferred to Claude's normal approval flow.

#### `.claude/hooks/gcloud-permissions.test.sh`

Tests for the gcloud permissions hook.

### Zed

#### `.config/zed/settings.json`

Zed editor settings: JetBrains keymap, font sizes, One Light/Dark theme following system appearance, and telemetry preferences.

