crt() {
  if [[ $# -eq 0 ]]; then
    cd ~/dev/instacart/carrot
  else
    local target_dir=~/dev/instacart/carrots/$1
    if [[ -d $target_dir ]]; then
      cd $target_dir
    else
      print -u2 "Error: Directory '$target_dir' does not exist."
      return 1
    fi
  fi
}
