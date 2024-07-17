#!/bin/bash

defaults delete com.apple.dock persistent-apps

dock_item() {
    printf '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>%s</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>', "$1"
}

defaults write com.apple.dock persistent-apps -array \
    "$(dock_item /Applications/Warp.app)" \
    "$(dock_item /Applications/Slack.app)" \
    "$(dock_item /Applications/Firefox.app)" \
    "$(dock_item /Applications/Google\ Chrome.app)"

killall Dock
