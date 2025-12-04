if [ "$USER" = "bento" ] || [ -d "/Applications/Okta Verify.app" ]; then
  export INSTACART_SUPPRESS_NVM=true
  export INSTACART_SUPPRESS_PYENV=true
  export INSTACART_SUPPRESS_SETUP_COMPLETION=true


  ### BEGIN--Instacart Shell Settings. (Updated: Mon 25 Nov 2024 13:22:23 EST. [Script Version 1.3.27])
  # This Line Added Automatically by Instacart Setup Script
  # The sourced file contains all of the instacart utilities and shell settings
  # To remove this functionality, leave the block, and enter "NO-TOUCH" in the BEGIN line, and comment the line below:
  [ -f $HOME/.instacart_shell_profile ] && source $HOME/.instacart_shell_profile
  ### END--Instacart Shell Settings.

  alias terraform=~/dev/instacart/tf-instacart/isc-terraform

  alias cdc="cd $CARROT_DIR"

  # NVM - lazy loaded for faster shell startup
  export NVM_DIR="$HOME/.nvm"

  # Create wrapper functions that load NVM on first use
  nvm() {
    unfunction nvm node npm npx 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
  }

  node() {
    unfunction nvm node npm npx 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    node "$@"
  }

  npm() {
    unfunction nvm node npm npx 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    npm "$@"
  }

  npx() {
    unfunction nvm node npm npx 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    npx "$@"
  }
fi

export FZF_DEFAULT_COMMAND='fd -H --type f --exclude ".git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export TZ=/usr/share/zoneinfo/America/Toronto

# Gemini CLI
export GOOGLE_CLOUD_PROJECT=instacart-gemini-cli
