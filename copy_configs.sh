#!/bin/bash

# configuring the bash shell
newFile="$HOME/.bash_customisation"
cp config_files/bashrc ~/.bashrc
cp config_files/bash_customisation "$newFile"

# configuring alacritty
mkdir -p ~/.config/alacritty
if [ -z "$(ls ~/.config/alacritty)" ]; then
    wget https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/blood_moon.toml -O ~/.config/alacritty/alacritty.toml
fi

# configuring i3
if [ "$XDG_SESSION_TYPE" = "x11" ]
then
	mkdir -p $HOME/.config/i3
	cp config_files/i3/config $HOME/.config/i3/config
fi

# configuring sway
if [ "$XDG_SESSION_TYPE" = "wayland" ]
then
	mkdir -p $HOME/.config/sway $HOME/.config/waybar
	cp config_files/sway/config $HOME/.config/sway/config
    cp config_files/waybar/config $HOME/.config/waybar/config
    cp config_files/waybar/style.css $HOME/.config/waybar/style.css

    swaymsg reload
fi

# configure vim
cp config_files/vimrc ~/.vimrc

# configure zathura (PDF viewer)
mkdir -p $HOME/.config/zathura
cp config_files/zathurarc $HOME/.config/zathura/zathurarc

