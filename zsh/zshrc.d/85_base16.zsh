# Base 16 colour schemes - load if installed
if [[ -n "$PS1" && -s "$HOME/.config/base16-shell/profile_helper.sh" ]]; then
  eval "$("$HOME/.config/base16-shell/profile_helper.sh")"
fi
