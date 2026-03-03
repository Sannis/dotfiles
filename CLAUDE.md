## Dotfiles

- This folder is a cloned copy of the dotfiles repo (`github.com:Sannis/dotfiles.git`).
- yadm tracks the same repo with `$HOME` as the work tree.
- Use `yadm` for files under `~`; use `git` for files in this cloned repo.
- After committing files in this cloned repo via `git`, push with `git push` — do not rely on `yadm push`, as they are separate operations that can cause divergence.
- Do not track this file with yadm — it is only relevant in the cloned repo, not in `~`.
- It is excluded from yadm's sparse checkout via `~/.local/share/yadm/repo.git/info/sparse-checkout`.
