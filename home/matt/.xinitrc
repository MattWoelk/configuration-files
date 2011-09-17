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
xinput set-prop "SynPS/2 Synaptics TouchPad" "Device Enabled" 0

#get special keys to work (mute, volume, etc.)
xbindkeys &

#start up a vnc server
#echo %%% START VLC
/usr/bin/x11vnc -nap -noxdamage -forever -o /var/log/x11vnc.log -bg &

#start artha (ctrl+alt+w)
#echo %%% ARTHA
artha &

#start the vlc http server so that i can start music with my phone.
#echo %%% VLC
vlc -I http &

#start up a terminal so that I know the window manager has started
xterm&

#start up nm-applet and stalonetray
(sleep 3 && /usr/bin/nm-applet --sm-disable) &
stalonetray > /dev/null 2>/dev/null &

#start dropbox
#echo %%% DROPBOX
(sleep 10 && dropboxd) &

#start up window manager
exec ck-launch-session xmonad
#exec qtile # This hasn't yet worked
