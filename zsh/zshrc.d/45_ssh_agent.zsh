# Skip SSH agent setup when in SSH session to preserve SSH agent forwarding
if [[ -z "$SSH_CONNECTION" ]]; then
  eval $(ssh-agent) &> /dev/null
  ssh-add &> /dev/null
fi
