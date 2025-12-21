#!/bin/bash

# This shell script removes GNOME games and other potential bloatware.
# Please review each section before executing the commands.

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

# Remove GNOME games
echo "Removing GNOME games..."
sudo apt purge "${gnome_games[@]}" -y

# Remove other potential bloatware
echo
echo "Removing other potential bloatware..."
sudo apt remove "${bloatware[@]}" -y

# End of script
echo "Cleanup completed."
