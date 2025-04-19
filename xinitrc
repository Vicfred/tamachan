# vim: syntax=bash
# if dead keys are not working emerge x11-apps/setxkbmap
# xim, then ibus then @im=ibus make ibus work on firefox,
# chrome, telegram and the terminal.
# CJK input
if [ -x "$(command -v ibus-daemon)" ]; then
    export GTK_IM_MODULE="xim"
    export QT_IM_MODULE="ibus"
    export XMODIFIERS="@im=ibus"
    ibus-daemon -d -x -r -n awesome
fi

# Turn on numlock
if [ -x "$(command -v numlockx)" ]; then
    numlockx &
fi

if [ -x "$(command -v nm-applet)" ]; then
    nm-applet &
fi

if [ -x "$(command -v blueman-applet)" ]; then
    blueman-applet &
fi

# need to install setxkbmap
# DEPRECATED:
# Configure using /etc/X11/xorg.conf.d/00-keyboard.conf
# if [ -x "$(command -v setxkbmap)" ]; then
# setxkbmap -option compose:ralt -option caps:swapescape
# fi

# Wallpaper changer
if [ -x /home/vicfred/.misato/wallpaper-changer.sh ]; then
    /home/vicfred/.misato/wallpaper-changer.sh &
fi

#if [ -s ~/.Xmodmap ]; then
#    xmodmap ~/.Xmodmap
#fi

# Start window manager
if [ -x "$(command -v awesome)" ]; then
    exec awesome
fi

