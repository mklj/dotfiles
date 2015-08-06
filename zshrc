#--------------------
# VARIABLES
#--------------------
# generated with `dircolors -b`
LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
#export LS_COLORS
#export WORDCHARS=''
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# colored man pages
#--------------------
# BEHAVIOUR
#--------------------
setopt extended_glob
setopt autocd
# report the status of backgrounds jobs immediately
setopt notify

#--------------------
# RAINBOWS
#--------------------
# man colored pages
# To customize the colors, see Wikipedia:ANSI escape code for reference
# man() {
#   env \
# 	LESS_TERMCAP_mb=$(printf "\e[1;31m") \
# 	LESS_TERMCAP_md=$(printf "\e[1;31m") \
# 	LESS_TERMCAP_me=$(printf "\e[0m") \
# 	LESS_TERMCAP_se=$(printf "\e[0m") \
# 	LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
# 	LESS_TERMCAP_ue=$(printf "\e[0m") \
# 	LESS_TERMCAP_us=$(printf "\e[1;32m") \
# 	man "$@"
# }

# support colors in less
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

#--------------------
# COMPLETION
#--------------------
unsetopt menu_complete # Do not autoselect the first completion entry.
unsetopt auto_menu
#unsetopt FLOW_CONTROL # Disable start/stop characters in shell editor.
setopt completealiases
setopt complete_in_word
setopt AUTO_PARAM_SLASH # If completed parameter is a directory, add a trailing slash.
autoload -Uz compinit
compinit

# Layout is
# :completion:FUNCTION:COMPLETER:COMMAND-OR-MAGIC-CONTEXT:ARGUMENT:TAG
# Tip: Get completion help running 'ctrl-x h'.
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' completer _expand _complete _ignored _approximate _files
zstyle ':completion:*' completer _oldlist _expand _complete _files _ignored
zstyle ':completion:*' use-cache on
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
#zstyle ':completion:*' menu select=1
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle :compinstall filename '/home/mja/.zshrc'

# directories
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
# provide .. as a completion
zstyle ':completion:*' special-dirs ..

# kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

# don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Environmental Variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# ssh / scp /rsync
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files  hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order users 'hosts:-host  hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*.*' loopback localhost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^*.*' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^<->.<->.<->.<->' '127.0.0.<->'

#--------------------
# CORRECTION
#--------------------
setopt nocorrectall
# # some people don't like the automatic correction - so run 'NOCOR=1 zsh' to deactivate it
# if [[ "$NOCOR" -gt 0 ]] ; then
# 	zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _files _ignored
# 	setopt nocorrect
# else
# 	# try to be smart about when to use what completer...
# 	setopt correct
# 	zstyle -e ':completion:*' completer '
# 		if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
# 			_last_try="$HISTNO$BUFFER$CURSOR"
# 			reply=(_complete _match _ignored _prefix _files)
# 		else
# 			if [[ $words[1] == (rm|mv) ]] ; then
# 				reply=(_complete _files)
# 			else
# 				reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
# 			fi
# 		fi'
# fi

#--------------------
# HISTORY
#--------------------
SAVEHIST=10000 # Number of entries
HISTSIZE=10000
HISTFILE=~/.zsh/history # File
setopt APPEND_HISTORY # Don't erase history
setopt EXTENDED_HISTORY # Add additional data to history like timestamp
setopt INC_APPEND_HISTORY # Add immediately
setopt HIST_FIND_NO_DUPS # Don't show duplicates in search
#setopt HIST_IGNORE_SPACE # Don't preserve spaces. You may want to turn it off
setopt NO_HIST_BEEP # Don't beep
setopt share_history # Share history between session/terminals
# setopt hist_expire_dups_first
setopt hist_ignore_dups

#--------------------
# PROMPT
#--------------------
#autoload -U promptinit && promptinit
##PROMPT="
 ##%K{blue}%n@%m%k %B%F{cyan}%(4~|...|)%3~%F{white} %# %b%f%k"
#PROMPT="
 #%B%F{yellow}[%n@%m %1~] %#%f%b "

# autoload -U colors zsh/terminfo
# colors
autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git hg
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

# setprompt() {
# 	# load some modules
# 	setopt prompt_subst

