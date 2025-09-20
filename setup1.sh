#!/bin/bash

# additional needed packages
NEEDED_PACKAGES=(
"snapd"
)

# list apps here
APT_PACKAGES=(
"fastfetch"
"vlc"
"obs-studio"
"freecad"
"git"
)

FLATPAK_PAKAGES=(
"com.valvesoftware.Steam"
"md.obsidian.Obsidian"
)

FLATHUB_PACKAGE=(
"com.spotify.client"
"com.discordapp.Discord"
)

SNAP_PACKAGES=(
"spotify"
"steam"
)

SNAP_CLASSIC_PACKAGES=(
"obsidian"
)

# check for and delete nosnap.pref in mint
if test -f "/etc/apt/preferences.d/nosnap.pref"; then
    echo "## file found"
    sudo rm "/etc/apt/preferences.d/nosnap.pref";
    echo "## file removed"
else
    echo "## file not found"
fi

#install flathub repo
echo "## checking for and getting flathub repo..."
if ! flatpak remote-list | grep -q flathub; then
    echo "## Adding Flathub remote..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# check for and install snap
echo "## CHECKING FOR SNAP"
for pkg in "${NEEDED_PACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "installing $pkg..."
        sudo apt install -y "$pkg"
    fi
done

#install code
echo "## INSTALLING APT PACKAGES"
for pkg in "${APT_PACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg..."
        sudo apt install -y "$pkg"
    fi
done

echo "## INSTALLING SNAP PACKAGES"
for pkg in "${SNAP_PACKAGES[@]}"; do
    if snap list "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else
        echo "## installing $pkg via snap..."
        sudo snap install "$pkg"
    fi
done

for pkg in "${SNAP_CLASSIC_PACKAGES[@]}"; do
    if snap list "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping.. "
    else
        echo "## installing $pkg via snap --classic"
        sudo snap install "$pkg" --classic
    fi
done

echo "## INSTALLING FLATPAK PACKAGES"
for pkg in "${FLATPAK_PLACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else 
        echo "## installing $pkg..."
        sudo flatpak install -y "$pkg"
    fi
done

echo "## INSTALLING FLATHUB PACKAGES"
for pkg in "${FLATHUB_PLACKAGES[@]}"; do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "## $pkg is already installed, skipping..."
    else 
        echo "## installing $pkg..."
        sudo flatpak install -y flathub "$pkg"
    fi
done

#update code
echo "## CHECKING FOR AND INSTALLING APT PACKAGE UPDATES"
sudo apt update && sudo apt upgrade -y

echo "## CHECKING FOR AND INSTALLING SNAP PACKAGE UPDATES"
sudo snap refresh

echo "## UPDATES CHECKED!"
echo "## DONE"
