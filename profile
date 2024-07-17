[[ -e ./.login ]] && . ./.login

#stty erase 

#if ! xhost > /dev/null 2>&1; then
#	$SHELL && exit
#fi

export PATH="$HOME/.cargo/bin:$PATH"

source /Users/harry/.docker/init-bash.sh || true # Added by Docker Desktop
