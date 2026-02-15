# dotfiles

Dotfiles managed with [yadm](https://yadm.io).

## Quick start

```bash
curl -fsSL https://raw.githubusercontent.com/Sannis/dotfiles/master/setup.sh | bash
```

Or clone the repo first and run locally:

```bash
git clone git@github.com:Sannis/dotfiles.git /tmp/dotfiles
/tmp/dotfiles/setup.sh
```

## Manual setup

```bash
brew install yadm
yadm clone git@github.com:Sannis/dotfiles.git
```

## Tracked files

- `.zshrc` — shell configuration
- `.zprofile` — Homebrew and OrbStack init
- `.gitconfig` — git user info and aliases
- `.ssh/config` — SSH configuration
- `.config/git/ignore` — global gitignore

## yadm repo location

yadm stores its bare repo at `~/.local/share/yadm/repo.git`. Dotfiles are tracked in-place in the home directory — no symlinks needed.

## Common yadm commands

```bash
yadm status          # check status
yadm add <file>      # track a new dotfile
yadm commit -m "msg" # commit changes
yadm push            # push to remote
yadm list            # list tracked files
```
