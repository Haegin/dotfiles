# Base 16 colour schemes {{{
BASE16_SHELL=$HOME/.config/base16-shell/

if [ ! -d $BASE16_SHELL ]; then
  git clone https://github.com/chriskempson/base16-shell $BASE16_SHELL
fi

[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
# }}}
