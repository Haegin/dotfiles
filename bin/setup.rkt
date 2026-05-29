#!/usr/bin/env racket
#lang racket

(require racket/file
         racket/path
         racket/string
         racket/system)

(define DOTDIR (build-path (getenv "HOME") ".dotfiles"))

;; --- helpers ---

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

(define (echo msg)
  (displayln msg))

(define (command-exists? cmd)
  (system (format "command -v ~a > /dev/null 2>&1" cmd)))

(define (make-symlink target linkpath)
  (make-parent-directory* linkpath)
  (make-file-or-directory-link target linkpath))

(define (symlink-exists? path)
  (and (file-exists? path) (link-exists? path)))

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

;; --- setup functions ---

(define (link-dotfiles)
  (echo (format "Linking files into ~a from ~a:" (getenv "HOME") DOTDIR))
  (define exclude '("bin" "utils" "docs" "profiles" "config"))
  (for ([item (directory-list DOTDIR)])
    (define item-str (path->string item))
    (unless (member item-str exclude)
      (define src (build-path DOTDIR item))
      (define dst (build-path (getenv "HOME") (string-append "." item-str)))
      (when (and (not (file-exists? dst)) (not (directory-exists? dst)))
        (echo (format "- .~a" item-str))
        (make-symlink src dst))))

  (echo (format "Linking config items into ~a/.config from ~a/config:" (getenv "HOME") DOTDIR))
  (define config-dir (build-path DOTDIR "config"))
  (when (directory-exists? config-dir)
    (define config-home (build-path (getenv "HOME") ".config"))
    (make-directory* config-home)
    (for ([item (directory-list config-dir)])
      (define src (build-path config-dir item))
      (define dst (build-path config-home item))
      (when (and (not (file-exists? dst)) (not (directory-exists? dst)))
        (echo (format "- .config/~a" (path->string item)))
        (make-symlink src dst)))))

(define (setup-history)
  (echo "Making history")
  (define zvardir (or (getenv "ZVARDIR") (build-path (getenv "HOME") ".var" "zsh")))
  (make-directory* zvardir))

(define (setup-base16-shell)
  (define base16-dir (build-path (getenv "HOME") ".config" "base16-shell"))
  (unless (directory-exists? base16-dir)
    (echo "Installing base16-shell for terminal color schemes")
    (run* "git" "clone" "https://github.com/chriskempson/base16-shell" base16-dir)))

(define (setup-antidote)
  ;; Skip if installed via homebrew
  (cond
    [(file-exists? "/opt/homebrew/opt/antidote/share/antidote/antidote.zsh")
     (echo "antidote already installed via Homebrew, skipping")]
    [else
     (define antidote-dir (build-path (getenv "HOME") ".antidote"))
     (unless (directory-exists? antidote-dir)
       (echo "Installing antidote plugin manager")
       (run* "git" "clone" "--depth=1" "https://github.com/mattmc3/antidote.git" antidote-dir))]))

(define (run-custom-setup)
  (define profiles-dir (build-path DOTDIR "profiles"))
  (define user-profile (build-path profiles-dir (getenv "USER")))
  (define profile
    (cond
      [(and (directory-exists? user-profile)
            (file-exists? (build-path user-profile "setup")))
       (getenv "USER")]
      [(and (file-exists? user-profile)
            (not (directory-exists? user-profile)))
       (getenv "USER")]
      [else
       (define choices
         (filter (lambda (p)
                   (or (file-exists? (build-path profiles-dir p))
                       (directory-exists? (build-path profiles-dir p))))
                 (map path->string (directory-list profiles-dir))))
       (fzf-select "Select a profile to further customise your install or press Ctrl+C to cancel"
                   choices)]))
  (when profile
    (echo (format "Running ~a's custom setup script" profile))
    (define profile-path (build-path profiles-dir profile))
    (cond
      [(directory-exists? profile-path)
       (run* (path->string (build-path profile-path "setup")))]
      [(file-exists? profile-path)
       (run* (path->string profile-path))])))

;; --- main ---

(define (main)
  (unless (directory-exists? DOTDIR)
    (echo "Dotfiles don't seem to be correctly set up.")
    (echo (format "Ensure you've cloned github.com/haegin/dotfiles into ~a." DOTDIR))
    (exit 1))

  (echo "Setting up your machine...\n")

  ;; Ask for the administrator password upfront
  (run* "sudo" "-v")

  ;; Keep-alive: update existing sudo time stamp until setup has finished
  (thread
   (lambda ()
     (let loop ()
       (sleep 60)
       (system "sudo -n true")
       (loop))))

  (link-dotfiles)
  (setup-history)
  (setup-antidote)
  (setup-base16-shell)

  (define os-specific (build-path DOTDIR "bin" (format "setup-~a.rkt" (os-type))))
  (when (file-exists? os-specific)
    (echo "Running OS specific setup")
    (run* "racket" (path->string os-specific)))

  (run-custom-setup)

  (echo "\nFinished!"))

(main)
