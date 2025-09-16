#!/bin/bash

# list apps here
DNF_PACKAGES=(
"vlc"
"obs-studio"
"freecad"
"git"
)

FLATPAK_PAKAGES=(
"com.spotify.client"
"com.valvesoftware.Steam"
"md.obsidian.Obsidian"
)


#install code
echo "## INSTALLING DNF PACKAGES"
for pkg in "${DNF_PACKAGES[@]}"; do
    if rpm -q "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo dnf install -y "$pkg"
    fi
done

echo "## INSTALLING FLATPAK PACKAGES"
for pkg in "${FLATPAK_PLACKAGES[@]}"; do
    if rpm -q "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else 
        echo "## installing $pkg..."
        sudo dnf install -y "$pkg"
    fi
done

#update code
echo "## CHECKING FOR AND INSTALLING DNF PACKAGE UPDATES"
sudo dnf update && sudo dnf upgrade -y

# done
echo "## UPDATES CHECKED!"
echo "## DONE"
