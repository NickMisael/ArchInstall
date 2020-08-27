#!/bin/bash
echo -e "\033[01;57mUm minuto, estamos configurando..."
# Configurations loading...
sudo systemctl enable paccache.timer
sudo systemctl enable NetworkManager
cd ~/ && mkdir Desktop Pictures Downloads Musics Documents Videos
clear
sudo pkgfile --update
clear

# Add Repositories
# sudo echo -e "[archstrike]\nServer = https://mirror.archstrike.org/$arch/$repo" >> /etc/pacman.conf
# sudo pacman -Syyu
curl -O https://blackarch.org/strap.sh
sudo chmod +x strap.sh
./strap.sh
sudo pacman -S blackman
rm -rf strap.sh
sudo pacman -Syyu
clear

# Install Basic Drivers
echo -e "\033[01;31mInstalando Drivers..."
sudo pacman -S pulseaudio-alsa pavucontrol alsa-firmware alsa-utils a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb alsa alsa-lib alsa-tools alsa-plugins pulseaudio vlc xf86-video-fbdev xf86-video-vesa x86-input-synaptics cups gtk3-print-backends system-config-printer
clear
lspci | grep -e VGA -e 3D
echo -e " N -> NVIDIA\nA -> AMDGPU\nI -> INTEL\nV -> VIRTUALBOX\n"
read -p "Digite sua placa de video: " $PlacaVideo;
if [ "$PlacaVideo"=="N" ]; then
  sudo pacman -S xf86-video-nouveau nvidia nvidia-utils;
elif [ "$PlacaVideo"=="A" ]; then
    sudo pacman -S xf86-video-amdgpu;
    sudo pacman -S xf86-video-ati;
elif [ "$PlacaVideo"=="I" ]; then
    sudo pacman -S xf86-video-intel;
elif [ "$PlacaVideo"=="V" ]; then
    sudo pacman -S xf86-video-fbdev virtualbox-guest-utils virtualbox-guest-modules-arch;
fi

# Install System tools && ambiente LXDE
sudo pacman -S openvpn gedit firefox xorg xorg-utils gparted openssh lxde  xorg-xinit terminator unrar p7zip lxde

echo -e
#Install tools
sudo pacman -S radare2 wireshark-qt wireshark-cli wxhexeditor steghide metasploit hydra aircrack-ng john nikto nipper netcat inurlbr etherape chromensics arpon
clear

# Finalizando as configuraoes e reiniciando
systemctl enable lxdm
reboot
