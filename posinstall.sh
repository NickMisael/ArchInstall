#!/bin/bash
sudo echo
# Atualizando firmwares
git clone https://aur.archlinux.org/aic94xx-firmware.git 
clear
cd aic94xx-firmware/
makepkg -sri
cd ..
rm -rf aic94xx-firmware/
clear
git clone https://aur.archlinux.org/wd719x-firmware.git 
cd wd719x-firmware/
makepkg -sri
cd ..
rm -rf wd719x-firmware/
git clone https://aur.archlinux.org/upd72020x-fw.git
cd upd72020x-fw/
makepkg -sri
cd ..
rm -rf upd72020x-fw
clear
sudo mkinitcpio -P
clear

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
sudo sh strap.sh
sudo pacman -S blackman
rm -rf strap.sh
sudo pacman -Syyu
clear

# Install Basic Drivers
echo -e "\033[01;31mInstalando Drivers..."
sudo pacman -S pulseaudio-alsa pavucontrol alsa-firmware alsa-utils a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb alsa alsa-lib alsa-tools alsa-plugins pulseaudio vlc xf86-video-fbdev xf86-video-vesa x86-input-synaptics cups gtk3-print-backends system-config-printer --noconfirm
clear
lspci | grep -e VGA -e 3D
echo -e " N -> NVIDIA\nA -> AMDGPU/ATI\nI -> INTEL\nV -> VIRTUALBOX\n"
read -p "Selecione sua placa de video: " $PlacaVideo;
if [ "$PlacaVideo" == "N" ] then
  sudo pacman -S xf86-video-nouveau nvidia nvidia-utils --noconfirm;
elif [ "$PlacaVideo" == "A" ] then
    sudo pacman -S xf86-video-amdgpu --noconfirm;
    sudo pacman -S xf86-video-ati --noconfirm;
elif [ "$PlacaVideo" == "I" ] then
    sudo pacman -S xf86-video-intel --noconfirm;
elif [ "$PlacaVideo" == "V" ] then
    sudo pacman -S xf86-video-fbdev virtualbox-guest-utils virtualbox-host-modules-arch --noconfirm;
fisudo p
clear

# Install System tools && ambiente LXDE
sudo pacman -S openvpn gedit firefox xorg xorg-utils gparted openssh xorg-xinit terminator unrar p7zip --noconfirm
clear

#Install tools
sudo pacman -S radare2 wireshark-qt wireshark-cli wxhexeditor nmap steghide metasploit hydra aircrack-ng john nikto nipper netcat theharvester inurlbr etherape chromensics arpon netmap netdiscover dnsenum dnsmap whois
clear

# Finalizando as configuraoes e reiniciando
# systemctl enable lxdm
clear

echo -e "\033[1;34mTerminamos a instalacao completa :D!!"
echo -e "\033[1;5;36mSeja Muito Bem-Vindo ao Universo ArchLinux"
sleep 10
reboot
