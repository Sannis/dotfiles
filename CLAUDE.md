## Overview

- This folder is a cloned copy of the dotfiles repo (`github.com:Sannis/dotfiles.git`).
- yadm tracks the same repo with `$HOME` as the work tree.

## Git and yadm workflow

- Use `yadm` for files under `~`; use `git` for files in this cloned repo.
- Run `yadm` from any directory — it uses its own `GIT_DIR`/`GIT_WORK_TREE` internally, so `cd ~` before yadm commands is never needed.
- After `git push`, run `yadm pull --rebase` to keep them in sync.
- After `yadm push`, run `git pull --rebase` to keep them in sync.
- When git and yadm diverge on the same remote, reconcile with `--rebase` (`git pull --rebase` / `yadm pull --rebase`).

## Sparse checkout and exclusions

- Do not track this file with yadm — it is only relevant in the cloned repo, not in `~`.
- It is excluded from yadm's sparse checkout via `~/.local/share/yadm/repo.git/info/sparse-checkout`.
- When excluding a new file from yadm's home directory, update both `~/.local/share/yadm/repo.git/info/sparse-checkout` and `.config/yadm/bootstrap` — the bootstrap overwrites sparse-checkout on a fresh clone.

### Files to never track

- `~/.claude.json` — local runtime state, not settings.
- `~/.viminfo`, `~/.zsh_history` — runtime/history files.
- `~/.ssh/*` except `~/.ssh/config` — keys and known_hosts are machine-specific secrets.
