# author: mklj

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

# ==============================================================================
# SHELL OPTIONS
# ==============================================================================

# enable tab completion after sudo (conflicts with package bash-completion)
#complete -cf sudo

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# automatically prepend cd when entering just a path in the shell
shopt -s autocd

# echo-builtin command expands backslash-escape sequences by default
# (POSIX, SUS, XPG)
shopt -s xpg_echo

# append to the history file instead of overwrite it
shopt -s histappend

# try to keep environment pollution down, EPA loves us
unset safe_term match_lhs

## intercept the non-zero return code of last program
EC() { echo -e '\e[1;33m'code $?'\e[m\n'; }
trap EC ERR

## terminal title
## http://www.davidpashley.com/articles/xterm-titles-with-bash/
# If set, any traps on DEBUG and RETURN are inherited by shell functions,
# command substitutions, and commands executed in a subshell environment. The
# DEBUG and RETURN traps are normally not inherited in such cases.
#set -o functrace
function show_name {
	#if [[ -n "$BASH_COMMAND" ]]
	#then
		#set -o functrace
		trap 'echo -ne "\033]0;${HOSTNAME}\007"' DEBUG
		#trap 'echo -ne "\033]2;${HOSTNAME}: $(history 1 | sed "s/^[ ]*[0-9]*[ ]*//g")\007"' DEBUG
		#trap 'echo -ne "\033]0;${HOSTNAME}: ${BASH_COMMAND%% *}\007"' DEBUG
		#trap 'echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
		#trap 'echo -ne "\e]0;"; echo -n $HOSTNAME; echo -ne "\007"' DEBUG
	#fi
}

# ==============================================================================
# DOUBLE RAINBOW
# ==============================================================================

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
	eval "`dircolors -b`"
	alias ls='ls --color=auto'
fi

# The page at http://ascii-table.com/ansi-escape-sequences.php describes the 
# various available color escapes.
# The following Bash function displays a table with ready-to-copy escape codes.
colors()
{
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
	echo; echo
	done
}

function colors2()
{
	# Texte de l'exemple (>= 3 caracteres) :
	TEXT=" Bash " ;

	# Couleur du texte :
	declare -a FG=('' '1' '4' '5' '7' '30' '31' '32' \
	'33' '34' '35' '36' '37') ;

	echo 

	# Premiere ligne :
	printf "FG \ BG\t%${#TEXT}s" ;
	for bg in {40..47} ; do
		printf "%${#TEXT}s" "${bg}  " ;
	done
	echo ;

	# Creation du tableau de presentation des combinaisons :
	for fg in ${!FG[*]} ; do
		echo -ne "${FG[fg]}\t\033[${FG[fg]}m$TEXT" ;
		for bg in {40..47} ; do
			echo -ne "\033[${FG[fg]};${bg}m$TEXT\033[0m" ;
		done
		echo ;
	done
}

# styles and colors format: \e[{style};{color}m
# styles:
# 0	reset all attributes
# 1 bold/bright	
# 2	dim	
# 4	underlined	
# 5	blink	
# 7	reverse (invert the foreground and background colors)	
# 8	hidden (usefull for passwords)	
# 21 reset bold/bright	
# 22 reset dim	
# 24 reset underlined	
# 25 reset blink	
# 27 reset reverse	
# 28 reset hidden
# colors: normal
# 30 black
# 31 red
# 32 green
# 33 yellow
# 34 blue
# 35 purple
# 36 cyan
# 37 white
# colors: background
# black 40
# red 41
# green 42
# yellow 43
# blue 44
# purple 45
# cyan 46
# white 47
# colors:high intensity
# black 90
# red 91
# green 92
# yellow 93
# blue 94
# purple 95
# cyan 96
# white 97
# colors: high intensity backgrounds
# black 100
# red 101
# green 102
# blue 104
# purple 105
# cyan 106
# white 107

# Bash allows these prompt strings to be customized by inserting a
# number of backslash-escaped special characters that are
# decoded as follows:
# 
# 	\a		an ASCII bell character (07)
# 	\d		the date in "Weekday Month Date" format (e.g., "Tue May 26")
# 	\D{format}	the format is passed to strftime(3) and the result
# 			  is inserted into the prompt string an empty format
# 			  results in a locale-specific time representation.
# 			  The braces are required
# 	\e		an ASCII escape character (033)
# 	\h		the hostname up to the first `.'
# 	\H		the hostname
# 	\j		the number of jobs currently managed by the shell
# 	\l		the basename of the shell's terminal device name
# 	\n		newline
# 	\r		carriage return
# 	\s		the name of the shell, the basename of $0 (the portion following
# 			  the final slash)
# 	\t		the current time in 24-hour HH:MM:SS format
# 	\T		the current time in 12-hour HH:MM:SS format
# 	\@		the current time in 12-hour am/pm format
# 	\A		the current time in 24-hour HH:MM format
# 	\u		the username of the current user
# 	\v		the version of bash (e.g., 2.00)
# 	\V		the release of bash, version + patch level (e.g., 2.00.0)
# 	\w		the current working directory, with $HOME abbreviated with a tilde
# 	\W		the basename of the current working directory, with $HOME
# 			 abbreviated with a tilde
# 	\!		the history number of this command
# 	\#		the command number of this command
# 	\$		if the effective UID is 0, a #, otherwise a $
# 	\nnn		the character corresponding to the octal number nnn
# 	\\		a backslash
# 	\[		begin a sequence of non-printing characters, which could be used
# 			  to embed a terminal control sequence into the prompt
# 	\]		end a sequence of non-printing characters
# 
# 	The command number and the history number are usually different:
# 	the history number of a command is its position in the history
# 	list, which may include commands restored from the history file
# 	(see HISTORY below), while the command number is the position in
# 	the sequence of commands executed during the current shell session.
# 	After the string is decoded, it is expanded via parameter
# 	expansion, command substitution, arithmetic expansion, and quote
# 	removal, subject to the value of the promptvars shell option (see
# 	the description of the shopt command under SHELL BUILTIN COMMANDS
# 	below).

