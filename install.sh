stow .
fc-cache -f

printf 'Do you want to install all required dependencies? (Y/n)'
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then 
    echo Installing dependencies
    sudo pacman -S git base-devel hyprland hyprpaper hyprlock kitty firefox nautilus cliphist wofi adw-gtk-theme xdg-desktop-portal-gtk xdg-desktop-portal-hyprland dart-sass fd brightnessctl swww sddm zsh
    sudo systemctl enable sddm.service
    sudo mkdir /etc/sddm.conf.d/
    sudo cp ./sddm/* /etc/sddm.conf.d/
    gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"   # for GTK3 apps
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
    cd $HOME
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    yay -S hyprpicker aylurs-gtk-shell bun matugen
else
    echo "Then you'll only get the dotfiles! (and the fonts)"
fi
