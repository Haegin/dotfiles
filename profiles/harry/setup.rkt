#lang racket

(provide setup)

(require racket/system
         racket/string)

(define (run* cmd . args)
  (define cmd-str
    (if (null? args)
        cmd
        (string-join (cons cmd (map ~a args)) " ")))
  (displayln (format "$ ~a" cmd-str))
  (unless (system cmd-str)
    (error (format "Command failed: ~a" cmd-str))))

(define (command-exists? cmd)
  (system (format "command -v ~a > /dev/null 2>&1" cmd)))

(define (setup)
  (when (command-exists? "brew")
    (define dev-brewfile (build-path (getenv "HOME") ".dotfiles" "profiles" "dev" "Brewfile"))
    (define harry-brewfile (build-path (getenv "HOME") ".dotfiles" "profiles" "harry" "Brewfile"))
    (run* "brew" "bundle" (format "--file=~a" (path->string dev-brewfile)))
    (run* "brew" "bundle" (format "--file=~a" (path->string harry-brewfile)))))