# reset

# to use in commands from your shell environment:
# $ echo -e "${ublue}test"
# Double quotes enable $color variable expansion and the \[ \] escapes around
# them make them not count as character positions and the cursor position is 
# not wrong.
# Note: If experiencing premature line wrapping when entering commands, then
# missing escapes (\[ \]) is most likely the reason.

set_prompt() {
	local color_off='\[\e[0m\]'   # text reset
	local yellow='\[\e[0;33m\]'
	local red='\[\e[0;37;41m\]'
	local bg_red='\[\e[41m\]'
	local bg_grey='\[\e[7;37m\]'

	# user color
	if [[ $UID -ge 1000 ]]; then
		user_color=$yellow
	elif [[ $UID -eq 0 ]]; then
		user_color=$bg_red
	fi
	# server color
	if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
		machine_color=$bg_grey
	else
		machine_color=$yellow
	fi

	PS1="\n $yellow\u@\h:\w \$ $color_off"
	#PS1="\n $user_color\u@$machine_color\h:$color_off\W \$ "
}
# also, make sure all terminals save history
PROMPT_COMMAND='history -a; show_name; set_prompt'

# colored man pages
# To customize the colors, see Wikipedia:ANSI escape code for reference
#man() {
#    env LESS_TERMCAP_mb=$'\e[01;31m' \
#    LESS_TERMCAP_md=$'\e[01;38;5;74m' \
#    LESS_TERMCAP_me=$'\e[0m' \
#    LESS_TERMCAP_se=$'\e[0m' \
#    LESS_TERMCAP_so=$'\e[38;5;246m' \
#    LESS_TERMCAP_ue=$'\e[0m' \
#    LESS_TERMCAP_us=$'\e[04;38;5;146m' \
#    man "$@"
#}

# support colors in less
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# ==============================================================================
# ALIASES
# ==============================================================================

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# if [ -f ~/.bash_aliases ]; then
# 	. ~/.bash_aliases
# fi

# make aliases available with sudo
alias sudo='sudo '

# ls
alias l='ls'
alias ll='ls -lh --time-style=long-iso'
alias l1='ls -1'
alias la='ls -a'
alias lla='ls -Alh --time-style=long-iso'
alias l.='ls -d .*'
alias lt='ls -lrth --time-style=long-iso'
# recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
alias ld='ls -Gl | grep ^d' # only list directories
alias lda='ls -Gal | grep ^d' # only list directories, including hidden ones

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# function: cd then ls
function cdd() { builtin cd "$*" && ls; }

## TOOLS
alias reload="source $HOME/.bashrc"
alias cl='clear && reset'
alias xx='exit'
alias du="du -sh"
alias cal='cal -NMb'
alias tf='tail -f'

alias hh='history'
# history search
alias hs='history | grep -i --color=auto'
# most used commands
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'

# be careful
alias rm='rm -I'
alias mv='mv -i'

# color output
alias grep='grep --color'
alias egrep='egrep --color'
alias cdiff='colordiff'

## PACKAGES MANAGEMENT
## apt-get & dpkg
alias maj='sudo apt-get update && sudo apt-get upgrade'	
function pksearch() { apt-cache search $1 | sort; }
alias pkshow='apt-cache show'
alias pk='dpkg --get-selections | grep -i'
alias repos='grep -rE "^deb " /etc/apt/sources.list /etc/apt/sources.list.d/*.list | sed "s/^.*:\/\///g"'
## pacman
alias pacupg='sudo pacman -Syu'        # Synchronize with repositories and then upgrade packages that are out of date on the local system.
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'           # Remove the specified     package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information abouta given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database
alias pacupd='sudo pacman -Sy && sudo abs'     # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps'        # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy'                # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist

## APPLICATIONS
alias vv='vim'
alias vvrc='vim $HOME/.vimrc'
alias jc='javac'
alias jj='java'
# urxvt
alias uu='urxvt'
alias za='zathura'
alias oo='xdg-open'

## ADMIN
# list all users
# could also use 'lastlog | sort -bd'
alias listusers='cut -d: -f1 /etc/passwd | sort -bd'
# list all groups
#alias listgroups='cut -d: -f1 /etc/group | sort -bd'

## NETWORK
## get private ip
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

## FUN
# fortune + cowsay
alias cow='fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1)'
# random git commit message
alias rgc='git commit -m "`curl -s http://whatthecommit.com/index.txt`"'

# ==============================================================================
# ADDITIONAL STUFF
# ==============================================================================

if [[ -f $HOME/.albrc ]]; then source $HOME/.albrc; fi
if [[ -f $HOME/.machines ]]; then source $HOME/.machines; fi
