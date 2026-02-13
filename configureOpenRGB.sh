#!usr/bin/bash

sudo apt install openrgb

mkdir -p $HOME/.config/OpenRGB $HOME/.config/systemd/user
cp .config/OpenRGB/profile1.orp $HOME/.config/OpenRGB
cp .config/systemd/user/openrgb.service $HOME/.config/systemd/user 

systemctl --user daemon-reload
systemctl --user enable openrgb.service
systemctl --user start openrgb.service
