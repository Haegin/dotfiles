WM=${1:-xmonad}

# System and user resources and Xmodmap files
USERRESOURCES=$HOME/.Xresources
USERMODMAP=$HOME/.Xmodmap
USERMODMAPWM=$USERMODMAP-$WM
SYSRESOURCES=/etc/X11/xinit/.Xresources
SYSMODMAP=/etc/X11/xinit/.Xmodmap
XBINDKEYSRCWM=~/.xbindkeysrc-$WM

# Merge in system resources and keymaps
[ -f $SYSRESOURCES ] && xrdb -merge $SYSRESOURCES
[ -f $SYSMODMAP ] && xmodmap $SYSMODMAP

# Merge in user resources and keymaps
[ -f $USERRESOURCES ] && xrdb -merge $USERRESOURCES
if [ -f $USERMODMAPWM ]; then
    xmodmap $USERMODMAPWM
elif [ -f $USERMODMAP ]; then
    xmodmap $USERMODMAP
fi

# Run some nice programs at startup.
xscreensaver
#[ -f ~/.fehbg ] && source ~/.fehbg
setxkbmap gb dvorak                 # Because qwerty is evil and wrong
#xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
#xmodmap ~/.Xmodmap                  # Because we have config files now
#xsetroot -cursor_name left_ptr      # Because cursors don't have to be X shaped
#numlockx on                         # Because numbers are more useful than arrow keys.
#xwpset ~/Pictures/Archie\ at\ Langside.jpg ~/Pictures/Backgrounds/getWorking.jpg        # Because a background is nice even if you never look at it
urxvt256cd -q -o -f                     # Because making terminals more efficient is going to save a lot of wasted memory and we don't have enough of it...
#boblight-X11 -t 0.1                # Because pretty lights are fracking awesome
#urxvtc -title "IRC" -e ssh hobb -t "screen -D -RR -S irc -U irssi" &                           # Because I'll use it almost every time I boot the PC
firefox &                     # Because without the Internet, what is there?

# Run xbindkeys for specific window manager
# [ -f $XBINDKEYSRCWM ] &&  xbindkeys -f $XBINDKEYSRCWM &

#case $WM in
#    dwm) sysmon.rb | dzen2 -x 830 -y 0 -w 506 -ta r -fn '-artwiz-gelly-medium-*-*-*-*-*-*-*-*-*-*-*' -bg black -fg wheat -e 'onstart=raise;sigusr1=raise' &
#        ;;
#    xmonad) sysmon.rb | dzen2 -x 801 -y 0 -w 600 -ta r -fn '-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1' -bg black -fg wheat -e 'onstart=raise;sigusr1=raise' &
#        ;;
#esac

exec ${WM}
