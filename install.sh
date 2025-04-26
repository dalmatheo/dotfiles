sudo pacman -S git base-devel stow

stow .
cd $HOME

printf 'Do you want to install the packages ? (Y/n)'
read pacman

if [ "$pacman" != "${pacman#[Yy]}" ]
then 
    echo Installing dependencies
    sudo pacman -S ghostty bluez bluez-utils fuzzel sddm cliphist chromium nautilus nvidia-open nvidia-utils wayland egl-wayland libva-nvidia-driver hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xorg-xhost waybar ttf-liberation ttf-roboto ttf-dejavu ttf-jetbrains-mono-nerd zsh unzip libdbusmenu-gtk3 qt6-svg cmake meson cpio pkg-config
    hyprpm update
    hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
    hyprpm enable split-monitor-workspaces
    hyprpm update
    hyprpm reload

    cd $HOME

    printf 'Do you want to install paru (Y/n)'
    read paru

    if [ "$paru" != "${paru#[Yy]}" ]
    then
        echo Installing paru
        sudo pacman -S --needed git base-devel
        git clone https://aur.archlinux.org/paru.git
        cd paru
        makepkg -si

        cd $HOME

        printf 'Do you want to install all the AUR packages ? (Y/n)'
        read pacman
        if [ "$pacman" != "${pacman#[Yy]}" ]
	then 
            echo Installing dependencies
            paru -S pwvucontrol hyprprop hyprshot bibata-cursor-theme 
	else
	    echo You wont get the AUR packages.
	fi
    else
        echo You wont get paru, nor the AUR pacakges.
    fi

    sudo systemctl enable sddm.service
    sudo systemctl enable bluetooth.service
    sudo mkdir /etc/sddm.conf.d/
    sudo cp $HOME/dotfiles/sddm/configuration/* /etc/sddm.conf.d/
    sudo cp -r $HOME/dotfiles/sddm/sddm-theme /usr/share/sddm/themes/sddm-theme

    cd $HOME

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

else
    echo "Then you'll only get the dotfiles!"
fi
