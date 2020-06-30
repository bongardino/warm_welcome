#!/bin/bash
# this is terrible and not safe dont use it I was up late

set -x

backup_dir="$HOME"/Desktop/dot-backup
git_dir="$HOME"/src/dotfiles

function dot-git {
   /usr/bin/git --git-dir="$git_dir" --work-tree="$HOME" "$@"
}

function cleanup {
  if [[ -e "out" ]]; then
    rm out
  fi

  if [[ -e "dots" ]]; then
    rm dots
  fi
}

mkdir -p "$backup_dir"

cleanup

curl -sLJ https://raw.githubusercontent.com/bongardino/dotfiles/master/.gitignore -o out

cat out | while read line; do
  if [[ "$line" =~ .*"!".* ]]; then
    echo $line | cut -c2- >> dots
  fi
done

cat dots | while read dot; do
  if [[ -e "$HOME/$dot" ]]; then
    mv $HOME/$dot $backup_dir || true
  fi
done

git clone --bare https://github.com/bongardino/dotfiles.git "$git_dir"
dot-git checkout

if [ $? = 0 ]; then
  echo "Checked out dots."
fi

dot-git config status.showUntrackedFiles no

cleanup
