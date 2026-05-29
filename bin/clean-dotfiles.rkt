#!/usr/bin/env racket
#lang racket

(require racket/file
         racket/path
         racket/string)

(define DOTDIR (build-path (getenv "HOME") ".dotfiles"))

(define (echo msg)
  (displayln msg))

(define (symlink-exists? path)
  (and (file-exists? path) (link-exists? path)))

(define (remove-symlink path)
  (when (symlink-exists? path)
    (delete-file path)))

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
