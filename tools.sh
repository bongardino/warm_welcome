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

clear_previous_line
confirm "Are you signed into the app store?  [y/N]" || echo "skipping app store installs"

brew bundle
