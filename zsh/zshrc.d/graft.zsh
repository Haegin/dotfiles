#!/usr/bin/env zsh

# Graft shell integration for zsh
#
# Installation:
# 1. Source this file in your ~/.zshrc:
#    source /path/to/graft.zsh
# 2. Make sure the graft binary is in your PATH
# 3. Restart your shell or run: source ~/.zshrc
#
# Features:
# - Automatic directory switching after graft commands
# - Tab completion for:
#   - graft cd/edit/rm/prune: completes with branch names
#   - graft new: completes project paths from $CARROT_DIR (uses fd if available, find as fallback)
#   - graft alias: completes alias names and project paths

graft() {
    # Set marker to indicate shell integration is active
    export GRAFT_SHELL_INTEGRATION=1

    # Run the actual graft binary
    command graft "$@"
    local exit_code=$?

    # Get the command file path from graft itself
    local command_file="$(command graft statefile 2>/dev/null)"
    if [[ "$DEBUG" == "1" ]]; then
        echo "Checking for command file at: $command_file" >&2
    fi
    if [[ -n "$command_file" && -f "$command_file" && -s "$command_file" ]]; then
        # Execute the commands from the file
        source "$command_file"
    fi

    return $exit_code
}

# Zsh completion for graft
_graft() {
    local context state state_descr line
    typeset -A opt_args

    _arguments -C \
        '(-v --verbose)'{-v,--verbose}'[Enable verbose debug logging]' \
        '1: :_graft_commands' \
        '*:: :->args' && return 0

    case $state in
        args)
            case $words[1] in
                cd|edit|rm|prune)
                    _graft_branch_names
                    ;;
                new)
                    if [[ $CURRENT -eq 2 ]]; then
                        _message "branch name"
                    else
                        # Complete project paths for argument 3 and beyond (workspace support)
                        _graft_project_paths
                    fi
                    ;;
                alias)
                    case $CURRENT in
                        2)
                            _graft_aliases
                            ;;
                        3)
                            _graft_project_paths
                            ;;
                    esac
                    ;;
            esac
            ;;
    esac
}

_graft_commands() {
    local commands; commands=(
        'new:Create a new worktree with a new branch'
        'cd:Switch to the current project in the given worktree'
        'edit:Open Cursor in the project directory of the given worktree'
        'alias:Manage project path aliases'
        'ls:List worktrees with names and project paths'
        'rm:Remove the worktree for the given branch'
        'prune:Remove the worktree for the given branch (alias for rm)'
    )
    _describe 'commands' commands
}

_graft_branch_names() {
    local branch_names
    # Get branch names from graft ls output, skipping the header lines
    branch_names=(${(f)"$(command graft ls 2>/dev/null | tail -n +3 | awk '{print $1}')"})
    _describe 'branch names' branch_names
}

_graft_aliases() {
    local aliases
    # Get alias names from graft alias output, skipping the header lines
    aliases=(${(f)"$(command graft alias 2>/dev/null | tail -n +3 | awk '{print $1}')"})
    _describe 'aliases' aliases
}

_graft_project_paths() {
    local project_paths
    if [[ -n "$CARROT_DIR" && -d "$CARROT_DIR" ]]; then
        # Get directories from CARROT_DIR, excluding hidden directories
        if command -v fd >/dev/null 2>&1; then
            # Use fd if available (faster and more intuitive)
            project_paths=(${(f)"$(fd --type d --max-depth 3 --exclude '.*' --base-directory "$CARROT_DIR" --strip-cwd-prefix . 2>/dev/null | sort)"})
        else
            # Fallback to find
            project_paths=(${(f)"$(find "$CARROT_DIR" -maxdepth 3 -type d -not -path '*/.*' -not -path "$CARROT_DIR" | sed "s|^$CARROT_DIR/||" | sort)"})
        fi
        _describe 'project paths' project_paths
    else
        _message "project path (CARROT_DIR not set)"
    fi
}

if [[ -z ${_comps[graft]} ]]; then
    compdef _graft graft
fi
