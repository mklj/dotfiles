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

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# locales
LANGUAGE=en_US:en
LANG=en_US.UTF-8
LC_NUMERIC=fr_FR.UTF-8
LC_TIME=fr_FR.UTF-8
LC_MONETARY=fr_FR.UTF-8
LC_PAPER=fr_FR.UTF-8
LC_NAME=fr_FR.UTF-8
LC_ADDRESS=fr_FR.UTF-8
LC_TELEPHONE=fr_FR.UTF-8
LC_MEASUREMENT=fr_FR.UTF-8
LC_IDENTIFICATION=fr_FR.UTF-8
PAPERSIZE=a4

EDITOR=vim
PAGER=less

## history
HISTTIMEFORMAT='%F %T --- '
# HISTSIZE=450
# HISTFILESIZE=450
HISTCONTROL=erasedups
HISTIGNORE="pwd:l:ls:ll:la:lla"

# LESS OPTIONS
# -i : case-insensitive search unless uppercase letters are typed
LESS="-i"

#  Indicate preferred webbrowser for graphical or text terminal respectively
[ $DISPLAY ] && export BROWSER=google-chrome || export BROWSER=w3m
