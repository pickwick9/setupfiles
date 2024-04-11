#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl software-properties-common wget

################################################################

# git 
sudo apt install -y git-all

# command-line enhancements
sudo apt install -y fzf tmux zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
rm ~/.zshrc
chsh -s $(which zsh)

# editor
sudo apt install -y vim neovim
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium

# system tools
sudo apt install -y cpu-checker dmidecode gparted htop moreutils neofetch psensor strace
# & enhancements
sudo apt install -y libpthread-stubs0-dev thermald xclip

################################################################

# settings/config 
sudo apt install -y stow
cd ~/setupfiles/.dotfiles
stow -t ~ tmux
stow -t ~ vscodium
stow -t ~ zsh
cd

# private
sudo apt install -y keepassxc openvpn
cp ~/setupfiles/.dotfiles/kp/.kp.kdbx ~
cp ~/setupfiles/.dotfiles/ovpn/.allen.ovpn ~
cp -r ~/setupfiles/.dotfiles/ssh/.ssh ~

# security
sudo apt install -y clamav lynis wireshark

################################################################

# android
sudo apt install -y adb android-sdk-platform-tools-common

# ansible
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

# misc 
sudo apt install -y ffmpeg gimp pavucontrol qbittorrent vlc
pip install yt-dlp spotdl

################################################################

echo ""
echo "######################################"
echo "### DONE! Reboot PC to see changes ###"
echo "######################################"
