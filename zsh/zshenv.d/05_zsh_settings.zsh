function setup_zsh_settings() {
  bindkey -e

  setopt dvorak
  setopt noclobber
  setopt autopushd pushdminus pushdsilent pushdtohome

  setopt braceccl

  setopt notify
  setopt no_bgnice
  setopt nohup
  setopt checkjobs

  setopt bsd_echo

  setopt nullglob
  setopt extended_glob
  setopt no_nomatch

  setopt no_beep

  setopt c_bases

  export WORDCHARS="${WORDCHARS//\/}"
}

if [[ "$-" == *i* ]]; then # Interactive shell
  if [[ "$0" == *zshrc.d* ]]; then # Sourced from zshrc.d
    setup_zsh_settings
  fi
else # Non-interactive shell
  if [[ "$0" == *zshenv.d* ]]; then # Sourced from zshenv.d
    setup_zsh_settings
  fi
fi
