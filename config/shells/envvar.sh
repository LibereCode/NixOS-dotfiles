# FZF # https://github.com/junegunn/fzf
# FZF_DEFAULT_COMMAND=""
FZF_DEFAULT_OPTS="
    --layout=reverse --border=sharp --margin=3% --color=dark
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
"
# FZF_DEFAULT_OPTS_FILE="" # ~/path/to/file-with-FZF_DEFAULT_OPTS
FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
"
FZF_CTRL_R_OPTS="fzf"
FZF_ALT_C_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'tree -C {}'
"

# NOTE: Put in configuration.nix instead
