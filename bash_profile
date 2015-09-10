#
# ~/.bash_profile
#

#[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f ~/.profile ]] && source ~/.profile
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

