#! /usr/bin/env bash
# Installs configuration onto a system
# Usage: ./install.sh

set -euo pipefail

mkdir -p "${HOME}/.local/bin"

mac() {
  if ! command -v 'brew' &> /dev/null; then
    echo 'No brew - install it: https://brew.sh/'
    exit 1
  fi

  brew install stow
  bash update_crystalline_osx.sh
}

linux() {
  if command -v 'yay' &> /dev/null; then
    # Arch
    yay -S stow crystalline
  elif command -v 'apt' &> /dev/null; then
    # Debian based
    apt install stow
  elif command -v 'apk' &> /dev/null; then
    # Alpine
    apk add stow
  else
    echo 'No recognised package managers'
    exit 1
  fi
}

# Check for a stow install, installs if not present
check_stow_install() {
  if ! command -v 'stow' &> /dev/null; then
    echo "no stow install found, attempting to install"
    if [[ "$(uname -s)" -eq 'Darwin' ]]; then
      mac
    else
      linux
    fi
  fi
  return
}

function run_stow() {
  check_stow_install

  echo "running stow"
  # Stow everything except install script
  stow --target=${HOME} *[^.sh]

  defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false
}

[[ ! -d "${HOME}/.asdf" ]] && git clone https://github.com/asdf-vm/asdf.git "${HOME}/.env"

run_stow

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install ripgrep bottom
