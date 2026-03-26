# NOTE: manage plugins here
# loading
# envvar
# settings

###############
## GIT CLONE ##
###############
$ZDOTDIR/auto-plug.zsh "https://github.com/romkatv/powerlevel10k.git"

#########
## FZF ##
#########
source <(fzf --zsh)

##############
## POWER10K ##
##############
source $ZPLUGS/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit $ZDOTDIR/.p10k.zsh.
[[ -f $ZDOTDIR/.p10k.zsh ]] && source ~/NixOS/config/zsh/.p10k.zsh
