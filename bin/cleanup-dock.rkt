#!/usr/bin/env racket
#lang racket

(require racket/system
         racket/file
         racket/string)

(define (run* cmd . args)
  (define cmd-str
    (if (null? args)
        cmd
        (string-join (cons cmd (map ~a args)) " ")))
  (displayln (format "$ ~a" cmd-str))
  (unless (system cmd-str)
    (error (format "Command failed: ~a" cmd-str))))

(define (dock-item app-path)
  (format "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>~a</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
          app-path))

(define (main)
  (run* "defaults" "delete" "com.apple.dock" "persistent-apps")
  (run* "defaults" "write" "com.apple.dock" "persistent-apps" "-array"
        (dock-item "/Applications/Warp.app")
        (dock-item "/Applications/Slack.app")
        (dock-item "/Applications/Firefox.app")
        (dock-item "/Applications/Google Chrome.app"))
  (run* "killall" "Dock"))

(main)
