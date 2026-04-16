# Skip SSH agent setup when in SSH session to preserve SSH agent forwarding
if [[ -n "$SSH_CONNECTION" ]]; then
  # Set in ~/.ssh/rc based on the forwarded connection
  export SSH_AUTH_SOCK=$HOME/.ssh/auth_sock
else
  eval $(ssh-agent) &> /dev/null
  ssh-add &> /dev/null
fi
