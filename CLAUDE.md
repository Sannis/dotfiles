# Claude Instructions: Dotfiles

## Overview

- This folder is a cloned copy of the dotfiles repo.
- yadm tracks the same repo with `$HOME` as the work tree.

## Git and yadm workflow

- Use `yadm` for files under `~`; use `git` for files in this cloned repo.
- Run `yadm` from any directory — it uses its own `GIT_DIR`/`GIT_WORK_TREE` internally, so `cd ~` before yadm commands is never needed.
- When git and yadm diverge on the same remote, reconcile with `--rebase` (`git pull --rebase` / `yadm pull --rebase`).

## Syncing cloned repo changes to home

`git push` is not allowed without confirmation — intentionally kept out of global permissions since it would apply to all repos. `yadm push` is safe to run freely as it only ever pushes dotfiles.

When there are uncommitted changes in the cloned repo, use this workflow instead of `git push`:

1. Run `git diff --name-only` to get modified files.
2. Split files into two groups:
   - Repo-only (excluded from yadm sparse checkout, e.g. `CLAUDE.md`, `README.md`, `setup.sh`)
   - Dotfiles (tracked by yadm and checked out to `~`)
3. For repo-only files — `git commit` them locally, then ask the user before running `git push`.
4. For dotfiles — check if each is also dirty in yadm (`yadm status`).
5. If the same dotfile is modified in both — stop and highlight the conflict for the user to decide.
6. If no conflict — copy the file from the cloned repo to `~`.
7. Before `yadm pull --rebase`, check for unstaged yadm changes (`yadm status`). If a file shows as modified but both `yadm diff` and `yadm diff --cached` show no content change (metadata-only), restore it with `yadm checkout -- <file>` first.
8. Run `yadm add`, `yadm commit`, `yadm push`, then `git pull --rebase`.

## Sparse checkout and exclusions

- Do not track this file with yadm — it is only relevant in the cloned repo, not in `~`.
- It is excluded from yadm's sparse checkout via `~/.local/share/yadm/repo.git/info/sparse-checkout`.
- When excluding a new file from yadm's home directory, update both `~/.local/share/yadm/repo.git/info/sparse-checkout` and `.config/yadm/bootstrap` — the bootstrap overwrites sparse-checkout on a fresh clone.

### Files to never track

- `~/.claude.json` — local runtime state, not settings.
- `~/.viminfo`, `~/.zsh_history` — runtime/history files.
- `~/.ssh/*` except `~/.ssh/config` — keys and known_hosts are machine-specific secrets.
