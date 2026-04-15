if [ "$USER" = "bento" ]; then
  command -v mise &>/dev/null && mise deactivate
fi
