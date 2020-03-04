#!/bin/bash
# this is terrible and not safe dont use it I was up late

# set -x

backup_dir="$HOME"/Desktop/dot-backup
git_dir="$HOME"/src/dotfiles

function dot_git {
   /usr/bin/git --git-dir="$git_dir" --work-tree="$HOME" "$@"
}

mkdir -p "$backup_dir"

# git init --bare "$git_dir"
git clone --bare https://github.com/bongardino/dotfiles.git "$git_dir"
dot_git checkout

if [ $? = 0 ]; then
  echo "Checked out dots.";
  else
    echo "Backing up pre-existing dots and retrying ...";
    dot_git checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I {} mv $HOME/{} $backup_dir
    mv $git_dir $backup_dir || true
	git clone --bare https://github.com/bongardino/dotfiles.git "$git_dir"
    dot_git checkout
fi;

dot_git config status.showUntrackedFiles no
