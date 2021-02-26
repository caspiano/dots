# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="afowler"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files under git
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Insecure completions
ZSH_DISABLE_COMPFIX="true"

PLATTY=$(uname -s)

plugins=(
  autojump
  cargo
  compleat
  dircycle
  docker
  docker-compose
  fzf
  git
  nmap
  npm
)

if [[ "$PLATTY" -eq "Darwin" ]]
then
  plugins+=(
    brew
    osx
  )
else
  plugins+=(
    archlinux
  )
fi

# User configuration
# !!!!!!!!!!!!!!!!!!

# Locales

export TZ='Australia/Sydney'
export LANG=en_AU.UTF-8
export LC_MESSAGES=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8

# SSH

export SSH_KEY_PATH="~/.ssh/rsa_id"

source $ZSH/oh-my-zsh.sh

# User configuration
# !!!!!!!!!!!!!!!!!!

setopt aliases
setopt extendedglob

# Locales

export LANG=en_AU.UTF-8
export LC_MESSAGES=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8

# SSH

export SSH_KEY_PATH="~/.ssh/rsa_id"

# Tmux

export TMUX_PLUGIN_MANAGER_PATH=$HOME/.tmux/plugins/

# Config

export EDITOR="/usr/local/bin/nvim"

alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias vimrc="vim ~/.vimrc"

# Aliases
#################################

alias py='python3'
alias pip='pip3'
alias ra='ranger'

alias fhs='fast-http-server'

alias c='clear'

alias cf='crystal tool format'
alias cfa='crystal tool format && ameba'

alias messenger='fb-messenger-cli'
alias mess='fb-messenger-cli'
alias tv='terminal_velocity'

alias turtle-template='vim < $HOME/.templates/TurtleTemplate.hs'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias vo='nvim'
alias vu='nvim'

alias pwdc='echo "$(pwd)" | tee "$(tty)" | pbcopy'

alias we='watch-exec'

alias cz='git cz'
alias g='git'
alias gap='git add --patch'
alias gdc='git dc'
alias git-branch-clean='git fetch && git co master && git branch -vv | rg gone | cut -f3 -d" " | xargs -- git branch -D'
alias gpat='git push --tags'
alias gs='git s'

alias gts='git tag v$(shards version)'

alias ldo='lazydocker'
alias d='docker'
alias dc='docker-compose'
alias dicker='docker'
alias dokcer='docker'
alias docker-clean='docker-container-clean; docker-volume-clean; yes | docker system prune | tail -1'
alias docker-container-clean='docker container ls --no-trunc --format '{{.ID}}' | xargs docker container rm -v 2> /dev/null'
alias docker-volume-clean='docker volume ls -q | xargs docker volume rm 2> /dev/null'

alias cx='chmod +x'
alias less='less -R'
alias lsd='lsd -l'
alias sharts='shards'

alias rg='rg --color=always'

alias cp='cp -R'
alias m='mv'
alias mkdir='mkdir -p'
alias sl='ls'
alias qq='exit'
alias :q='exit'
alias t='tmux'

alias s=scratch
alias scratch='nvim ~/.scratch.md'
alias chinese='nvim ~/.chinese.md'
alias work='nvim ~/.work.md'
alias pers='nvim ~/.personal.md'
alias tasks='taskell ~/.taskell.md'

alias dev_box='ssh -L 127.0.0.1:8080:localhost:8080 dev_box'

function mac_aliases() {
  alias l='ls -G1h'
  alias ll='ls -lGh'
  alias la='ls -lAh'
  alias ls='ls -Gh'
  alias lsa='ls -lah'
}

function linux_aliases() {
  alias ll='ls -lh --color=auto'
  alias ls='ls -h --color=auto'
  alias l='ls -h --color=auto'
  alias open='xdg-open'
}

# Path
################################################

path+=(
  "$HOME/.shards/bin"
  "$HOME/.scripts"
  "$HOME/.rbenv/shims"
  "$HOME/.shards/bin"
  "$HOME/.cargo/bin"
  "/usr/local/opt/.fzf/bin"
  "$HOME/.local/bin"
  $(yarn global bin)
)

path+="/usr/local/opt/llvm@8/bin"

function mac_paths() {
  return (
    "/usr/local/opt/openssl/bin"
    "/usr/local/opt/llvm/bin"
    "/usr/local/sbin"
  )
}

function linux_paths() {
  return (
    "$HOME/.screenlayout"
  )
}


if [[ "$PLATTY" -eq "Darwin" ]]
then
  # OpenSSL
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig"
  export CPPFlAGS="-L/usr/local/opt/openssl/include"
  export LDFLAGS="-L/usr/local/opt/openssl/lib"

  # Stop brew updating every fucking time
  export HOMEBREW_NO_AUTO_UPDATE=1

  # Create mac only aliases
  mac_aliases
  # Append mac only paths
  path+=mac_paths

  # Mac beeps
  function negativebeep() {
      (say "failed")
  }

  function positivebeep() {
      (say "done")
  }
else
  # Create linux only aliases
  linux_aliases
  # Append linux only paths
  path+=linux_paths

  # Linux beeps
  function negativebeep() {
      ( speaker-test -t sine -f 800 >/dev/null )& pid=$!
      sleep 0.5s > /dev/null;
      kill -9 $pid >/dev/null
  }

  function positivebeep() {
      ( speaker-test -t sine -f 1000 >/dev/null )& pid=$!
      sleep 0.15s > /dev/null;
      kill -9 $pid >/dev/null
      sleep 0.15s > /dev/null;
      ( speaker-test -t sine -f 1000 >/dev/null )& pid=$!
      sleep 0.15s > /dev/null;
      kill -9 $pid >/dev/null
  }
fi

# Crystal Env
if [ -d "$HOME/.crenv" ]; then
    path+="$HOME/.crenv/bin"
    eval "$(crenv init -)"
fi

# This is CRAZY
path+="."

export PATH

# Functions
################################################

function y() {
    previous=$?;
    if [ $previous -eq 0 ]; then
        positivebeep
    else
        negativebeep
    fi
}

# PlaceOS related
################################################
export SG_ENV="development"
################################################

# Language configurations
################################################

export CC="clang"

export GOPATH="$HOME/.go"

export CRYSTAL_WORKERS=4

# Environments
################################################

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
# Ruby
[ -d $HOME/.rbenv ] && eval "$(rbenv init -)"
# Rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env
# Nix
[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && . $HOME/.nix-profile/etc/profile.d/nix.sh
# ghcup
[ -f $HOME/.ghcup/env ] && . $HOME/.ghcup/env
# Python Poetry
[ -f $HOME/.poetry/env ] && . $HOME/.poetry/env 
# broot
[ -f $HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br ] && . $HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br 
