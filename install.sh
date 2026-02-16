#!/bin/bash

#####################
# installing software
#####################

function printHeader () {
    echo -e "\e[34m${1}\e[0m"
}

# the following sudo install and configuration is not necessary if
# you opted to lock the root user and automatically add your user
# to the sudoers file
# https://wiki.debian.org/sudo?action=show&redirect=Sudo
# username="markus"
# apt install sudo
# sudo adduser $username sudo

CPU_ARCHITECTURE="`uname -m`"
echo "Detected CPU-architecture: $CPU_ARCHITECTURE"

programs=(
    "lightdm"  # login manager
    "sway"
    "waybar"
    "swaylock"
    "fonts-font-awesome"
    "fonts-fork-awesome"
    "fonts-material-design-icons-iconfont"
    "fonts-noto-color-emoji"
    "xwayland"  # for X11 compatablility (e.g.: for feh)
	"firefox-esr"
	"thunderbird"
    "mako-notifier"
    "lxappearance"  # to switch to dark mode (might require installation of gnome-themes-extra)
                    # lxappearance edits ~/.config/gtk-3.0/settings.ini
    "alacritty"
    "build-essential"
    "git"
    "gh"
    "curl"
    "freecad"
    "ldraw-parts-free"  # Consider ldraw-parts which seems to contain more parts.
    "texstudio"
    "keepassxc"
    "feh"
    "mpv"
    "zip"
    "xournalpp"
    "latexmk"
    "zathura"
    "cups"
    "rsync"
    "vim"
    "nodejs"  # for vim plugins
    "npm"  # for vim plugins
    "clangd"  # for vim C++ language server
    "vim-gtk3"  # for vim copying to things like firefox
    "golang"  # for vim YouCompleteMe
    "pipewire"  # bluetooth
    "libspa-0.2-bluetooth"  # bluetooth
    "wget"
    "htop"
    "grim"  # for screenshots
    "slurp"  # to select regions for screenshots
)
sudo apt update
sudo apt install "${programs[@]}" -y

# setup Bluetooth
sudo apt purge pulseaudio-module-bluetooth -y

if [ "$CPU_ARCHITECTURE" = "x86_64" ]; then
    # https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_13_.22Trixie.22
    printHeader "installing nvidia drivers"
    echo "deb http://deb.debian.org/debian/ bookworm contrib non-free">"/etc/apt/sources.list.d/nvidia.list"
    sudo apt update
    sudo apt install nvidia-detect -y
    result=$(nvidia-detect)
    if [ "$result" = "No NVIDIA GPU detected." ]; then
        echo $result
    else
        sudo apt install nvidia-driver firmware-misc-nonfree
    fi

    # https://signal.org/download/linux/
    printHeader "installing signal"
    wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;
    cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
    wget -O signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources;
    cat signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null
    rm -f signal-desktop.sources signal-desktop-keyring.gpg
    sudo apt update && sudo apt install signal-desktop
fi

# https://code.visualstudio.com/docs/setup/linux
printHeader "installing VS Code"
#echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt-get install gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg
sudo cat << EOF | sudo tee /etc/apt/sources.list.d/vscode.sources
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y # or code-insiders


#############
# configuring
#############

# configuring the bash shell
newFile="$HOME/.bash_customisation"
cp .bashrc ~/.bashrc

# get jetbrains mono font
font_dir=$HOME/.local/share/fonts
working_dir=$(pwd)
mkdir -p $font_dir
cd $font_dir
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz
rm JetBrainsMono.tar.xz
fc-cache -fv
cd $working_dir

# configuring alacritty
alacritty_dir=$HOME/.config/alacritty
mkdir -p $alacritty_dir
if [ -z "$(ls $alacritty_dir)" ]
then
    wget https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/blood_moon.toml -O $alacritty_dir/alacritty.toml
    echo -e '\n[font]' >> $alacritty_dir/alacritty.toml
    echo 'normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }' >> $alacritty_dir/alacritty.toml
    echo 'bold = { family = "JetBrainsMono Nerd Font", style = "Bold" }' >> $alacritty_dir/alacritty.toml
    echo 'italic = { family = "JetBrainsMono Nerd Font", style = "Italic" }' >> $alacritty_dir/alacritty.toml
    echo 'size = 11' >> $alacritty_dir/alacritty.toml