# 	# Check the UID
# 	if [[ $UID -ge 1000 ]]; then # normal user
# 		# eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
# 		# eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
# 		PROMPT="
#  %F{yellow} %B[%n@%m %~] %# %b%f "
# 	elif [[ $UID -eq 0 ]]; then # root
# 		# eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
# 		# eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
# 		PROMPT="
#  %K{red} %B%n@%m %1~ %# %b%k "
# 	fi

# 	# Check if we are on SSH or not
# 	# if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
# 	# 	PROMPT="
#  # %K{green} %F{black}%B%n@%m %1~ %# %b%f%k " #SSH
# 	# else
# 	# 	eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
# 	# fi
# 	# set the prompt
# 	# PS1=$'${PR_CYAN}[${PR_USER}${PR_CYAN}@${PR_HOST}${PR_CYAN}][${PR_BLUE}%~${PR_CYAN}]${PR_USER_OP} '
# 	# PS2=$'%_>'
# 	# RPROMPT=$'${vcs_info_msg_0_}'
# 	# RPROMPT="%F{magenta}%B%m%b%f"
# 	# RPROMPT="%F{magenta}%B@%m %b%f"
# }
# setprompt

setprompt() {
	# user color
	if [[ $UID -ge 1000 ]]; then
		user_color="yellow"
	elif [[ $UID -eq 0 ]]; then
		user_color="red"
	fi
	# server color
	if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
		machine_color="magenta"
	else
		machine_color="yellow"
	fi
	PROMPT="
 %B%F{$user_color}%n%f%F{yellow}@%f%F{$machine_color}%m%f %F{yellow}%~ %# %f%b"
}
setprompt

#--------------------
# KEYBINDINGS
#--------------------

# The actual terminal setup hooks and bindkey-calls:

# # Load a few more functions and tie them to widgets, so they can be bound:

# function zrcautozle() {
# 	emulate -L zsh
# 	local fnc=$1
# 	zrcautoload $fnc && zle -N $fnc
# }

# function zrcgotwidget() {
# 	(( ${+widgets[$1]} ))
# }

# function zrcgotkeymap() {
# 	[[ -n ${(M)keymaps:#$1} ]]
# }

# # An array to note missing features to ease diagnosis in case of problems.
# typeset -ga grml_missing_features

# function zrcbindkey() {
# 	if (( ARGC )) && zrcgotwidget ${argv[-1]}; then
# 		bindkey "$@"
# 	fi
# }

# function bind2maps () {
# 	local i sequence widget
# 	local -a maps

# 	while [[ "$1" != "--" ]]; do
# 		maps+=( "$1" )
# 		shift
# 	done
# 	shift

# 	if [[ "$1" == "-s" ]]; then
# 		shift
# 		sequence="$1"
# 	else
# 		sequence="${key[$1]}"
# 	fi
# 	widget="$2"

# 	[[ -z "$sequence" ]] && return 1

# 	for i in "${maps[@]}"; do
# 		zrcbindkey -M "$i" "$sequence" "$widget"
# 	done
# }

# if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
# 	function zle-smkx () {
# 		emulate -L zsh
# 		printf '%s' ${terminfo[smkx]}
# 	}
# 	function zle-rmkx () {
# 		emulate -L zsh
# 		printf '%s' ${terminfo[rmkx]}
# 	}
# 	function zle-line-init () {
# 		zle-smkx
# 	}
# 	function zle-line-finish () {
# 		zle-rmkx
# 	}
# 	zle -N zle-line-init
# 	zle -N zle-line-finish
# else
# 	for i in {s,r}mkx; do
# 		(( ${+terminfo[$i]} )) || grml_missing_features+=($i)
# 	done
# 	unset i
# fi

# # create a zkbd compatible hash;
# # to add other keys to this hash, see: man 5 terminfo
# typeset -A key
# key=(
# 	Home     "${terminfo[khome]}"
# 	End      "${terminfo[kend]}"
# 	Insert   "${terminfo[kich1]}"
# 	Delete   "${terminfo[kdch1]}"
# 	Up       "${terminfo[kcuu1]}"
# 	Down     "${terminfo[kcud1]}"
# 	Left     "${terminfo[kcub1]}"
# 	Right    "${terminfo[kcuf1]}"
# 	PageUp   "${terminfo[kpp]}"
# 	PageDown "${terminfo[knp]}"
# 	BackTab  "${terminfo[kcbt]}"
# )

