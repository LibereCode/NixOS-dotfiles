# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# The following lines were added by compinstall

# zstyle ':completion:*' completer _oldlist _expand _complete _ignored _match _approximate _prefix
# zstyle ':completion:*' expand prefix suffix
# zstyle ':completion:*' file-sort access
# zstyle ':completion:*' format 'Compl %d'
# zstyle ':completion:*' ignore-parents parent pwd directory
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' list-suffixes true
# zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[.-_]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' menu select=2
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' special-dirs true
# zstyle ':completion:*' use-compctl true
# zstyle ':completion:*' verbose true
# zstyle :compinstall filename '/home/nixnomo/.config/zsh/.zshrc'

# autoload -Uz compinit
# compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
# HISTFILE=~/.config/.zhistfile
# HISTSIZE=91101
SAVEHIST=17231
setopt autocd extendedglob notify globdots
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# shell-shared files.sh
source ~/.config/shells/envvar.sh

# other sauce
source $ZDOTDIR/Sauce/plugs.zsh # manage plugins

