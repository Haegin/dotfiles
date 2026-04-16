if [ "$USER" = "bento" ]; then
  command -v mise &>/dev/null && mise deactivate

  # Fix SSH agent forwarding in tmux
  if [ -n "$SSH_AUTH_SOCK" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/auth_sock" ]; then
    ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/auth_sock"
    export SSH_AUTH_SOCK="$HOME/.ssh/auth_sock"
  fi
fi
