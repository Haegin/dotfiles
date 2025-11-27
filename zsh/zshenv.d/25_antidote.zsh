function load_antidote() {
  if [ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]; then
    source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
  elif [ -d ~/.antidote ]; then
    source ~/.antidote/antidote.zsh
  else
    git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
    source ~/.antidote/antidote.zsh
  fi

  antidote load ~/.zsh/plugins
}

if [[ "$-" == *i* ]]; then # Interactive shell
  if [[ "$0" == *zshrc.d* ]]; then # Sourced from zshrc.d
    load_antidote
  fi
else # Non-interactive shell
  if [[ "$0" == *zshenv.d* ]]; then # Sourced from zshenv.d
    load_antidote
  fi
fi
