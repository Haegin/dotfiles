#!/bin/zsh
setopt extendedglob

DOTDIR="${HOME}/.dotfiles"

cd "$DOTDIR"

# Set up the submodules now we're done so vim plugins are all working
echo "\nSetting up the git submodules - until this is complete vim stuff probably won't work as expected."
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

echo "Installing Homebrew"
if [[ ! -x $(which brew) ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew tap Homebrew/bundle
brew bundle
if [[ $(uname -s) = "Darwin" ]]; then
  [[ -e Brewfile.mac ]] && brew bundle --file=Brewfile.mac
else
  [[ -e Brewfile.linux ]] && brew bundle --file=Brewfile.linux
fi

echo "\nMaking history"
mkdir -p ${ZVARDIR:-${HOME}/.var/zsh}

echo "\nFinished!"
