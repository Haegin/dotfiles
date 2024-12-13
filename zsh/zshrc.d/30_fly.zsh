if [ -d "$HOME/.fly" ]; then
  export FLYCTL_INSTALL="$HOME/.fly"
  path=($FLYCTL_INSTALL/bin $path)
  export PATH
fi
