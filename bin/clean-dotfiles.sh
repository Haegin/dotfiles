#!/usr/bin/zsh
setopt extendedglob

DOTDIR="$HOME/.dotfiles"

cd "$DOTDIR"

# Only remove symlinks to file in this directory
echo "Removing linked files in ${HOME} from ${DOTDIR}:"
for item in *~bin; do
    echo "- .${item}"
    if [ -L "${HOME}/.${item}" ]; then
        unlink "${HOME}/.${item}"
    fi
done
echo "\nFinished!"
