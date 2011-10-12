#remap caps lock to control
#echo %%% CAPS LOCK TO CTRL
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'

#enable middle button scrolling
#echo %%% TRACKPOINT SCROLLING

xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
#echo TRACKPOINT SCROLLING1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
#echo TRACKPOINT SCROLLING2
#xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 8 200
xinput set-prop "TPPS/2 IBM TrackPoint" 267 1
#echo TRACKPOINT SCROLLING3
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5

#enable middle button by clicking both buttons
#echo %%% MIDDLE CLICK
#echo MIDDLE CLICK1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Emulation" 8 1
#echo MIDDLE CLICK2
#xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Middle Button Timeout" 8 50
xinput set-prop "TPPS/2 IBM TrackPoint" 263 50

#disable touchpad
#echo %%% DISABLE TOUCHPAD
(sleep 3 && xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0)

#get special keys to work (mute, volume, etc.)
xbindkeys &

#start up a vnc server
#echo %%% START VLC
#echo GOT HERE a
/usr/bin/x11vnc -nap -noxdamage -forever -o /var/log/x11vnc.log -bg &

#start the vlc http server so that i can start music with my phone.
#echo %%% VLC
#echo GOT HERE c
vlc -I http &

#start up a terminal so that I know the window manager has started
#echo GOT HERE d
urxvt -bg black -fg white +sb &

#start up nm-applet
#echo GOT HERE 1
(sleep 3 && /usr/bin/nm-applet --sm-disable) &
#echo GOT HERE 2

#put a clock in the systray:
trayclock &

#put battery indicator in the systray:
qbat &

#put volume indicator in the systray:
volumeicon &

#start artha (ctrl+alt+w)
#echo %%% ARTHA
#echo GOT HERE b
artha &

#start network indicator lights
networkled wlan0 &

#start dropbox
#echo %%% DROPBOX
#echo GOT HERE 3
(sleep 15 && dropboxd) &

#start the tray
#(sleep 9 && trayer --edge left --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x080808) &
stalonetray -bg '#0C0C0C' &

#start daemon to watch for changed files on behalf of recoll
/usr/share/recoll/examples/rclmon.sh start &

#start program which auto-mounts usb sticks and optical drives (dvd, cd, etc.)
devmon & 

#start dbus or something??? (https://wiki.archlinux.org/index.php/Dbus)
# Source scripts in /etc/X11/xinit/xinitrc.d/
###if [ -d /etc/X11/xinit/xinitrc.d ]; then
###  for f in /etc/X11/xinit/xinitrc.d/*; do
###    [ -x "$f" ] && . "$f"
###  done
###  unset f
###fi

#start up window manager
#echo GOT HERE 4
exec ck-launch-session xmonad
#exec ck-launch-session qtile
#exec qtile # This hasn't yet worked

# could start window manager before other programs by using https://wiki.archlinux.org/index.php/Xinitrc#Starting_the_WM_first