# # Guidelines for adding key bindings:
# #
# #   - Do not add hardcoded escape sequences, to enable non standard key
# #     combinations such as Ctrl-Meta-Left-Cursor. They are not easily portable.
# #
# #   - Adding Ctrl characters, such as '^b' is okay; note that '^b' and '^B' are
# #     the same key.
# #
# #   - All keys from the $key[] mapping are obviously okay.
# #
# #   - Most terminals send "ESC x" when Meta-x is pressed. Thus, sequences like
# #     '\ex' are allowed in here as well.

# bind2maps emacs             -- Home   beginning-of-somewhere
# bind2maps       viins vicmd -- Home   vi-beginning-of-line
# bind2maps emacs             -- End    end-of-somewhere
# bind2maps       viins vicmd -- End    vi-end-of-line
# bind2maps emacs viins       -- Insert overwrite-mode
# bind2maps             vicmd -- Insert vi-insert
# bind2maps emacs             -- Delete delete-char
# bind2maps       viins vicmd -- Delete vi-delete-char
# bind2maps emacs viins vicmd -- Up     up-line-or-search
# bind2maps emacs viins vicmd -- Down   down-line-or-search
# bind2maps emacs             -- Left   backward-char
# bind2maps       viins vicmd -- Left   vi-backward-char
# bind2maps emacs             -- Right  forward-char
# bind2maps       viins vicmd -- Right  vi-forward-char
# bind2maps       viins vicmd -- Right  vi-forward-char
# #k# Perform abbreviation expansion
# bind2maps emacs viins       -- -s '^x.' zleiab
# #k# Display list of abbreviations that would expand
# bind2maps emacs viins       -- -s '^xb' help-show-abk
# #k# mkdir -p <dir> from string under cursor or marked area
# bind2maps emacs viins       -- -s '^xM' inplaceMkDirs
# #k# display help for keybindings and ZLE
# bind2maps emacs viins       -- -s '^xz' help-zle
# #k# Insert files and test globbing
# bind2maps emacs viins       -- -s "^xf" insert-files
# #k# Edit the current line in \kbd{\$EDITOR}
# bind2maps emacs viins       -- -s '\ee' edit-command-line
# #k# search history backward for entry beginning with typed text
# bind2maps emacs viins       -- -s '^xp' history-beginning-search-backward-end
# #k# search history forward for entry beginning with typed text
# bind2maps emacs viins       -- -s '^xP' history-beginning-search-forward-end
# #k# search history backward for entry beginning with typed text
# bind2maps emacs viins       -- PageUp history-beginning-search-backward-end
# #k# search history forward for entry beginning with typed text
# bind2maps emacs viins       -- PageDown history-beginning-search-forward-end
# bind2maps emacs viins       -- -s "^x^h" commit-to-history
# #k# Kill left-side word or everything up to next slash
# bind2maps emacs viins       -- -s '\ev' slash-backward-kill-word
# #k# Kill left-side word or everything up to next slash
# bind2maps emacs viins       -- -s '\e^h' slash-backward-kill-word
# #k# Kill left-side word or everything up to next slash
# bind2maps emacs viins       -- -s '\e^?' slash-backward-kill-word
# # Do history expansion on space:
# bind2maps emacs viins       -- -s ' ' magic-space
# #k# Trigger menu-complete
# bind2maps emacs viins       -- -s '\ei' menu-complete  # menu completion via esc-i
# #k# Insert a timestamp on the command line (yyyy-mm-dd)
# bind2maps emacs viins       -- -s '^ed' insert-datestamp
# #k# Insert last typed word
# bind2maps emacs viins       -- -s "\em" insert-last-typed-word
# #k# A smart shortcut for \kbd{fg<enter>}
# bind2maps emacs viins       -- -s '^z' grml-zsh-fg
# #k# prepend the current command with "sudo"
# bind2maps emacs viins       -- -s "^os" sudo-command-line
# #k# jump to after first word (for adding options)
# bind2maps emacs viins       -- -s '^x1' jump_after_first_word
# #k# complete word from history with menu
# bind2maps emacs viins       -- -s "^x^x" hist-complete

