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

  # Add default node version to PATH immediately (so scripts and neovim plugins work)
  # This finds the default version without loading nvm.sh
  _nvm_default_node() {
    local default_alias="$NVM_DIR/alias/default"
    if [[ -f "$default_alias" ]]; then
      local alias_value=$(< "$default_alias")
      # Handle explicit version numbers
      if [[ -d "$NVM_DIR/versions/node/v$alias_value" ]]; then
        echo "$NVM_DIR/versions/node/v$alias_value/bin"
        return
      # Handle "lts/*" - use latest even major version <= 22 (known active LTS)
      elif [[ "$alias_value" == lts/* ]]; then
        local best=""
        for dir in "$NVM_DIR/versions/node"/v*; do
          [[ -d "$dir" ]] || continue
          local ver="${dir##*/v}"
          local major="${ver%%.*}"
          # LTS versions are even-numbered and <= 22 (v24 not LTS until Oct 2025)
          [[ $((major % 2)) -eq 0 && $major -le 22 ]] && best="$dir/bin"
        done
        [[ -n "$best" ]] && echo "$best" && return
      fi
    fi
    # Fallback: use latest installed version
    ls -d "$NVM_DIR/versions/node"/v*/bin 2>/dev/null | sort -V | tail -1
  }

  _nvm_node_bin=$(_nvm_default_node)
  [[ -n "$_nvm_node_bin" ]] && export PATH="$_nvm_node_bin:$PATH"
  unset _nvm_node_bin

  # Only wrap nvm itself - node/npm/npx work via PATH now
  # Full nvm init is only needed for commands like `nvm use` or `nvm install`
  nvm() {
    unfunction nvm 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
  }
fi

export FZF_DEFAULT_COMMAND='fd -H --type f --exclude ".git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export TZ=/usr/share/zoneinfo/America/Toronto

# Gemini CLI
export GOOGLE_CLOUD_PROJECT=instacart-gemini-cli
