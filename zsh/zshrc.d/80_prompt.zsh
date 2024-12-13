if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
  export STARSHIP_LOG=error
fi
