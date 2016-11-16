export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_OVERLAY_SCROLLING=0

# keyboard setup

setxkbmap -option compose:ralt
setxkbmap -layout us,ru -option grp:alt_space_toggle,grp_led:caps
xmodmap ~/.Xmodmap
xcape
echo 2 | sudo tee /sys/module/hid_apple/parameters/fnmode &

# autostart

pstate-frequency -S -p 2 &
nice -n 19 ionice -c3 sh -c '/usr/share/gopreload/bin/StartPreload.sh' &
xcalib ~/.local/share/icc/color.icc &
dunst &
compton -b &
clipit &
cbatticon &
dhcpcd-gtk &
~/.fehbg &

# WM start

exec i3
