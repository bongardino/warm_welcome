#!/bin/bash
# this is terrible and not safe dont use it I was up late

bakup_dir="$HOME"/Desktop/dot-backup
git_dir="$HOME"/src/dotfiles
dots=$(curl https://raw.githubusercontent.com/bongardino/dotfiles/master/.gitignore)

function dot_git {
   /usr/bin/git --git-dir="$git_dir" --work-tree="$HOME" "$@"
}

git init --bare "$git_dir"
git clone --bare https://github.com/bongardino/dotfiles.git "$git_dir"

mkdir -p "$bakup_dir"

for dots in "${dots[@]}"
do
   :
   file=$(echo "$dot" | cut -c2-)
   mv "$HOME/$file" "$backup_dir" || true
done

dot_git checkout
dot_git config status.showUntrackedFiles no
