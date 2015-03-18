#!/bin/sh

# http://noteskeeper.ru/621/

git remote prune origin

#git reflog expire --expire=1.day refs/heads/master
git fsck --unreachable
git gc
