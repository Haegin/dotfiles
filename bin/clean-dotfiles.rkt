#!/usr/bin/env racket
#lang racket

(require racket/file
         racket/path
         racket/string
         "../lib/dotfiles.rkt")

(define DOTDIR (build-path (getenv "HOME") ".dotfiles"))

(define (main)
  (echo (format "Removing linked files in ~a from ~a:" (getenv "HOME") DOTDIR))
  (for ([item (directory-list DOTDIR)])
    (define item-str (path->string item))
    (unless (string=? item-str "bin")
      (define linkpath (build-path (getenv "HOME") (string-append "." item-str)))
      (echo (format "- .~a" item-str))
      (remove-symlink linkpath)))
  (echo "\nFinished!"))

(main)
