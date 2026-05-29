#!/usr/bin/env racket
#lang racket

(require racket/file
         racket/path
         racket/string
         racket/port)

;; --- helpers ---

(define (echo msg)
  (displayln msg))

(define (file->lines path)
  (if (file-exists? path)
      (string-split (file->string path) "\n")
      '()))

(define (lines->file path lines)
  (display-to-file (string-join lines "\n") path #:exists 'replace))

(define (grep-line pattern lines)
  (findf (lambda (line) (regexp-match? (regexp pattern) line)) lines))

;; --- main ---

(define SHELLRC_D (build-path (getenv "HOME") ".shellrc.d"))

(define (main)
  (unless (directory-exists? SHELLRC_D)
    (echo "No ~/.shellrc.d directory found - not a bento box?")
    (exit 1))

  (echo "Optimizing bento shell startup...")

  ;; Remove NVM eager loading
  (echo "- Removing NVM eager loading...")
  (for ([file '("040_nvm.sh" "040_nvm_cd.zsh" "041_nvm_cd.bash")])
    (define path (build-path SHELLRC_D file))
    (when (file-exists? path)
      (delete-file path)))

  ;; Lazy-load GitHub Copilot CLI
  (define copilot-path (build-path SHELLRC_D "043_copilot.sh"))
  (when (file-exists? copilot-path)
    (echo "- Lazy-loading GitHub Copilot CLI...")
    (display-to-file #<<EOF
# Lazy-load GitHub Copilot CLI aliases
_load_copilot() {
  unfunction _load_copilot ghcs 2>/dev/null
  unalias '??' 'git?' 'gh?' 2>/dev/null
  eval "$(github-copilot-cli alias -- zsh)"
}
ghcs() { _load_copilot; ghcs "$@"; }
alias '??'='_load_copilot && ??'
alias 'git?'='_load_copilot && git?'
alias 'gh?'='_load_copilot && gh?'
EOF
                   copilot-path
                   #:exists 'replace))

  ;; Lazy-load pyenv
  (define pyenv-path (build-path SHELLRC_D "050_pyenv.sh"))
  (when (file-exists? pyenv-path)
    (echo "- Lazy-loading pyenv...")
    (define original-lines (file->lines pyenv-path))
    (define pythonpath-line (grep-line "^export PYTHONPATH=" original-lines))
    (define new-content
      (string-append
       "# shellcheck shell=bash\n"
       "export PYENV_ROOT=\"$HOME/.pyenv\"\n"
       "export PATH=\"$PYENV_ROOT/bin:$PATH\"\n"
       (if pythonpath-line
           (string-append pythonpath-line "\n")
           "")
       #<<EOF

# Lazy-load pyenv - only initialize on first use
_load_pyenv() {
  unfunction _load_pyenv pyenv python python3 pip pip3 2>/dev/null
  eval "$(command pyenv init --path)"
  eval "$(command pyenv init -)"
  eval "$(command pyenv virtualenv-init -)"
}
pyenv() { _load_pyenv; command pyenv "$@"; }
python() { _load_pyenv; command python "$@"; }
python3() { _load_pyenv; command python3 "$@"; }
pip() { _load_pyenv; command pip "$@"; }
pip3() { _load_pyenv; command pip3 "$@"; }
EOF
       ))
    (display-to-file new-content pyenv-path #:exists 'replace))

  ;; Cache devbox shellenv
  (define devbox-path (build-path SHELLRC_D "004_devbox.sh"))
  (when (file-exists? devbox-path)
    (echo "- Caching devbox shellenv...")
    (display-to-file #<<EOF
# shellcheck shell=bash
# Cache devbox shellenv - only recompute if config changed
_devbox_cache="$HOME/.cache/devbox-shellenv"
_devbox_config="$HOME/.local/share/devbox/global/default/devbox.json"

mkdir -p "$HOME/.cache"
if [[ ! -f "$_devbox_cache" || "$_devbox_config" -nt "$_devbox_cache" ]]; then
  devbox global shellenv > "$_devbox_cache" 2>/dev/null
fi
[[ -f "$_devbox_cache" ]] && source "$_devbox_cache"
unset _devbox_cache _devbox_config
EOF
                   devbox-path
                   #:exists 'replace))

  ;; Lazy-load rbenv
  (define rbenv-path (build-path SHELLRC_D "055_rbenv.sh"))
  (when (file-exists? rbenv-path)
    (echo "- Lazy-loading rbenv...")
    (display-to-file #<<EOF
# shellcheck shell=bash
# Lazy-load rbenv - only initialize on first use
_load_rbenv() {
  unfunction _load_rbenv rbenv ruby gem bundle 2>/dev/null
  eval "$(command rbenv init -)"
}
rbenv() { _load_rbenv; command rbenv "$@"; }
ruby() { _load_rbenv; command ruby "$@"; }
gem() { _load_rbenv; command gem "$@"; }
bundle() { _load_rbenv; command bundle "$@"; }
EOF
                   rbenv-path
                   #:exists 'replace))

  ;; Remove oh-my-zsh
  (define ohmyzsh-path (build-path SHELLRC_D "005_oh-my-zshrc.zsh"))
  (when (file-exists? ohmyzsh-path)
    (echo "- Removing oh-my-zsh...")
    (delete-file ohmyzsh-path))

  (echo "")
  (echo "Done! Shell startup should now be ~400ms instead of ~2.5s")
  (echo "Start a new shell to see the improvement."))

(main)
