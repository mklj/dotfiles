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
#[ $BASH_VERSINFO -ge 4 ] && shopt -s autocd

# echo-builtin command expands backslash-escape sequences by default
# (POSIX, SUS, XPG)
shopt -s xpg_echo

# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend
# reedit a history substitution line if it failed
shopt -s histreedit
# edit a recalled history line before executing
#shopt -s histverify
# Save multi-line commands as one command
shopt -s cmdhist

# try to keep environment pollution down, EPA loves us
unset safe_term match_lhs

## intercept the non-zero return code of last program
#EC() { echo -e '\e[1;33m'code $?'\e[m\n'; }
#trap EC ERR

# * matches  any  string,  including the null string.  When the globstar shell
# option is enabled, and * is used in a pathname expansion context, two
# adjacent *s used as a single pattern will match all files and zero or more
# directories and subdirectories.  If followed by a /, two adjacent *s will
# match only directories and subdirectories.
[ $BASH_VERSINFO -ge 4 ] && shopt -s globstar
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# If set, Bash lists the status of any stopped and running jobs before exiting
# an interactive shell. If any jobs are running, this causes the exit to be
# deferred until a second exit is attempted without an intervening command. The
# shell always postpones exiting if any jobs are stopped.
# Available only in interactive shells.
[ $BASH_VERSINFO -ge 4 ] && shopt -s checkjobs

# ==============================================================================
# FUNCTIONS
# ==============================================================================

# terminal title
# http://www.davidpashley.com/articles/xterm-titles-with-bash/
# If set, any traps on DEBUG and RETURN are inherited by shell functions,
# command substitutions, and commands executed in a subshell environment. The
# DEBUG and RETURN traps are normally not inherited in such cases.
#set -o functrace
show_name() {
	#if [[ -n "$BASH_COMMAND" ]]
	#then
		#set -o functrace
    trap 'echo -ne "\033]0;${USER}@${HOSTNAME}\007"' DEBUG
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
colors()
{
	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"
	declare -a FG=('' '1' '4' '5' '7' '30' '31' '32' \
	'33' '34' '35' '36' '37') ;

	echo

    # example text (>= 3 characters)
	local text=" Bash " ;
    # horizontal header
	printf "FG \ BG\t%${#text}s" ;
	for bg in {40..47} ; do
		printf "%${#text}s" "${bg}  " ;
	done
	echo ;

	for fg in ${!FG[*]} ; do
		echo -ne "${FG[fg]}\t\033[${FG[fg]}m$text" ;
		for bg in {40..47} ; do
			echo -ne "\033[${FG[fg]};${bg}m$text\033[0m" ;
		done
		echo ;
	done
}

# colors_tput - Demonstrate color combinations.
colors_tput()
{
    for fg_color in {0..7}; do
        set_foreground=$(tput setaf $fg_color)
        for bg_color in {0..7}; do
            set_background=$(tput setab $bg_color)
            echo -n $set_background$set_foreground
            printf ' F:%s B:%s ' $fg_color $bg_color
        done
        echo $(tput sgr0)
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
	local red='\[\e[0;91m\]'
	local purple='\[\e[0;35m\]'
	local bg_red='\[\e[41m\]'
	local bg_grey='\[\e[7;37m\]'

	# user color
	if [[ $UID -eq 0 ]]; then
		user_color=$red
    else
		user_color=$yellow
	fi
	# server color
	if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
		machine_color=$bg_grey
	else
		machine_color=$yellow
	fi

	PS1="\n $user_color[\$?] \u@\h:\w \\$\[\e[0m\] "
}
# also, make sure all terminals save history
PROMPT_COMMAND='history -a; show_name; set_prompt;'

# support colors in less
# To customize the colors, see Wikipedia:ANSI escape code for reference
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
alias l='ll'
alias ll='ls -lh --time-style=long-iso'
alias la='l -A'
alias lt='l -rt'
alias l.='l -d .*'
# only list directories
alias ld='l | grep --color=never ^d'
# only list directories, including hidden ones
alias lda='la | grep --color=never ^d'
# recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# function: cd then ls
cdd() { builtin cd "$*" && ls; }

## TOOLS
alias reload="source $HOME/.bashrc"
alias rr='reset'
alias xx='exit'
alias du='du -h'
#alias cal='cal -NMb'
alias tf='tail -f'
pss() { ps -eo euser,ruser,pid,ppid,lstart,stat,args | grep -v grep| grep -E "EUSER|$1"; }
alias psleep='ps -eo ppid,pid,user,stat,pcpu,comm,wchan:32'
highlight() { grep --color -E "$1|*"; }
alias hl='highlight'
alias trim='tr -s "\t" " "'

alias hh='history'
# history search
alias hs='history | grep -i --color=auto'
# most used commands
alias freq='cut -f1 -d" " ~/.bash_history | sort | uniq -c | sort -nr | head -n 30'
alias j='jobs -l'

# be careful
alias rm='rm -I'
alias mv='mv -i'

# color output
alias grep='grep --color'
alias egrep='egrep --color'
alias cdiff='colordiff'

## APPLICATIONS
alias vir='vim -R'
alias za='zathura'
alias o='less'
alias oo='xdg-open'

## screen
alias sls='screen -ls'
alias sr='screen -r'

## ADMIN
# list all users
# could also use 'lastlog | sort -bd'
alias listusers='cut -d: -f1 /etc/passwd | sort -bd'
#  list all groups
alias listgroups='cut -d: -f1 /etc/group | sort -bd'
alias lsblk_my='lsblk -mio NAME,KNAME,MAJ:MIN,FSTYPE,MOUNTPOINT,LABEL,UUID,SIZE,STATE,MODE,TYPE'

## NETWORK
## get private ip
#alias privateip="/sbin/ifconfig | grep 'inet addr' | awk -F: '{print $2}' | awk '{print $1}'"
alias privateip="ip addr show eth0 | grep 'inet '"
## get public ip
alias publicip='curl ipinfo.io/ip'
# show active network listeners
alias netlisteners='lsof -i -P | grep LISTEN'
# identify and search for active network connections
#spy () { lsof -i -P +c 0 +M | grep -i "$1" }
# list current IP on your network
alias listips='nmap -sP 192.168.2.0/24'
# Connection state totals
#constats()
#{
#	netstat -nat | awk '{print $6}' | sort | uniq -c | sort -n
#}
# get tcp opened ports and PID/Process associate
alias ports='netstat -anop | grep -i list | grep tcp'

# ==============================================================================
# ADDITIONAL STUFF
# ==============================================================================

include_file()
{
    [[ ! -r "$1" ]] && return 2
	source "$1"
}

