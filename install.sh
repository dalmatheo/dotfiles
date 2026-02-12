#!/bin/bash

# Define the location of your dotfiles (where this script is running from)
DOTFILES_DIR=$(pwd)

# 1. Install official packages
echo "Installing base tools..."
sudo pacman -S --needed --noconfirm git base-devel stow

# 2. Creating the necessary directories
mkdir -p "$HOME/.config" "$HOME/.ssh" "$HOME/.local/share"

# 3. Setup Dotfiles
echo "Stowing dotfiles..."
# Explicitly stow from the dotfiles directory to the home directory
stow -d "$DOTFILES_DIR" -t "$HOME" .

# 4. Prompt for Official Packages (packages.txt)
printf 'Do you want to install official packages from packages.txt? (Y/n) '
read -r answer_official

if [ "$answer_official" != "${answer_official#[Yy]}" ]; then 
    echo "Installing official packages..."
    if [ -f "$DOTFILES_DIR/packages.txt" ]; then
        grep -vE '^\s*#|^\s*$' "$DOTFILES_DIR/packages.txt" | sudo pacman -S --needed --noconfirm -
    else
        echo "Warning: packages.txt not found."
    fi
    
    if command -v hyprpm &> /dev/null; then
        hyprpm update
        hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
        hyprpm enable split-monitor-workspaces
        hyprpm update
        hyprpm reload
    fi
fi

# 5. Install Paru (AUR Helper)
if ! command -v paru &> /dev/null; then
    echo "Paru is not installed. Installing now..."
    # Perform build in a temporary directory to avoid cluttering $HOME or dotfiles
    TEMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$TEMP_DIR/paru"
    (cd "$TEMP_DIR/paru" && makepkg -si --noconfirm)
    rm -rf "$TEMP_DIR"
else
    echo "Paru is already installed."
fi

# 6. Prompt for AUR Packages (aur.txt)
printf 'Do you want to install AUR packages from aur.txt? (Y/n) '
read -r answer_aur

if [ "$answer_aur" != "${answer_aur#[Yy]}" ]; then
    echo "Installing AUR packages..."
    if [ -f "$DOTFILES_DIR/aur.txt" ]; then
        grep -vE '^\s*#|^\s*$' "$DOTFILES_DIR/aur.txt" | paru -S --needed --noconfirm -
    else
        echo "Warning: aur.txt not found."
    fi
else
    echo "Skipping AUR packages."
fi

# 7. Post-Installation Configuration
echo "Configuring SDDM..."
if [ -f "$DOTFILES_DIR/sddm.conf" ]; then
    sudo cp "$DOTFILES_DIR/sddm.conf" /etc/sddm.conf
    echo "SDDM configuration applied."
else
    echo "Warning: sddm.conf not found in $DOTFILES_DIR"
fi

echo "Enabling services..."
sudo systemctl enable sddm.service
sudo systemctl enable bluetooth.service

# 8. Install Oh My Zsh (if not present)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Done! You'll only get the dotfiles if you skipped the installs."
