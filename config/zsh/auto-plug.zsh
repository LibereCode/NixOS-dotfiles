#!/usr/bin/env zsh

# `auto-plug.zsh user1/repo1 user2/repo2 ...`
# example: `./auto-plug.zsh \
#   https://github.com/junegunn/fzf.git \
#   https://github.com/zsh-users/zsh-syntax-highlighting`

base_path="$ZPLUGS/"
mkdir -pv $base_path

for url in "${@}"; do
    nogit=${url%.git}                   # remove last .git
    repo=${nogit##*/}                   # after last /
    norepo=${nogit%/*}                  # remove last /value
    user=${norepo##*/}                  # part after previous last /

    # echo "user='$user' repo='$repo'"

    full_path="$base_path""$repo"

    if [[ ! -n "$(ls -A $full_path)" ]]; then
        git clone --depth 1 --single-branch "$url" "$full_path"
        printf '\e[33mRemember to sauce it!\e[0m\n'
    # else
    #     printf '\e[31mexist already\e[0m\n'
    fi
done

# TODO: add a :extension to each "argument-string",
#   containing the file to be sauced (inside $full_path)
