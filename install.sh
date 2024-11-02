stow .
fc-cache -f

printf 'Do you want to install all required dependencies? (Y/n)'
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then 
    echo Installing dependencies
    sudo pacman -S git base-devel hyprland hyprpaper hyprlock kitty firefox nautilus cliphist wofi adw-gtk-theme xdg-desktop-portal-gtk xdg-desktop-portal-hyprland dart-sass fd brightnessctl swww sddm zsh unzip libdbusmenu-gtk3 dart-sass fd brightnessctl swww bluez bluez-utils gnome-bluetooth-3.0
    sudo systemctl enable sddm.service
    sudo mkdir /etc/sddm.conf.d/
    sudo cp ./sddm/* /etc/sddm.conf.d/
    gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"   # for GTK3 apps
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    cd $HOME
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd $HOME
    curl -fsSL https://bun.sh/install | bash
    sudo ln -s ~/.bun/bin/bun /usr/bin/bun
    yay -S hyprpicker aylurs-gtk-shell matugen bibata-cursor-theme
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Then you'll only get the dotfiles! (and the fonts)"
fi
