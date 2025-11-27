[[ -e ./.login ]] && . ./.login

#stty erase 

#if ! xhost > /dev/null 2>&1; then
#	$SHELL && exit
#fi

export PATH="$HOME/.cargo/bin:$PATH"

source /Users/harry/.docker/init-bash.sh || true # Added by Docker Desktop

# >>> gohan setup, do not edit this section <<<
# !! Contents within this block are managed by gohan !!
[ -f "/Users/harry/.config/gohan/gohan.sh" ] && source "/Users/harry/.config/gohan/gohan.sh"
# <<< gohan setup end <<<
