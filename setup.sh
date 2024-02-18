#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y
sudo apt install -y curl software-properties-common wget

################################################################

# python
sudo apt install python3-pip
curl https://pyenv.run | bash
pip3 install pipenv

# c/c++
sudo apt install -y build-essential clang clangd cmake gcc ninja-build pkg-config

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# some tools
sudo apt install -y gdb git-all make valgrind

################################################################

# IDEs
sudo apt install -y neovim vim
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O ~/vscode.deb
sudo apt install ~/vscode.deb
rm ~/vscode.deb

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

# .dotfiles
sudo apt install -y stow
mv ~/setupfiles/.dotfiles ~/.dotfiles
cd ~/.dotfiles && stow ovpn && stow ssh && stow tmux && stow vscode && stow zsh
rm -rf ~/setupfiles

# password manger 
sudo apt install -y keepassxc
stow kp

# network
sudo apt install -y openvpn wireshark
stow ovpn && cd

# antivirus
sudo apt install -y clamav lynis

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
curl -fsSL https://ollama.com/install.sh | sh

################################################################

echo ""
echo "######################################"
echo "### DONE! Reboot PC to see changes ###"
echo "######################################"
