# Skip GPG agent setup when in SSH session to preserve SSH agent forwarding
if [[ -z "$SSH_CONNECTION" ]] && command -v gpgconf &> /dev/null; then
  export GPG_TTY=$(tty)
  gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
