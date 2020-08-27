#!/bin/bash
sudo systemctl enable paccache.timer
sudo systemctl enable NetworkManager
cd ~/ && mkdir Desktop Pictures Downloads Musics Documents Videos
sudo pkgfile --update
sudo echo -e "[archstrike]\nServer = https://mirror.archstrike.org/$arch/$repo" >> /etc/pacman.conf
sudo pacman -Syyu
curl -O https://blackarch.org/strap.sh
sudo chmod +x strap.sh
./strap.sh
sudo pacman -S blackman
rm -rf strap.sh
sudo pacman -Syyu
# Install tools of System
sudo pacman -S openvpn gedit firefox xorg xorg-utils gparted openssh lxde alsa pulseaudio xorg-xinit terminator x86-input-synaptics unrar p7zip vlc 
sudo pacman -S radare2 wireshark-qt wireshark-cli wxhexeditor steghide metasploit hydra aircrack-ng john nikto nipper netcat inurlbr etherape chromensics arpon
clear
lspci | grep -e VGA -e 3D
echo -e " N -> NVIDIA\nA -> AMDGPU\nI -> INTEL\nAt -> ATI\nV -> VIRTUALBOX\n"
read -p "Digite sua placa de video: " $PlacaVideo;
if [ "$PlacaVideo"=="N" ]; then

fi
