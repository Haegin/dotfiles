#!/bin/zsh
setopt extendedglob

DOTDIR="${HOME}/.dotfiles"

cd "$DOTDIR"

# Set up the submodules now we're done so vim plugins are all working
echo "\nSetting up the git submodules."
git submodule init
git submodule update

# Only want to symlink the files, not the utility scripts
echo "Linking files into ${HOME} from ${DOTDIR}:"
for item in *~(bin|Brewfile); do
  if [ ! -e "${HOME}/.${item}" ]; then
    echo "- .${item}"
    ln -s "${DOTDIR}/${item}" "${HOME}/.${item}"
  fi
done

if [[ $(uname -s) = "Darwin" ]]; then
  echo "Installing Homebrew"
  command -v brew > /dev/null 2&>1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap Homebrew/bundle
  brew bundle
  [[ -e Brewfile.mac ]] && brew bundle --file=Brewfile.mac
else
  # [[ -e Brewfile.linux ]] && brew bundle --file=Brewfile.linux
fi

if [[ -x $(command -v zsh) ]]; then
  chsh -s $(command -v zsh)
fi

echo "\nMaking history"
mkdir -p ${ZVARDIR:-${HOME}/.var/zsh}

echo "\nFinished!"
