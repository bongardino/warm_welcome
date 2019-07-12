#!/usr/bin/env bash

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

installer() {
  cat $1 | while read line
  do
    if [[ $line != \#* ]]
    then
      $2 install $line;
    fi
  done
}
