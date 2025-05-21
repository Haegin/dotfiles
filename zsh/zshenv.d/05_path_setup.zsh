if [ -x /usr/libexec/path_helper ]; then
  PATH=""
  eval $(/usr/libexec/path_helper -s)
  export PATH
fi
