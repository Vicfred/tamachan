# vim: syntax=bash
# if dead keys are not working emerge x11-apps/setxkbmap
# xim, then ibus then @im=ibus make ibus work on firefox,
# chrome, telegram and the terminal.
export GTK_IM_MODULE="xim"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"
ibus-daemon -d -x -r -n awesome

xscreensaver -no-splash &
xset r off
numlockx &
/home/vicfred/.misato/wallpaper-changer.sh &
setxkbmap -option compose:ralt -option caps:swapescape

#if [ -s ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
#fi
#
exec awesome
