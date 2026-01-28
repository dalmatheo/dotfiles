#!/bin/bash

# 1. Install official packages
echo "Installing base tools..."
sudo pacman -S --needed --noconfirm git base-devel stow

# 2. Setup Dotfiles
echo "Stowing dotfiles..."
stow .
cd "$HOME" || exit 1

# 3. Prompt for Official Packages (packages.txt)
printf 'Do you want to install official packages from packages.txt? (Y/n) '
read -r answer_official

if [ "$answer_official" != "${answer_official#[Yy]}" ]; then 
    echo "Installing official packages..."
    # Read from packages.txt, ignore comments (#) and empty lines
    if [ -f packages.txt ]; then
        grep -vE '^\s*#|^\s*$' packages.txt | sudo pacman -S --needed --noconfirm -
    else
        echo "Warning: packages.txt not found."
    fi
    
    # Reload hyprpm after dependencies (if Hyprland is installed)
    if command -v hyprpm &> /dev/null; then
        hyprpm update
        hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
        hyprpm enable split-monitor-workspaces
        hyprpm update
        hyprpm reload
    fi
fi

# 4. Install Paru (AUR Helper)
if ! command -v paru &> /dev/null; then
    echo "Paru is not installed. Installing now..."
    cd "$HOME" || exit 1
    # Clone and install paru
    git clone https://aur.archlinux.org/paru.git
    cd paru || exit 1
    makepkg -si --noconfirm
    cd ..
    rm -rf paru
else
    echo "Paru is already installed."
fi

# 5. Prompt for AUR Packages (aur.txt)
printf 'Do you want to install AUR packages from aur.txt? (Y/n) '
read -r answer_aur

if [ "$answer_aur" != "${answer_aur#[Yy]}" ]; then
    echo "Installing AUR packages..."
    if [ -f aur.txt ]; then
        # Use paru to install listed packages
        grep -vE '^\s*#|^\s*$' aur.txt | paru -S --needed --noconfirm -
    else
        echo "Warning: aur.txt not found."
    fi
else
    echo "Skipping AUR packages."
fi

# 6. Post-Installation Configuration
cd "$HOME" || exit 1

echo "Enabling services..."
sudo systemctl enable greetd.service
sudo systemctl enable bluetooth.service

echo "Configuring greetd..."
if [ -d "$HOME/dotfiles/greetd" ]; then
    sudo cp -r "$HOME"/dotfiles/greetd /etc/greetd
fi

# 7. Install Oh My Zsh (if not present)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

echo "Done! You'll only get the dotfiles if you skipped the installs."
