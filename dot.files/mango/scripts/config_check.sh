#!/usr/bin/env bash

output=$(mango -p 2>&1 | sed -r '
    s/\x1b\[[0-9;]*[a-zA-Z]//g   # 移除ANSI颜色代码
    s/   ╰─/ ╰─/g                # 压缩多余空格
    s/^[[:space:]]*//            # 删除行首空格
    s/[[:space:]]*$//            # 删除行尾空格
')

icon="$HOME/.config/mango/wallpaper/mango.png"

if [[ -z "$output" ]]; then
    exit 0
fi

notify-send --urgency=critical --icon="$icon" "Mango Status" "$output"
