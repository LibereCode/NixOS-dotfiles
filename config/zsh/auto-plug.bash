#!/usr/bin/env bash

# `auto-plug.bash user1/repo1 user2/repo2 ...`
# example: `./auto-plug.bash \
#   https://github.com/junegunn/fzf.git \
#   https://github.com/zsh-users/zsh-syntax-highlighting`

base_path="$HOME/.cache/zsh/plugins/"
mkdir -pv $base_path

for url in "${@}"; do
  nogit=${url%.git}                       # remove last .git
  repo=${nogit##*/}                       # after last /
  norepo=${nogit%/*}                       # remove last /value
  user=${norepo##*/}                     # part after previous last /

  echo "user='$user' repo='$repo'"

  full_path="$base_path""$repo"

  if [[ ! -n "$(ls -A $full_path)" ]]; then
      git clone --depth 1 --single-branch "$url" "$full_path"
  else printf '\e[31mexist already\e[0m\n'
  fi
done
