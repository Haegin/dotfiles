bindkey -e

autoload -U compinit
compinit

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
export EDITOR="nvim"
