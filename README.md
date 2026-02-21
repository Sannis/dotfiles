# dotfiles

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

## Tracked files

### Shell: `.zprofile` vs `.zshrc`

`zsh` loads these files at different stages:

- **`.zprofile`** runs once per **login shell** (e.g. when you open a new terminal window or SSH in). This is the right place for environment setup that only needs to happen once and should be inherited by child processes: Homebrew shell environment (`brew shellenv`) and OrbStack CLI integration.

- **`.zshrc`** runs for every **interactive shell** (login shells and subshells like `zsh` typed inside a terminal). This is where per-session configuration goes: PATH modifications (`~/.local/bin`), aliases, prompt settings, completions.

In practice on macOS, Terminal.app and iTerm2 open login shells, so both files run. But if you spawn a subshell (`zsh` inside zsh), only `.zshrc` runs again — which is why expensive one-time setup (like `brew shellenv`) belongs in `.zprofile`.

### Git: `.gitconfig`

User identity and a set of short aliases for everyday git commands.

### SSH: `.ssh/config`

Includes OrbStack SSH configuration for seamless access to OrbStack Linux VMs via `ssh orb`.

### Git ignore: `.config/git/ignore`

Global gitignore rules applied to all repositories. Currently ignores `.claude/settings.local.json` (local Claude Code settings that should not be committed).

## yadm repo location

yadm stores its bare repo at `~/.local/share/yadm/repo.git`. Dotfiles are tracked in-place in the home directory — no symlinks needed.

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
