#lang racket

(provide setup)

(require racket/system
         racket/string
         "../../lib/dotfiles.rkt")

(define (setup)
  (when (command-exists? "brew")
    (define dev-brewfile (build-path (getenv "HOME") ".dotfiles" "profiles" "dev" "Brewfile"))
    (define harry-brewfile (build-path (getenv "HOME") ".dotfiles" "profiles" "harry" "Brewfile"))
    (run* "brew" "bundle" (format "--file=~a" (path->string dev-brewfile)))
    (run* "brew" "bundle" (format "--file=~a" (path->string harry-brewfile)))))