# # insert unicode character
# # usage example: 'ctrl-x i' 00A7 'ctrl-x i' will give you an §
# # See for example http://unicode.org/charts/ for unicode characters code
# #k# Insert Unicode character
# bind2maps emacs viins       -- -s '^xi' insert-unicode-char

# # use the new *-pattern-* widgets for incremental history search
# if zrcgotwidget history-incremental-pattern-search-backward; then
# 	for seq wid in '^r' history-incremental-pattern-search-backward \
# 				   '^s' history-incremental-pattern-search-forward
# 	do
# 		bind2maps emacs viins vicmd -- -s $seq $wid
# 	done
# fi

# if zrcgotkeymap menuselect; then
# 	#m# k Shift-tab Perform backwards menu completion
# 	bind2maps menuselect -- BackTab reverse-menu-complete

# 	#k# menu selection: pick item but stay in the menu
# 	bind2maps menuselect -- -s '\e^M' accept-and-menu-complete
# 	# also use + and INSERT since it's easier to press repeatedly
# 	bind2maps menuselect -- -s '+' accept-and-menu-complete
# 	bind2maps menuselect -- Insert accept-and-menu-complete

# 	# accept a completion and try to complete again by using menu
# 	# completion; very useful with completing directories
# 	# by using 'undo' one's got a simple file browser
# 	bind2maps menuselect -- -s '^o' accept-and-infer-next-history
# fi

# # Finally, here are still a few hardcoded escape sequences; Special sequences
# # like Ctrl-<Cursor-key> etc do suck a fair bit, because they are not
# # standardised and most of the time are not available in a terminals terminfo
# # entry.
# #
# # While we do not encourage adding bindings like these, we will keep these for
# # backward compatibility.

# ## use Ctrl-left-arrow and Ctrl-right-arrow for jumping to word-beginnings on
# ## the command line.
# # URxvt sequences:
# bind2maps emacs viins vicmd -- -s '\eOc' forward-word
# bind2maps emacs viins vicmd -- -s '\eOd' backward-word
# # These are for xterm:
# bind2maps emacs viins vicmd -- -s '\e[1;5C' forward-word
# bind2maps emacs viins vicmd -- -s '\e[1;5D' backward-word
# ## the same for alt-left-arrow and alt-right-arrow
# # URxvt again:
# bind2maps emacs viins vicmd -- -s '\e\e[C' forward-word
# bind2maps emacs viins vicmd -- -s '\e\e[D' backward-word
# # Xterm again:
# bind2maps emacs viins vicmd -- -s '^[[1;3C' forward-word
# bind2maps emacs viins vicmd -- -s '^[[1;3D' backward-word
# # Also try ESC Left/Right:
# bind2maps emacs viins vicmd -- -s '\e'${key[Right]} forward-word
# bind2maps emacs viins vicmd -- -s '\e'${key[Left]}  backward-word

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}" beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}" end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}" delete-char
#[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}" up-line-or-history
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}" history-beginning-search-backward
#[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}" down-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}" history-beginning-search-forward
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}" backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}" forward-char
#[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}" beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
	function zle-line-init () {
		printf '%s' "${terminfo[smkx]}"
	}
	function zle-line-finish () {
		printf '%s' "${terminfo[rmkx]}"
	}
	zle -N zle-line-init
	zle -N zle-line-finish
fi

bindkey -e
# for xfce4-terminal
bindkey '^[[1;5D' emacs-backward-word
bindkey '^[[1;5C' emacs-forward-word
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward
# bindkey '^[[5~' history-beginning-search-backward
# bindkey '^[[6~' history-beginning-search-forward
bindkey '^[[1;3D' backward-delete-word
bindkey '^[[1;3C' kill-line

#--------------------
# WINDOW TITLE
#--------------------
shell=`echo $SHELL | sed 's/.*\///g'`
#echo $shell
if [ $shell = 'zsh' ]
then
	case $TERM in
		 rxvt|*term)
		 precmd() { print -Pn "\e]0;%m:%~\a" }
		 preexec() { print -Pn "\e]0;%m:$1\a" }
		 ;;
	esac
fi

