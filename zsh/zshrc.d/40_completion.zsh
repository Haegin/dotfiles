# Load completions - only regenerate compdump if older than 24 hours
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Prevent bento's zshrc from running a second compinit (autoload does not override this)
compinit() { return 0 }
