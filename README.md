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

### Shell: `.zprofile` vs `.zshrc`

zsh loads these files at different stages:

- **`.zprofile`** runs once per **login shell** (e.g. when you open a new terminal window or SSH in). This is the right place for environment setup that only needs to happen once and should be inherited by child processes: Homebrew shell environment (`brew shellenv`) and OrbStack CLI integration.

- **`.zshrc`** runs for every **interactive shell** (login shells and subshells like `zsh` typed inside a terminal). This is where per-session configuration goes: PATH modifications (`~/.local/bin`), aliases, prompt settings, completions.

In practice on macOS, Terminal.app and iTerm2 open login shells, so both files run. But if you spawn a subshell (`zsh` inside zsh), only `.zshrc` runs again — which is why expensive one-time setup (like `brew shellenv`) belongs in `.zprofile`.

### Git: `.gitconfig`

User identity and a set of short aliases for everyday git commands:

| Alias | Command |
|-------|---------|
| `aa` | `add .` |
| `br` | `branch` |
| `st` | `status --short` |
| `ci` | `commit` |
| `df` | `diff` |
| `co` | `checkout` |
| `p` | `push --verbose` |
| `pf` | `push --verbose --force` |
| `pt` | `push --verbose --tags` |
| `pl` | `pull --verbose` |
| `rh` | `reset --hard` |
| `l` | `log --decorate` |
| `gr` | colorized graph log with author info |
| `unstage` | `reset HEAD --` |
| `last` | show the last commit |

### SSH: `.ssh/config`

Includes OrbStack SSH configuration for seamless access to OrbStack Linux VMs via `ssh orb`.

### Git ignore: `.config/git/ignore`

Global gitignore rules applied to all repositories. Currently ignores `.claude/settings.local.json` (local Claude Code settings that should not be committed).

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