#case $TERM in
	#termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
		#precmd () {
			#vcs_info
			#print -Pn "\e]0;[%n@%M][%~]%#\a"
		#}
		#preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
	#;;
	#screen|screen-256color)
		#precmd () {
			#vcs_info
			#print -Pn "\e]83;title \"$1\"\a"
			#print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
		#}
		#preexec () {
			#print -Pn "\e]83;title \"$1\"\a"
			#print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
		#}
	#;;
#esac

#--------------------
# ALIASES
#--------------------
# make aliases available with sudo
#alias sudo='nocorrect sudo '
alias sudo='sudo '

# color output
alias ls='ls --color=auto'
alias grep='grep --color'
alias cdiff='colordiff'

# ls
alias l='ls'
alias la='ls -a'
alias ll='ls -lh --time-style=long-iso'
alias lla='ll -a'
alias l.='ls -d .*'
alias lt='ls -lrth --time-style=long-iso'
# recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
alias lf='ls -Gl | grep ^d' # only list directories
alias ld='ls -Gal | grep ^d' # only list directories, including hidden ones

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# tools
alias cl='clear && reset'
alias xx='exit'
alias du="du -sh"
alias cal='cal -NMb'
alias tf='tail -f'
alias pp='pwd'
alias le='less'

alias hh='history'
# history search
alias hs='history | grep -i --color'
# most used commands
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# be careful
alias rm='rm -I'
alias mv='mv -i'

# packages management
# apt-get & dpkg
alias maj='sudo apt-get update && sudo apt-get upgrade'
function pksearch() { apt-cache search $1 | sort; }
alias pkshow='apt-cache show'
alias pk='dpkg --get-selections | grep -i'
alias repos='grep -rE "^deb " /etc/apt/sources.list /etc/apt/sources.list.d/*.list | sed "s/^.*:\/\///g"'
# pacman
# synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacupg='sudo pacman -Syu'
# install specific package(s) from the repositories
alias pacin='sudo pacman -S'
# install specific package not from the repositories but from a file
alias pacins='sudo pacman -U'
# remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacre='sudo pacman -R'
# remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrem='sudo pacman -Rns'
# display information about a given package in the repositories
alias pacrep='pacman -Si'
# search for package(s) in the repositories
alias pacreps='pacman -Ss'
# display information about a given package in the local database
alias pacloc='pacman -Qi'
# search for package(s) in the local database
alias paclocs='pacman -Qs'
# update and refresh the local package and ABS databases against repositories
alias pacupd='sudo pacman -Sy && sudo abs'
# install given package(s) as dependencies of another package
alias pacinsd='sudo pacman -S --asdeps'
# force refresh of all package lists after updating /etc/pacman.d/mirrorlist
alias pacmir='sudo pacman -Syy'

# applications
alias vv='vim'
alias vvrc='vim $HOME/.vimrc'
alias jc='javac'
alias jj='java'
alias za='zathura'
alias oo='xdg-open'

# admin
# list all users
# could also use 'lastlog | sort -bd'
alias listusers='cut -d: -f1 /etc/passwd | sort -bd'
# list all groups
#alias listgroups='cut -d: -f1 /etc/group | sort -bd'

# network
# get private ip
#alias privateip="/sbin/ifconfig | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}'"
alias privateip="ip addr show eth0 | grep 'inet '"
## get public ip
alias publicip="wget -qO- http://ipecho.net/plain; echo"
# show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'
# identify and search for active network connections
#spy () { lsof -i -P +c 0 +M | grep -i "$1" }
# list current IP on your network
alias listips='nmap -sP 192.168.2.0/24'
# Connection state totals
#function constats()
#{
#	netstat -nat | awk '{print $6}' | sort | uniq -c | sort -n
#}
# get tcp opened ports and PID/Process associate
alias ports='netstat -anop | grep -i list | grep tcp'

# fun
# fortune + cowsay
alias cow='fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)'
# random git commit message
alias rgc='git commit -m "`curl -s http://whatthecommit.com/index.txt`"'

#--------------------
# Additional stuff
#--------------------
if [[ -f $HOME/.albrc ]]; then source $HOME/.albrc; fi
if [[ -f $HOME/.machines ]]; then source $HOME/.machines; fi
