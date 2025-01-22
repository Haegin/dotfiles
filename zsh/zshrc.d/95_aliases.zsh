function trace() { eval "set -x; $@" }

alias l='ls --time-style=+%Y%m%d.%H%M -gG'
alias ll='ls -l'
alias la='ls -al'
alias lh='ls -lh'
alias lt='ls -lt'
alias lah='ls -hal'
alias lrt='ls -lrt'
alias lat='ls -lat'
alias lart='ls -lart'

export LS_REPLACEMENT="eza"

if (( ${+commands[$LS_REPLACEMENT]} )); then
  alias ls="$LS_REPLACEMENT"
  alias lg="ls -la --git"
  alias tree="ls -T"
  alias lt="ls -l --sort newest"
  alias lrt="ls -lr --sort newest"
  alias lat="ll --sort newest"
  alias lart="lat -r"
fi

# Better programs if they're installed
if (( ${+commands[dfc]} )); then
  alias df='dfc'
fi
if (( ${+commands[htop]} )); then
  alias top='htop'
fi
if (( ${+commands[bat]} )); then
  alias cat="bat"
  export BAT_THEME=gruvbox-dark
fi

# Git spelling mistakes and shortcuts
if (( ${+commands[hub]} )); then
  git () {
    if [ "pr" = "$1" ]; then
      hub pull-request
    else
      hub "$@"
    fi
  }
fi
alias it=git
alias ggit=git
alias gap='git add -p'
alias gs='git status -s'

# Neovim and editor aliases
alias nv=nvim
alias vim=nvim
function e() { $EDITOR "$@" }

# Global aliases
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
if (( ${+commands[rg]} )); then
  alias -g G='| rg'
fi
alias -g L='| less'

alias \#='tmux attach'
alias a='tmux attach'

alias be='bundle exec'

alias agenda='gcalcli --default-calendar $(git config user.email) agenda --details length --details description'
alias week='gcalcli --default-calendar $(git config user.email) calw'

if (( ! ${+commands[pbcopy]} )); then
  alias pbcopy="xclip -selection clipboard"
  alias pbpaste="xclip -selection clippboard -o"
fi

# Commented until I can get tab completion based on .ssh/config working with kitty
#/* if [ $TERM = "xterm-kitty" ]; then */
#/*   alias ssh="kitty +kitten ssh" */
#/* fi */

function zettle {
  pushd ~/dev/haegin/zettlekasten
  nvim $1.md
  popd
}

alias cssh="tmux-xpanes --ssh -ss"
alias tf=terraform

alias -g rpsec=rspec

if (( ${+command[aichat]} )); then
  alias ai=aichat
fi
