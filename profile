[[ -e ./.login ]] && . ./.login

#stty erase 

#if ! xhost > /dev/null 2>&1; then
#	$SHELL && exit
#fi

export PATH="$HOME/.cargo/bin:$PATH"
