export ERL_AFLAGS="-kernel shell_history enabled"
export PURE_PROMPT_SYMBOL="|>"
export GOBIN="${HOME}/bin"

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
  export TERM=xterm-256color
fi
