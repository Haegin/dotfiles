# Minimal ZSH config for AI agents (Claude Code, Cursor, etc.)
# Provides fast startup with conventional tool behavior

# Essential ZSH settings
setopt no_nomatch       # Don't error on failed globs
setopt nullglob         # Empty glob returns empty
setopt extended_glob    # Extended pattern matching

# Minimal PATH setup - just ensure standard tools are available
path=($HOME/.local/bin $HOME/bin $HOME/.cargo/bin $path)
export PATH

# Keep standard tool behavior - no fancy replacements
# cat = cat (not bat)
# ls = ls (not eza)
# This ensures predictable output for agents parsing command results

# Basic completion (fast, no fancy features)
autoload -Uz compinit
compinit -C  # Skip security check for speed

# No prompt customization needed for non-interactive agent use
# but set a simple one in case it's displayed
PROMPT='%~ $ '
