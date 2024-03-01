#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl software-properties-common wget

################################################################

# python
sudo apt install python3-pip
curl https://pyenv.run | bash
pip3 install pipenv

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# c/c++
sudo apt install -y build-essential clang clangd cmake gcc ninja-build pkg-config

# some tools
sudo apt install -y gdb git-all make valgrind

################################################################

# IDEs
sudo apt install -y neovim vim
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt update && sudo apt install codium

# command-line enhancements
sudo apt install -y fzf tmux zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/plugins/zsh-autosuggestions
rm ~/.zshrc
chsh -s $(which zsh)

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

# qemu/KVM 
if [[ $(egrep -c '(vmx|svm)' /proc/cpuinfo) -eq 0 ]]; then
    echo "Hardware virtualization is not currently enabled. This can be enabled in the BIOS"
    exit 1
fi
if kvm-ok | grep -q "KVM acceleration can NOT be used"; then
    echo "KVM virtualization is not supported by this CPU"
    exit 1
fi
sudo apt install -y bridge-utils dnsmasq ebtables libvirt-clients libvirt-daemon libvirt-daemon-system qemu-kvm qemu-system qemu-utils vde2 virtinst virt-manager virt-viewer
sudo virsh net-start default
sudo virsh net-autostart default
sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER

################################################################

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
