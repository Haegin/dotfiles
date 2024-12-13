if [ "$USER" = "bento" ] || [ -d "/Applications/Okta Verify.app" ]; then
  echo "Instacart machine detected - loading Instacart configuration 🥕"

  export INSTACART_SUPPRESS_NVM=true
  export INSTACART_SUPPRESS_PYENV=true
  export INSTACART_SUPPRESS_SETUP_COMPLETION=true


  ### BEGIN--Instacart Shell Settings. (Updated: Mon 25 Nov 2024 13:22:23 EST. [Script Version 1.3.27])
  # This Line Added Automatically by Instacart Setup Script
  # The sourced file contains all of the instacart utilities and shell settings
  # To remove this functionality, leave the block, and enter "NO-TOUCH" in the BEGIN line, and comment the line below:
  source $HOME/.instacart_shell_profile
  ### END--Instacart Shell Settings.

  alias terraform=~/dev/instacart/tf-instacart/isc-terraform

  alias cdc="cd $CARROT_DIR"
fi