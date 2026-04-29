function update_path() {
  . "$HOME/.cargo/env"

  path=($HOME/.local/bin $HOME/bin $path)

  [[ -d "$HOME/.local/share/mise/shims" ]] && path=($HOME/.local/share/mise/shims $path)
  [[ -d "$HOME/.local/share/nvim/mason/bin" ]] && path=($HOME/.local/share/nvim/mason/bin $path)

  export PATH
}

if [[ "$-" == *i* ]]; then # Interactive shell
  if [[ "$0" == *zshrc.d* ]]; then # Sourced from zshrc.d
    update_path
  fi
else # Non-interactive shell
  if [[ "$0" == *zshenv.d* ]]; then # Sourced from zshenv.d
    update_path
  fi
fi
