function load_antidote() {
  local plugins_file="${ZDOTDIR:-$HOME/.zsh}/plugins"
  local static_file="${ZDOTDIR:-$HOME/.zsh}/plugins.zsh"

  # Regenerate static file if plugins list changed or doesn't exist
  if [[ ! -f "$static_file" || "$plugins_file" -nt "$static_file" ]]; then
    if [[ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]]; then
      source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
    elif [[ -d ~/.antidote ]]; then
      source ~/.antidote/antidote.zsh
    else
      echo "antidote not found - run bin/setup to install" >&2
      return 1
    fi
    antidote bundle < "$plugins_file" > "$static_file"
  fi

  source "$static_file"
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
