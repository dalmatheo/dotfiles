sudo pacman -S git base-devel stow

stow .
cd $HOME

printf 'Do you want to install the packages ? (Y/n)'
read pacman

if [ "$pacman" != "${pacman#[Yy]}" ]
then 
    echo Installing dependencies
    sudo pacman -S ttf-liberation ttf-roboto ttf-dejavu ttf-jetbrains-mono-nerd zsh unzip libdbusmenu-gtk3 qt6-svg cmake meson cpio pkg-config
    hyprpm update
    hyprpm add https://github.com/Duckonaut/split-monitor-workspaces
    hyprpm enable split-monitor-workspaces
    hyprpm update
    hyprpm reload

    cd $HOME

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
