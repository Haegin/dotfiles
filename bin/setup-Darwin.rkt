#!/usr/bin/env racket
#lang racket

(require racket/system
         racket/file
         racket/string
         racket/path)

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

;; --- setup functions ---

(define (setup-homebrew)
  (echo "Installing Homebrew")
  (unless (command-exists? "brew")
    (run* "/bin/bash" "-c"
          "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"))
  (run* "brew" "tap" "Homebrew/bundle")
  (define brewfile (build-path (getenv "HOME") ".dotfiles" "utils" "Brewfile"))
  (run* "brew" "bundle" (format "--file=~a" brewfile))
  (define brewfile-mac (build-path (getenv "HOME") ".dotfiles" "utils" "Brewfile.mac"))
  (when (file-exists? brewfile-mac)
    (run* "brew" "bundle" (format "--file=~a" brewfile-mac))))

(define (configure-sane-defaults)
  ;; Close any open System Preferences panes
  (run "osascript" "-e" "tell application \"System Preferences\" to quit")

  ;; Enable full keyboard access for all controls
  (run* "defaults" "write" "NSGlobalDomain" "AppleKeyboardUIMode" "-int" "3")
  ;; Set language and text formats
  (run* "defaults" "write" "NSGlobalDomain" "AppleLanguages" "-array" "en")
  (run* "defaults" "write" "NSGlobalDomain" "AppleLocale" "-string" "en_CA@currency=CAD")
  (run* "defaults" "write" "NSGlobalDomain" "AppleMeasurementUnits" "-string" "Centimeters")
  (run* "defaults" "write" "NSGlobalDomain" "AppleMetricUnits" "-bool" "true")
  ;; Timezone
  (run* "sudo" "systemsetup" "-settimezone" "America/Toronto")
  ;; Stop iTunes from responding to the keyboard media keys
  (run "launchctl" "unload" "-w" "/System/Library/LaunchAgents/com.apple.rcd.plist")
  ;; Finder: show all filename extensions
  (run* "defaults" "write" "NSGlobalDomain" "AppleShowAllExtensions" "-bool" "true")
  ;; Finder: show status bar
  (run* "defaults" "write" "com.apple.finder" "ShowStatusBar" "-bool" "true")
  ;; Keep folders on top when sorting by name
  (run* "defaults" "write" "com.apple.finder" "_FXSortFoldersFirst" "-bool" "true")
  (run* "defaults" "write" "com.apple.finder" "FXDefaultSearchScope" "-string" "SCcf")
  ;; Disable the warning when changing a file extension
  (run* "defaults" "write" "com.apple.finder" "FXEnableExtensionChangeWarning" "-bool" "false")
  ;; Show the ~/Library folder
  (run* "chflags" "nohidden" (build-path (getenv "HOME") "Library"))
  ;; Show the /Volumes folder
  (run* "sudo" "chflags" "nohidden" "/Volumes")
  ;; Clear the dock icons
  (run* "defaults" "write" "com.apple.dock" "persistent-apps" "-array")
  ;; Automatically hide and show the Dock
  (run* "defaults" "write" "com.apple.dock" "autohide" "-bool" "true"))

(define (configure-spotlight)
  (run* "defaults" "write" "com.apple.spotlight" "orderedItems" "-array"
        "{\"enabled\" = 1;\"name\" = \"APPLICATIONS\";}"
        "{\"enabled\" = 1;\"name\" = \"SYSTEM_PREFS\";}"
        "{\"enabled\" = 1;\"name\" = \"DIRECTORIES\";}"
        "{\"enabled\" = 1;\"name\" = \"PDF\";}"
        "{\"enabled\" = 1;\"name\" = \"FONTS\";}"
        "{\"enabled\" = 0;\"name\" = \"DOCUMENTS\";}"
        "{\"enabled\" = 0;\"name\" = \"MESSAGES\";}"
        "{\"enabled\" = 0;\"name\" = \"CONTACT\";}"
        "{\"enabled\" = 0;\"name\" = \"EVENT_TODO\";}"
        "{\"enabled\" = 0;\"name\" = \"IMAGES\";}"
        "{\"enabled\" = 0;\"name\" = \"BOOKMARKS\";}"
        "{\"enabled\" = 0;\"name\" = \"MUSIC\";}"
        "{\"enabled\" = 0;\"name\" = \"MOVIES\";}"
        "{\"enabled\" = 0;\"name\" = \"PRESENTATIONS\";}"
        "{\"enabled\" = 0;\"name\" = \"SPREADSHEETS\";}"
        "{\"enabled\" = 0;\"name\" = \"SOURCE\";}"
        "{\"enabled\" = 0;\"name\" = \"MENU_DEFINITION\";}"
        "{\"enabled\" = 0;\"name\" = \"MENU_OTHER\";}"
        "{\"enabled\" = 0;\"name\" = \"MENU_CONVERSION\";}"
        "{\"enabled\" = 0;\"name\" = \"MENU_EXPRESSION\";}"
        "{\"enabled\" = 0;\"name\" = \"MENU_WEBSEARCH\";}"
        "{\"enabled\" = 0;\"name\" = \"MENU_SPOTLIGHT_SUGGESTIONS\";}")
  ;; Load new settings before rebuilding the index
  (run "killall" "mds")
  ;; Make sure indexing is enabled for the main volume
  (run* "sudo" "mdutil" "-i" "on" "/")
  ;; Rebuild the index from scratch
  (run* "sudo" "mdutil" "-E" "/"))

(define (prettify-terminal)
  (define theme-name "Solarized Dark xterm-256color")
  (define theme-path (build-path (getenv "HOME") "init" (string-append theme-name ".terminal")))
  (when (file-exists? theme-path)
    (run* "open" (path->string theme-path)))
  ;; Disable the annoying line marks
  (run* "defaults" "write" "com.apple.Terminal" "ShowLineMarks" "-int" "0")
  ;; Don't display the annoying prompt when quitting iTerm
  (run* "defaults" "write" "com.googlecode.iterm2" "PromptOnQuit" "-bool" "false")
  (define dracula-theme (build-path (getenv "HOME") ".dotfiles" "utils" "dracula-iterm-theme" "Dracula.itermcolors"))
  (when (file-exists? dracula-theme)
    (run* "open" (path->string dracula-theme))))

(define (configure-activity-monitor)
  ;; Show the main window when launching Activity Monitor
  (run* "defaults" "write" "com.apple.ActivityMonitor" "OpenMainWindow" "-bool" "true")
  ;; Visualize CPU usage in the Activity Monitor Dock icon
  (run* "defaults" "write" "com.apple.ActivityMonitor" "IconType" "-int" "5")
  ;; Show all processes in Activity Monitor
  (run* "defaults" "write" "com.apple.ActivityMonitor" "ShowCategory" "-int" "0")
  ;; Sort Activity Monitor results by CPU usage
  (run* "defaults" "write" "com.apple.ActivityMonitor" "SortColumn" "-string" "CPUUsage")
  (run* "defaults" "write" "com.apple.ActivityMonitor" "SortDirection" "-int" "0"))

;; --- main ---

(define (main)
  (echo "Setting up Mac specific configuration")
  (setup-homebrew)
  (configure-sane-defaults)
  (configure-spotlight)
  (prettify-terminal)
  (configure-activity-monitor)
  (echo "Done!"))

(main)