fi

# configuring sway
mkdir -p $HOME/.config/sway $HOME/.config/waybar
cp .config/sway/config $HOME/.config/sway/config
cp .config/waybar/config $HOME/.config/waybar/config
cp .config/waybar/style.css $HOME/.config/waybar/style.css
if [ "$XDG_SESSION_TYPE" = "wayland" ]
then
    swaymsg reload
fi

# configure vim
cp .config/vimrc ~/.vimrc

# configure zathura (PDF viewer)
mkdir -p $HOME/.config/zathura
cp .config/zathurarc $HOME/.config/zathura/zathurarc

# configure mako notification manager
mkdir -p $HOME/.config/mako
cp .config/mako/config $HOME/.config/mako/config


##########################
# removing GNOME bloatware
##########################

# List of GNOME games to remove
gnome_games=(
    "aisleriot"       # Solitaire Card Games
    "gnome-mahjongg"  # Mahjongg game
    "gnome-mines"     # Minesweeper game
    "gnome-sudoku"    # Sudoku game
    "gnome-klotski"   # Klotski sliding puzzle game
    "gnome-nibbles"   # Nibbles game
    "gnome-robots"    # Robots game
    "gnome-tetravex"  # Tetravex puzzle game
    "quadrapassel"    # Tetris-like game
    "lightsoff"       # Lights Off puzzle game
    "swell-foop"      # Space-themed game
    "tali"            # Puzzle game
    "gnome-2048"      # 2048 game
    "five-or-more"    # Puzzle game
    "hitori"          # Hitori puzzle game
    "iagno"           # Reversi game
)

# List of other potential bloatware to remove
bloatware=(
    "gnome-maps"      # Maps application
    "gnome-contacts"  # Contacts application
    "gnome-calendar"  # Calendar application
    "gnome-characters" # Character map application
    "gnome-logs"       # System logs viewer
    "gnome-todo"       # Personal task manager
    "gnome-boxes"      # Simple application to access remote or virtual systems
    "gnome-photos"     # Photos application
    "gnome-music"      # Music player
    "gnome-clocks"     # Clocks application
    "gnome-recipes"    # Recipes application
    "cheese"           # Webcam application
    "rhythmbox"        # Music player
    "shotwell"         # Photo manager
    "evolution"        # Email and calendar application
    "totem"            # Video player
    "gnome-disk-utility"
    "gnome-backgrounds"
    "gnome-bluetooth-sendto"
    "gnome-calculator"
    "gnome-connections"
    "gnome-font-viewer"
    "gnome-initial-setup"
    "gnome-remote-desktop"
    "gnome-snapshot"
    "gnome-software"
    "gnome-sound-recorder"
    "gnome-sushi"
    "gnome-system-monitor"
    "gnome-text-editor"
    "gnome-tour"
    "gnome-user-docs"
    "gnome-user-share"
    "gnome-weather"
    "simple-scan"
    "file-roller"
    "eog"
    "yelp"
    "evince"
    "seahorse"
    "malcontent"
    "loupe"
    "baobab"
)

sudo apt purge "${gnome_games[@]}" "${bloatware[@]}" -y


######################
# system configuration
######################

# https://wiki.debian.org/ConfigurePowerButton
HASH1=$(sha256sum /etc/systemd/logind.conf | awk '{ print $1 }')
HASH2=$(sha256sum etc/systemd/logind.conf | awk '{ print $1 }')
if [ $HASH1 != $HASH2 ]; then
    sudo cp etc/systemd/logind.conf /etc/systemd/logind.conf
    systemctl restart systemd-logind.service
else
    echo "Power button already correctly configured."
fi

