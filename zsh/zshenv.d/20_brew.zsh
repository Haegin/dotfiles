function setup_brew() {
  if [ -d /opt/homebrew ]; then
    path=("/opt/homebrew/bin" $path)
    export PATH

    eval $(brew shellenv)
  fi
}

if [[ "$-" == *i* ]]; then # Interactive shell
  if [[ "$0" == *zshrc.d* ]]; then # Sourced from zshrc.d
    setup_brew
  fi
else # Non-interactive shell
  if [[ "$0" == *zshenv.d* ]]; then # Sourced from zshenv.d
    setup_brew
  fi
fi
