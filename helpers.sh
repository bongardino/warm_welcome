#!/usr/bin/env bash

# if confirm "do a thing?  [y/N]"; then
#   thing
# fi
confirm() {
  # call with a prompt string or use a default
  read -r -p "${1:-Are you sure? [y/N]} " response
  case "$response" in
      [yY][eE][sS]|[yY]) 
          true
          ;;
      *)
          false
          ;;
  esac
}

clear_previous_line() {
  tput cuu 1 && tput el
}

# spinner sleep 5
spinner (){
  ("$@") 2>/dev/null & 
  pid=$! # Process Id of the previous running command

  spin='-\|/'

  i=0
  while kill -0 $pid 2>/dev/null
  do
    i=$(( (i+1) %4 ))
    printf "\r${spin:$i:1}"
    sleep .1
  done
}
