#!/bin/zsh
setopt extendedglob

DOTDIR="${HOME}/.dotfiles"
SUBSUBMODULEDIR="${DOTDIR}/subsubmodules"

cd "$DOTDIR"

# Link the irssi solarized colour scheme
#ln -s ${DOTDIR}/irssi/irssi-colors-solarized/solarized-universal.theme ${HOME}/.irssi/.

# Set up the submodules now we're done so vim plugins are all working
echo "\nSetting up the git submodules - until this is complete vim stuff probably won't work as expected."
git submodule init
git submodule update

#echo "\nLinking subsubmodules inside other submodules"
#for item in ${SUBSUBMODULEDIR}/*; do
#  item=${item:t}
#  shortpath=${item//_/\/}
#  newpath="${DOTDIR}/${shortpath}"
#  newdir=${newpath:h}
#  if [ ! -e "${newdir}" ]; then
#    mkdir -p "${newdir}"
#  fi
#  if [ ! -e "${newpath}" ]; then
#    echo "- .${shortpath}"
#    ln -s "${SUBSUBMODULEDIR}/${item}" "${newpath}"
#  fi
#done

# Only want to symlink the files, not the utility scripts
echo "Linking files into ${HOME} from ${DOTDIR}:"
for item in *~(bin|subsubmodules|Brewfile); do
  if [ ! -e "${HOME}/.${item}" ]; then
    echo "- .${item}"
    ln -s "${DOTDIR}/${item}" "${HOME}/.${item}"
  fi
done

if [[ $OSTYPE -eq "Darwin"]]; then
  echo "Installing Homebrew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap Homebrew/bundle
  brew bundle
fi

echo "\nMaking history"
mkdir -p .var/zsh/
touch .var/zsh/history-$(hostname)

echo "\nFinished!"
