if command -v gpgconf &> /dev/null; then
  export GPG_TTY=$(tty)
  gpgconf --launch gpg-agent
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi
