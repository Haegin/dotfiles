# .zshenv
#
# Base zshenv file which simply delegates to files in $ZDOTDIR
#
# Copyright © 1994–2008 martin f. krafft <madduck@madduck.net>
# Released under the terms of the Artistic Licence 2.0
#
# Source repository: http://git.madduck.net/v/etc/zsh.git
#

ZDOTDIR=$HOME/.zsh
[ -f $ZDOTDIR/.zshenv ] && . $ZDOTDIR/.zshenv
