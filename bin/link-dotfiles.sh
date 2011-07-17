#!/bin/zsh
setopt extendedglob

DOTDIR="$HOME/.dotfiles"

cd "$DOTDIR"

# Only want to symlink the files, not the utility scripts
echo "Linking files into ${HOME} from ${DOTDIR}:"
for item in *~bin; do
    echo "- .${item}"
    if [ ! -e "${HOME}/.${item}" ]; then
        ln -s "${DOTDIR}/${item}" "${HOME}/.${item}"
    fi
done
echo "\nFinished!"
