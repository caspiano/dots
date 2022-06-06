ZSHRC="${HOME}/.zshrc"
ZGEN_SOURCE="$HOME/.local/share/zgenom"
ZGEN_RESET_ON_CHANGE="${ZSHRC}"

# Download zgen
[[ -f "$ZGEN_SOURCE/zgenom.zsh" ]] ||
    git clone --depth 1 -- "https://github.com/jandamm/zgenom" "$ZGEN_SOURCE"

# Plugin configuration (in some cases, required before the plugin is loaded)
###############################################################################

# Minimal magic theme
ZSH_THEME="afowler"

# Command corrections
ENABLE_CORRECTION="true"

# Disable marking untracked files under git
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Some plugins are platform dependent
PLATFORM="$(uname -s)"

# Emacs-style bindings because they are overidden somehow.
# For some reason, I find it nicer than vim in this context.
bindkey -e

###############################################################################

# Case insensitive tab completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

###############################################################################

source "$ZGEN_SOURCE/zgenom.zsh"

# Updates every 7 days, this does not increase the startup time.
zgenom autoupdate

# Compile plugins if the init script doesn't exist
if ! zgenom saved; then
  # Balm for completion issues with omz plugins
  zgenom compdef

  # Required for a few other plugins
  zgenom load mafredri/zsh-async

  # Theme
  zgenom load zshzoo/omz-themes-standalone

  # omz plugins
  ##############################################################################

  zgenom ohmyzsh lib/correction.zsh        # Correction
  zgenom ohmyzsh plugins/autojump          # Memorise visited directories
  zgenom ohmyzsh plugins/dircycle          # Numerically reference previous dirs
  zgenom ohmyzsh plugins/docker
  zgenom ohmyzsh plugins/docker-compose
  zgenom ohmyzsh plugins/git
  zgenom ohmyzsh plugins/git-auto-fetch
  zgenom ohmyzsh plugins/git-escape-magic
  zgenom ohmyzsh plugins/bgnotify          # Cross-platform notifications

  # Platform specific plugins
  ##############################################################################

  # MacOS
  [[ "$PLATFORM" -eq "Darwin" ]] && (
    zgenom ohmyzsh plugins/brew
    zgenom ohmyzsh plugins/macos
  )

  # Arch
  [[ -f "/etc/arch-release" ]] && zgenom ohmyzsh plugins/archlinux

  # Tools
  ##############################################################################

  # Fuzzy finding QoL enhancements
  zgenom load unixorn/fzf-zsh-plugin
  zgenom load seletskiy/zsh-fuzzy-search-and-edit # Needs "mafredi/zsh-async"
  zgenom load Aloxaf/fzf-tab

  # Suggestions like fish shell
  zgenom load zsh-users/zsh-autosuggestions

  # Completions
  zgenom load zsh-users/zsh-completions src

  # Terminal syntax highlighting (has to be before `zshr-history-substring-search`)
  zgenom load zdharma-continuum/fast-syntax-highlighting

  # Glorious fish shell feature (use arrows for completion)
  zgenom load zsh-users/zsh-history-substring-search

  # (MUST BE LAST IN THIS BLOCK) Generate the init script from plugins above
  zgenom save
fi

# User configuration
###############################################################################

setopt aliases
setopt extendedglob

# Locales

export TZ='Australia/Sydney'
export LANG=en_AU.UTF-8
export LC_MESSAGES=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8

# SSH

export SSH_KEY_PATH="${HOME}/.ssh/rsa_id"

# GPG

export GPG_TTY=$(tty)

# SSH

export SSH_KEY_PATH="${HOME}/.ssh/rsa_id"

# Tmux

export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"

# Config

export EDITOR="/usr/local/bin/nvim"

alias zshrc="vim ${ZSHRC} && source ${ZSHRC}"
alias vimrc="vim ${HOME}/.vimrc"

# Key bindings
###############################################################################

bindkey '^F' fuzzy-search-and-edit
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# History

setopt hist_ignore_all_dups
setopt hist_ignore_space

export HISTSIZE=100000
export SAVEHIST=100000

# Aliases
###############################################################################

alias py='python3'
alias pip='pip3'

alias top='btm --color gruvbox'

alias c='clear'

alias cs='crystal spec'
alias cf='crystal tool format'
alias cfa='crystal tool format && ameba'
alias sbnc='shards build --error-trace --no-codegen'
alias sup='shards update'
alias gts='git tag v$(shards version)'

