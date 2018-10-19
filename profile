# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# On Ubuntu variants, this file might not be sourced at login, as
# ~/.pam_environment seems to be preferred. In that case, symlinking helps:
# ln -s $HOME/.profile $HOME/.pam_environment

# About the 'export' command:
# export makes the variable available to sub-processes.
#
# export name=value means that the variable name is available to any process
# you run from that shell process. If you want a process to make use of this
# variable, use export, and run the process from that shell.
#
# name=value means the variable scope is restricted to the shell, and is not
# available to any other process. You would use this for (say) loop variables,
# temporary variables etc.
#
# It's important to note that exporting a variable doesn't make it available to
# parent processes. That is, specifying and exporting a variable in a spawned
# process doesn't make it available in the process that launched it.

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] && [ -z $(echo "$PATH" | grep -o "$HOME/bin") ]; then
        export PATH="$HOME/bin:${PATH}"
fi

# locales
export LANGUAGE=en_US:en
export LANG=en_US.UTF-8
export LC_NUMERIC=fr_FR.UTF-8
export LC_TIME=fr_FR.UTF-8
export LC_MONETARY=fr_FR.UTF-8
export LC_PAPER=fr_FR.UTF-8
export LC_NAME=fr_FR.UTF-8
export LC_ADDRESS=fr_FR.UTF-8
export LC_TELEPHONE=fr_FR.UTF-8
export LC_MEASUREMENT=fr_FR.UTF-8
export LC_IDENTIFICATION=fr_FR.UTF-8
export PAPERSIZE=a4
#export LC_ALL=

# history
# If the value of HISTCONTROL includes "ignorespace" or "ignoreboth", commands
# that begin with a space are omitted from history. If the value includes
# "ignore dups" or "ignoreboth", it's the same as "&" in HISTIGNORE
export HISTIGNORE='history:exit:clear:reset:pwd:?:??'
export HISTCONTROL='erasedups:ignoreboth'
export HISTTIMEFORMAT='%F %T - '
export HISTSIZE=500000
export HISTFILESIZE=$HISTSIZE

# LESS OPTIONS
export LESS='-iRn'
export SYSTEMD_LESS=FRXMK

# executables
export EDITOR=vim
export PAGER=less
[ -n "$DISPLAY" ] && export BROWSER=firefox || export BROWSER=w3m

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working
# directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it
# regardless of the directory you're in
shopt -s cdable_vars

# misc variables
export TODAY=$(date +%Y%m%d)

