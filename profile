. ./.login
if $CS && [ -f `which amixer` ] && aplay -L | grep -i card; then
	amixer -c0 sset Front 0dB > /dev/null		# Set the volume to max
fi

#stty erase 

#if ! xhost > /dev/null 2>&1; then
#	$SHELL && exit
#fi
