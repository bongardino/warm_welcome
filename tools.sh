#!/usr/bin/env bash

# Disable exit on non 0, be verbose
set +e
set -x

#install homebrew and stuff, before sudo
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# make some dirs & files
mkdir -p "$HOME"/src
mkdir -p "$HOME"/bin
mkdir -p "$HOME"/.ssh

cat <<EOM > "$HOME"/.ssh/config
Host *
 AddKeysToAgent yes
 UseKeychain yes
 IdentityFile "$HOME"/.ssh/id_rsa
EOM

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# install pip
sudo easy_install pip

clear_previous_line
if confirm "Are you signed into the app store?  [y/N]"; then
  APPSTORE_RESPONSE="y"
fi

installer brewCask 'brew cask'
installer brew brew
installer pip pip

if [[ -z "$APPSTORE_RESPONSE" && "$(mas account)" -eq 0 ]]; then
  cat mas | while read line
  do
    if [[ $line != \#* ]]
    then
      app="$(mas search "$line" | awk NR==1'{ print $1 }')"
      mas install $app
    fi
  done
fi

#configure fzf
yes "y" | $(brew --prefix)/opt/fzf/install
