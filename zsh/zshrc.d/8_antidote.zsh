if [ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
elif [ -d ${ZDOTDIR:-~}/.antidote ]; then
  source ${ZDOTDIR:-~}/.antidote/antidote.zsh
else
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
  source ${ZDOTDIR:-~}/.antidote/antidote.zsh
fi

antidote load ~/.zsh/plugins
