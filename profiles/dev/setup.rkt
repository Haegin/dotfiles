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

(define (echo msg)
  (displayln msg))

(define (command-exists? cmd)
  (system (format "command -v ~a > /dev/null 2>&1" cmd)))

(define (install-lang lang [version #f])
  (echo (format "Installing ~a using ASDF" lang))
  (define asdf-dir (build-path (getenv "HOME") ".asdf"))
  (cond
    [(directory-exists? asdf-dir)
     (run* "bash" "-c"
           (format "source ~a/asdf.sh && asdf plugin-add ~a || true"
                   (path->string asdf-dir) lang))
     (define latest
       (with-output-to-string
         (lambda ()
           (system
            (format "bash -c 'source ~a/asdf.sh && asdf list-all ~a | grep -E \"^[0-9.]+$\" | sort -V | tail -n 1'"
                    (path->string asdf-dir) lang)))))
     (define ver (or version (string-trim latest)))
     (run* "bash" "-c"
           (format "source ~a/asdf.sh && asdf install ~a ~a"
                   (path->string asdf-dir) lang ver))]
    [else
     (echo (format "Could not install ~a as ASDF is not installed." lang))]))

(define (setup)
  (install-lang "erlang")
  (install-lang "elixir")
  (install-lang "ruby")

  (when (command-exists? "brew")
    (define brewfile (build-path (getenv "HOME") ".dotfiles" "profiles" "dev" "Brewfile"))
    (run* "brew" "bundle" (format "--file=~a" (path->string brewfile)))))
