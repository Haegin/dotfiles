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

# Set some nice colors
FG_COLOR='#00ff00'
BG_COLOR='#000000'
FONT='-*-terminus-*-*-*-*-*-80-*-*-*-*-iso8859-1'
export FG_COLOR BG_COLOR FONT

# Run some nice programs at startup.
[ -f ~/.fehbg ] && source ~/.fehbg
#xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &
urxvtd -q -o -f
urxvtc &
firefox &
setxkbmap gb dvorak
xmodmap ~/.Xmodmap

# Run xbindkeys for specific window manager
# [ -f $XBINDKEYSRCWM ] &&  xbindkeys -f $XBINDKEYSRCWM &

#case $WM in
#    dwm) sysmon.rb | dzen2 -x 830 -y 0 -w 506 -ta r -fn '-artwiz-gelly-medium-*-*-*-*-*-*-*-*-*-*-*' -bg black -fg wheat -e 'onstart=raise;sigusr1=raise' &
#        ;;
#    xmonad) sysmon.rb | dzen2 -x 801 -y 0 -w 600 -ta r -fn '-xos4-terminus-medium-r-normal--12-120-72-72-c-60-iso8859-1' -bg black -fg wheat -e 'onstart=raise;sigusr1=raise' &
#        ;;
#esac

exec ${WM}
