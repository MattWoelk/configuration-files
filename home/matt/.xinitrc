# Fix the fighting between libreoffice and xmonad when a dialog box (example, Ctrl-O) is opened,
# and focus is switched away from it using the mouse.
export SAL_USE_VCLPLUGIN=gen

#remap caps lock to control
#echo %%% CAPS LOCK TO CTRL
xmodmap -e 'remove Lock = Caps_Lock'
xmodmap -e 'keysym Caps_Lock = Control_L'
xmodmap -e 'add Control = Control_L'
# use the menu key as a compose key (so i can type menu+(`,a) to input an accented a)
#   list of characters and combinations is located in /usr/share/X11/locale/en_US.UTF-8/Compose
xmodmap -e 'keycode 135 = Multi_key'

#use the windows key as a level 3 modifier (chooser key). 
#  THIS IS NOT YET CONFIRMED TO WORK
#xmodmap -e 'keycode 133 = ISO_Level3_Shift'
# this broke stuff, and didn't seem to do anything of its own...

# set the key delay and repeat rate (in milliseconds) to be nicer
xset r rate 330 20

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

#start up a vnc server
#echo %%% START VLC
#echo GOT HERE a
/usr/bin/x11vnc -nap -noxdamage -forever -o /var/log/x11vnc.log -bg -passwd prossward &

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
#volumeicon &
pnmixer & #pretty much the same, but has direct access to pavucontrol, which I really like. :)

#get special keys to work (mute, volume, etc.)
(sleep 5 && xbindkeys) &

#start artha (ctrl+alt+w)
#echo %%% ARTHA
#echo GOT HERE b
artha &

#start network indicator lights
networkled wlan0 &

#start keynav (move the mouse and click with just the keyboard with Ctrl-;)
keynav &

#start dropbox
#echo %%% DROPBOX
#echo GOT HERE 3
(sleep 15 && dropboxd) &

#start statnot, which should catch desktop notifications or something
#(sleep 10 && statnot) &
# maybe try statnot later, but it was messing with dropbox pretty severely.

# twmnd - a daemon to show notifications. I'm not sure if it works yet.
(sleep 2 && twmnd) &

#start clipit, which sits in task bar and shows me clipboard history
clipit&

#start the tray
#(sleep 9 && trayer --edge left --SetDockType true --SetPartialStrut true --transparent true --alpha 0 --tint 0x080808) &
stalonetray -bg '#0C0C0C' --kludges force_icons_size --geometry 1x45&

# restart stalonetray after a while (because it's a weirdo)
# (sleep 10 && /home/matt/scripts/stalonetray.sh) &


#start daemon to watch for changed files on behalf of recoll
/usr/share/recoll/examples/rclmon.sh start &

#start program which auto-mounts usb sticks and optical drives (dvd, cd, etc.)
#udiskie &
# THIS IS NOW IN ~/.xmonad/autostart.sh

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
#####exec ck-launch-session xmonad
#exec ck-launch-session qtile
#exec qtile # This hasn't yet worked

case $WM in
kde)
  exec ck-launch-session startkde
  ;;
gnome)
  exec ck-launch-session gnome-session
  ;;
kde)
  exec ck-launch-session startkde
  ;;
lxde)
  ~/bin/lxde&
  exec ck-launch-session startlxde
  ;;
vb-ubuntu)
  VirtualBox -startvm "TSAT-Ubuntu-10.04" -fullscreen
  ;;
openbox)
  ~/bin/openbox&
  exec ck-launch-session openbox
  ;;
twm)
  exec ck-launch-session twm
  ;;
xmonad)
  exec ck-launch-session xmonad
  ;;
razor)
  exec ck-launch-session razor-session
  ;;
monsterwm)
  exec ck-launch-session monsterwm
  ;;
goomwwm)
  exec ck-launch-session goomwwm
  ;;
qtile)
  exec ck-launch-session qtile
  ;;
*)
  exec ck-launch-session xmonad
  ;;
esac
# could start window manager before other programs by using https://wiki.archlinux.org/index.php/Xinitrc#Starting_the_WM_first
