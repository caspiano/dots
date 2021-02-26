#! /usr/bin/env bash
# Installs configuration onto a system
# Usage: ./install.sh

set -euo pipefail

function run_stow() {
  check_stow_install

  echo "running stow"
  # Stow everything except install script
  stow --target=${HOME} *[^.sh]
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

mac() {
  if ! command -v 'brew' &> /dev/null; then
      echo 'No brew - install it: https://brew.sh/'
      exit 1
  fi
  brew install stow
}

linux() {
  if command -v 'yay' &> /dev/null; then
    # Arch
    yay -S stow
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

[[ -f ${HOME}/.asdf ]] && git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
run_stow
yes | KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
