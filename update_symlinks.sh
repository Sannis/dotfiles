#!/bin/bash
#==================================================================================
#          FILE:  update_symlinks.sh
#         USAGE:  ./update_symlinks.sh 
#   DESCRIPTION:  Create symlinks in ~ (/home/username)
#      ORIGINAL: https://github.com/kusnier/dotfiles/blob/master/update_symlinks.sh
#==================================================================================

set -o nounset # Treat unset variables as an error

function realpath() {
  # Get absolute path of the script (because of different readlink in macos)
  dir=`dirname $1`            # The directory where the script is 
  pushd "$dir" > /dev/null    # Go there
  callerpath=$PWD             # Record the absolute path
  popd > /dev/null            # Return to previous dir
  echo $callerpath
}

base=false
# ensure we're on the base of the dotfiles repo
dotfilespath="$(git rev-parse --show-toplevel)" || exit

for dotfile in ${dotfilespath}/home/* ; do
  echo $dotfile
  base=`basename $dotfile`
  rm -if ~/.$base
  ln -v -s $dotfile ~/.$base
done

