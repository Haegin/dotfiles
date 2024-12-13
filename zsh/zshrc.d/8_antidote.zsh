if [ -f /opt/homebrew/opt/antidote/share/antidote/antidote.zsh ]; then
  source /opt/homebrew/opt/antidote/share/antidote/antidote.zsh
elif [ -d ~/.antidote ]; then
  source ~/.antidote/antidote.zsh
else
  git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
  source ~/.antidote/antidote.zsh
fi

antidote load ~/.zsh/plugins
