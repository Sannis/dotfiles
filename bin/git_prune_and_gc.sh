#!/bin/sh

# http://noteskeeper.ru/621/
# https://git-scm.com/docs/git-reflog
# http://stevelorek.com/how-to-shrink-a-git-repository.html

du -sh .

git remote prune origin
du -sh .

git reflog expire --expire-unreachable refs/heads/master
du -sh .

git fsck --unreachable
du -sh .

git gc --aggressive --prune=now
du -sh .

