function setup_path() {
  if [ -x /usr/libexec/path_helper ]; then
    PATH=""
    eval $(/usr/libexec/path_helper -s)
    export PATH
  fi
}

if [[ "$-" == *i* ]]; then # Interactive shell
  if [[ "$0" == *zshrc.d* ]]; then # Sourced from zshrc.d
    setup_path
  fi
else # Non-interactive shell
  if [[ "$0" == *zshenv.d* ]]; then # Sourced from zshenv.d
    setup_path
  fi
fi
