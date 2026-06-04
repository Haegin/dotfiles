#lang racket

(provide setup)

(require racket/file
         racket/path)

(define (setup)
  ;; Don't use our normal ZSH config in ~/.zsh
  (define zshenv (build-path (getenv "HOME") ".zshenv"))
  (when (file-exists? zshenv)
    (delete-file zshenv))

  ;; Kill the automatically created bento ~/.zshrc.d and replace it with our own
  (define zshrc-d (build-path (getenv "HOME") ".zshrc.d"))
  (when (and (directory-exists? zshrc-d)
             (null? (directory-list zshrc-d)))
    (delete-directory zshrc-d)
    (make-file-or-directory-link (build-path (getenv "HOME") ".zsh" "zshrc.d") zshrc-d)))
