# vim: syntax=bash
# if dead keys are not working emerge x11-apps/setxkbmap
# xim, then ibus then @im=ibus make ibus work on firefox,
# chrome, telegram and the terminal.
if [ -x "$(command -v ibus-daemon)" ]; then
    export GTK_IM_MODULE="xim"
    export QT_IM_MODULE="ibus"
    export XMODIFIERS="@im=ibus"
    ibus-daemon -d -x -r -n awesome
fi
if [ -x "$(command -v xscreensaver)" ]; then
    xscreensaver -no-splash &
fi
if [ -x "$(command -v xset)" ]; then
    xset r off
fi
if [ -x "$(command -v numlockx)" ]; then
    numlockx &
fi
if [ -x "$(command -v setxkbmap)" ]; then
    setxkbmap -option compose:ralt -option caps:swapescape
fi
if [ -x /home/vicfred/.misato/wallpaper-changer.sh ]; then
    /home/vicfred/.misato/wallpaper-changer.sh &
fi
#if [ -s ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
#fi
#
if [ -x "$(command -v awesome)" ]; then
    exec awesome
fi
