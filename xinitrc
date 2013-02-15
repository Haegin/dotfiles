#!/bin/zsh
WM=${1:-xmonad}

# # Test for an existing dbus daemon just to be safe
# if test -s "$DBUS_SESSION_BUS_ADDRESS"; then
#   # if not found, launch a new one
#   eval `dbus-launch --sh-syntax --exit-with-session`
#   echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
# fi

# System and user resources and Xmodmap files
USERRESOURCES=$HOME/.Xresources
USERMODMAP=$HOME/.Xmodmap
USERMODMAPWM=$USERMODMAP-$WM
SYSRESOURCES=/etc/X11/xinit/.Xresources
SYSMODMAP=/etc/X11/xinit/.Xmodmap
XBINDKEYSRCWM=~/.xbindkeysrc-$WM

SYSXPROFILE=/etc/xprofile
USRXPROFILE=$HOME/.xprofile

# Merge in system resources and keymaps
[ -f $SYSRESOURCES ] && xrdb -merge $SYSRESOURCES
[ -f $SYSMODMAP ] && xmodmap $SYSMODMAP

# Merge in user resources and keymaps
[ -f $USERRESOURCES ] && xrdb -merge $USERRESOURCES

[ -f $SYSXPROFILE ] && . $SYSXPROFILE
[ -f $USRXPROFILE ] && . $USRXPROFILE
if [ -f $USERMODMAPWM ]; then
    xmodmap $USERMODMAPWM
elif [ -f $USERMODMAP ]; then
    xmodmap $USERMODMAP
fi

# If this is a virtual machine lets load the guest additions
if [ -x /usr/bin/VBoxClient-all ]; then
    VBoxClient-all &
fi

# Run some nice programs at startup.

xscreensaver &
xbindkeys &

#syndaemon -t -k -i 2 -d &             # Because we like to stop our touchpads when we type
#lxpanel &                             # To get a system tray
#dbus-launch nm-applet --sm-disable &  # so we can have wifi
#numlockx on &                          # Because numbers are more useful than arrow keys.
#xsetroot -cursor_name left_ptr &       # Because cursors don't have to be X shaped
#xwpset ~/Pictures/Archie\ at\ Langside.jpg ~/Pictures/Backgrounds/getWorking.jpg        # Because a background is nice even if you never look at it
#urxvt256cd -q -o -f                   # Because making terminals more efficient is going to save a lot of wasted memory and we don't have enough of it...
#boblight-X11 -t 0.1                   # Because pretty lights are fracking awesome
#urxvtc -title "IRC" -e ssh hobb -t "screen -D -RR -S irc -U irssi" &                           # Because I'll use it almost every time I boot the PC
#firefox &                             # Because without the Internet, what is there?

# Connect to odin and irc
urxvt -e zsh -c "ssh -t odin -- tmux -u2 attach -d" &
google-chrome &

exec ${WM}
