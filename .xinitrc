export QT_STYLE_OVERRIDE=GTK+
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_OVERLAY_SCROLLING=0
setxkbmap -option compose:ralt
setxkbmap -layout us,ru -option grp:alt_space_toggle,grp_led:caps
xmodmap ~/.Xmodmap
sudo tee /sys/module/hid_apple/parameters/fnmode <<< 2
pstate-frequency -S -p 2 
#exec awesome
exec i3
