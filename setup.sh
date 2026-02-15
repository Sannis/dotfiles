#!/bin/bash
set -e

REPO_URL="git@github.com:Sannis/dotfiles.git"

# Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install yadm if missing
if ! command -v yadm &>/dev/null; then
  echo "Installing yadm..."
  brew install yadm
fi

# Clone dotfiles
echo "Cloning dotfiles..."
yadm clone "$REPO_URL"

echo "Done! Dotfiles are now managed by yadm."
echo "Repo location: ~/.local/share/yadm/repo.git"
