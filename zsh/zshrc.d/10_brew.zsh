if [ -d /opt/homebrew ]; then
  path=("/opt/homebrew/bin" $path)
  export PATH
  eval $(brew shellenv)
fi
