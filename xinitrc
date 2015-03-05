#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

## update x resources db
#xrdb -merge ~/.Xresources         

## compton - composite manager
#compton --config ~/.config/compton.conf -b &

## numlock
#numlockx &

## xbindkeys
#xbindkeys

## MPD daemon start (if no other user instance exists)
[ ! -s ~/.mpd/pid ] && mpd

# exec gnome-session
#exec startkde
exec startxfce4
# ...or the Window Manager of your choice
#exec dbus-launch openbox-session
#exec awesome
#exec i3
#exec openbox-session
