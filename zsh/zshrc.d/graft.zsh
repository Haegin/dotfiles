# graft shell integration (auto-generated)
# Deferred to precmd to ensure PATH is fully initialized before calling graft.
# This is necessary when graft is installed via a tool (e.g. a version manager)
# that adds itself to PATH later in the shell startup sequence.
_graft_init() {
  if command -v graft &>/dev/null; then
    eval "$(command graft integrate-shell zsh)"
    # Register completion immediately — we are already in precmd so compinit
    # has run. This avoids double-deferral from the inner _graft_register_completion
    # hook, ensuring completions are available from the very first prompt.
    if (( $+functions[compdef] )); then
      compdef _graft graft
    fi
  fi
  add-zsh-hook -d precmd _graft_init
  unfunction _graft_init
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _graft_init
