#!/bin/bash
killall lisgd
DEVICE=$(libinput list-devices | grep -A2 "IPTSD Virtual Touchscreen" | grep "Kernel" | awk '{print $2}')
lisgd -d $DEVICE \
    -g "3,DU,*,*,R,WAYLAND_DISPLAY=$WAYLAND_DISPLAY XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR nwggrid"
