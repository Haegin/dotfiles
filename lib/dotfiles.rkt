#lang racket

(provide (all-defined-out))

(require racket/system
         racket/file
         racket/string
         racket/path)

(define DOTDIR (build-path (getenv "HOME") ".dotfiles"))

(define (run cmd . args)
  (define cmd-str
    (if (null? args)
        cmd
        (string-join (cons cmd (map ~a args)) " ")))
  (displayln (format "$ ~a" cmd-str))
  (system cmd-str))

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

(define (echo msg)
  (displayln msg))

(define (symlink-exists? path)
  (and (file-exists? path)
       (link-exists? path)))

(define (make-symlink target linkpath)
  (make-parent-directory* linkpath)
  (make-file-or-directory-link target linkpath))

(define (remove-symlink path)
  (when (and (file-exists? path) (link-exists? path))
    (delete-file path)))

(define (os-type)
  (let ([uname (with-output-to-string (lambda () (system "uname -s")))])
    (string-trim uname)))

(define (fzf-select prompt choices)
  (define input (string-join choices "\n"))
  (define output
    (with-output-to-string
      (lambda ()
        (with-input-from-string input
          (lambda ()
            (system (format "fzf --height=10% --prompt='~a > '" prompt)))))))
  (define result (string-trim output))
  (if (string=? result "")
      #f
      result))

(define (git-clone url dir)
  (unless (directory-exists? dir)
    (run* "git" "clone" url dir)))

(define (git-clone-depth url dir depth)
  (unless (directory-exists? dir)
    (run* "git" "clone" (format "--depth=~a" depth) url dir)))