alias code='codium'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias vo='nvim'
alias vu='nvim'

alias pwdc='echo "$(pwd)" | tee "$(tty)" | pbcopy'

function git_default_branch() (
  (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') 2>/dev/null
)

alias cz='git cz'
alias git-branch-clean='git fetch && git co $(git_default_branch) && git branch -vv | rg gone | cut -f3 -d" " | xargs -- git branch -D'
alias gpat='git push --tags'
alias gs='git s'
alias g='git'
alias gap='git add --patch'
alias gdc='git dc'

alias ldo='lazydocker'
alias d='docker'
alias dc='docker-compose'
alias docker-clean='docker-container-clean; docker-volume-clean; yes | docker system prune | tail -1'
alias docker-container-clean="docker container ls --no-trunc --format '{{.ID}}' | xargs docker container rm -v 2> /dev/null"
alias docker-volume-clean='docker volume ls -q | xargs docker volume rm 2> /dev/null'

alias cx='chmod +x'
alias less='less -R'

alias sl='ls'
alias qq='exit'
alias :q='exit'
alias t='tmux'

# Notes

alias brain='find ~/brain -type f | rg -v "(/\.|:$|^$|.git|node_modules|/$)" | sed -e "s|$(pwd)/||g" | fzf | xargs nvim'
alias s=scratch
alias scratch="nvim ${HOME}/brain/inbox.md"
alias chinese="nvim ${HOME}/brain/learning/chinese/中文.md"
alias work="nvim ${HOME}/brain/work/placeos/inbox.md"

# Platform specific aliases

function mac_aliases() {
  alias l='ls -G1h'
  alias ll='ls -lGh'
  alias la='ls -lAh'
  alias ls='ls -Gh'
  alias lsa='ls -lah'
  alias xdg-open='open'
}

function linux_aliases() {
  alias ll='ls -lh --color=auto'
  alias ls='ls -h --color=auto'
  alias l='ls -h --color=auto'
  alias open='xdg-open'
}

# Language configurations
###############################################################################

export CC="clang"

export JAVA_11_HOME=$(/usr/libexec/java_home -v11)

export GOPATH="$HOME/.go"

export CRYSTAL_WORKERS=4

export SHARDS_OPTS="--ignore-crystal-version"

export POETRY_HOME="$HOME/.poetry"

# Path
###############################################################################

path+=(
  "$DENO_INSTALL/bin"
  "$HOME/.cargo/bin"
  "$HOME/.local/bin"
  "$HOME/.scripts"
  "$HOME/.shards/bin"
  "$POETRY_HOME/bin"
  "/usr/local/opt/.fzf/bin"
  $(yarn global bin)
)

path+="/usr/local/opt/llvm@13/bin"

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

if [[ "$PLATFORM" -eq "Darwin" ]]
then
  # OpenSSL
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig"
  export CPPFlAGS="-L/usr/local/opt/openssl/include"
  export LDFLAGS="-L/usr/local/opt/openssl/lib"

  # LLVM
  export LLVM_CONFIG=/usr/local/opt/llvm/bin/llvm-config

  # Stop brew updating every fucking time
  export HOMEBREW_NO_AUTO_UPDATE=1

  # Create mac only aliases
  mac_aliases
  # Append mac only paths
  path+=mac_paths

  # Mac beeps
  function negativebeep() { (say --voice Mei-Jia "哎呀") }
  function positivebeep() { (say --voice Mei-Jia "完了") }
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

# This is CRAZY
path+="."

export PATH

# Functions
###############################################################################

function y() {
    previous=$?;
    if [ $previous -eq 0 ]; then
        positivebeep
    else
        negativebeep
    fi
}

# PlaceOS related
###############################################################################

export SG_ENV="development"

# Environments
###############################################################################

# asdf
[ -d $HOME/.asdf ] && . $HOME/.asdf/asdf.sh
# Rust
[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env
# Nix
[ -f $HOME/.nix-profile/etc/profile.d/nix.sh ] && . $HOME/.nix-profile/etc/profile.d/nix.sh
# ghcup
[ -f $HOME/.ghcup/env ] && . $HOME/.ghcup/env
# Python Poetry
[ -f $POETRY_HOME/env ] && . $POETRY_HOME/env
