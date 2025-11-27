function setup_zvardir() {
  export ZVARDIR=~/.var/zsh
}

if [[ "$-" == *i* ]]; then # Interactive shell
  if [[ "$0" == *zshrc.d* ]]; then # Sourced from zshrc.d
    setup_zvardir
  fi
else # Non-interactive shell
  if [[ "$0" == *zshenv.d* ]]; then # Sourced from zshenv.d
    setup_zvardir
  fi
fi
