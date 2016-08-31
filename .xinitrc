export QT_STYLE_OVERRIDE=GTK+
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_OVERLAY_SCROLLING=0
setxkbmap -option compose:ralt
setxkbmap -layout us,ru -option grp:alt_space_toggle,grp_led:caps
xmodmap ~/.Xmodmap
xcape
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode&
pstate-frequency -S -p 2&
#exec awesome
nice -n 19 ionice -c3 sh -c '/usr/share/gopreload/bin/StartPreload.sh'&
exec i3
