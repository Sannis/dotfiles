## Dotfiles

- This folder is a cloned copy of the dotfiles repo (`github.com:Sannis/dotfiles.git`).
- yadm tracks the same repo with `$HOME` as the work tree.
- Use `yadm` for files under `~`; use `git` for files in this cloned repo.
- After committing files in this cloned repo via `git`, push with `git push` — do not rely on `yadm push`, as they are separate operations that can cause divergence.
- Do not track this file with yadm — it is only relevant in the cloned repo, not in `~`.
- It is excluded from yadm's sparse checkout via `~/.local/share/yadm/repo.git/info/sparse-checkout`.
- When git and yadm diverge on the same remote, reconcile with `--rebase` (`git pull --rebase` / `yadm pull --rebase`).
- When excluding a new file from yadm's home directory, update both `~/.local/share/yadm/repo.git/info/sparse-checkout` and `.config/yadm/bootstrap` — the bootstrap overwrites sparse-checkout on a fresh clone.

## Files to never track with yadm

- `~/.claude.json` — local runtime state, not settings.
- `~/.viminfo`, `~/.zsh_history` — runtime/history files.
- `~/.ssh/*` except `~/.ssh/config` — keys and known_hosts are machine-specific secrets.
