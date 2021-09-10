#!/bin/bash
Aux="~/Aux"
sudo cd ..
sudo chown $USER ArchInstall
mkdir $Aux
cd ArchInstall
cd $Aux
# Atualizando firmwares
echo "| Corrigindo os erros do Mkinitcpio |"
git clone https://aur.archlinux.org/aic94xx-firmware.git 
sleep 2
clear ; echo "| Corrigindo os erros do Mkinitcpio |"
cd aic94xx-firmware/
makepkg -sri
cd ..
rm -rf aic94xx-firmware/
clear ; echo "| Corrigindo os erros do Mkinitcpio |"
git clone https://aur.archlinux.org/wd719x-firmware.git 
sleep 2
cd wd719x-firmware/
makepkg -sri
cd ..
rm -rf wd719x-firmware/
clear ; echo "| Corrigindo os erros do Mkinitcpio |"
git clone https://aur.archlinux.org/upd72020x-fw.git
sleep 2
cd upd72020x-fw/
makepkg -sri
cd ..
rm -rf upd72020x-fw
clear ; echo "| Carregando o Mkinitcpio |"
sleep 1
sudo mkinitcpio -P
clear

echo -e "\033[01;57mUm minuto, estamos fazendo as configuracoes iniciais..."
sleep 2
# Configurations loading...
sudo systemctl enable paccache.timer
sudo systemctl enable dhcpcd
sudo systemctl enable NetworkManager
cd ~/ && mkdir Desktop Pictures Downloads Musics Documents Videos
clear
echo -e "\033[01;57mUm minuto, estamos fazendo as configuracoes iniciais..."
sudo pkgfile --update
sleep 1 ; clear


echo "| Instalando o BlackArch |"
sleep 2
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
sleep 2
sudo pacman -S pulseaudio-alsa pavucontrol alsa-firmware alsa-utils a52dec faac faad2 flac jasper lame libdca libdv libmad libmpeg2 libtheora libvorbis libxv wavpack x264 xvidcore gstreamer gst-plugins-base gst-plugins-base-libs gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb alsa alsa-lib alsa-tools alsa-plugins pulseaudio vlc xf86-video-fbdev xf86-video-vesa x86-input-synaptics cups gtk3-print-backends system-config-printer --noconfirm
sleep 2
clear

echo -e "\033[01;31mInstalando Drivers..."
lspci | grep -e VGA -e 3D
echo -e " N -> NVIDIA\nA -> AMDGPU/ATI\nI -> INTEL\nV -> VIRTUALBOX\n"
read -p "Selecione sua placa de video: " $PlacaVideo;
if [[ "$PlacaVideo" == "N" ]] then
  sudo pacman -S xf86-video-nouveau nvidia nvidia-utils --noconfirm
elif [[ "$PlacaVideo" == "A" ]] then
    sudo pacman -S xf86-video-amdgpu --noconfirm
    sudo pacman -S xf86-video-ati --noconfirm
elif [[ "$PlacaVideo" == "I" ] then
    sudo pacman -S xf86-video-intel --noconfirm
elif [[ "$PlacaVideo" == "V" ]] then
    sudo pacman -S xf86-video-fbdev virtualbox-guest-utils virtualbox-host-modules-arch --noconfirm
fi
clear

echo -e "\033[01;31mInstalando Programas Uteis..."
sleep 2
# Install System tools && ambiente LXDE
sudo pacman -S openvpn lxde gedit firefox xorg openvpn gparted tor privoxy nyx i2pd torsocks torbrowser-launcher openssh vim xorg-xinit make mlocate postgresql wget nginx code terminator unrar p7zip bc --noconfirm
sudo updatedb
sudo cp /etc/X11/xinit/xinitrc ~/.xinitrc
echo "exec startlxde" >> ~/.xinitrc
sleep 2
clear

echo -e "\033[01;31mInstalando Programas Uteis..."
#Install tools
sudo pacman -S radare2 wireshark-qt wireshark-cli wxhexeditor hexyl pev gdb nasm nmap steghide tcpdump ltrace strace metasploit hydra aircrack-ng john whatweb nikto nipper netcat traceroute theharvester inurlbr etherape chromensics arpon netmap neofetch fakeroot netdiscover dnsenum dnsmap whois webanalyze
sleep 2
clear

echo -e "\033[01;31mInstalando Programas Uteis..."
# Acrescentando o repo do yaourt
sudo pacman -S --needed base-devel git wget yajl
sleep 2
clear

echo "| Instalando Yaourt... |"
sleep 2
cd $Aux
git clone https://aur.archlinux.org/package-query.git
sudo mv package-query /opt
cd /opt
sudo chown $USER package-query
cd package-query
makepkg -si
git clone https://aur.archlinux.org/yaourt.git
cd yaourt
makepkg -si
cd ../..
sudo rm -rf package-query
cd ~

sudo yaourt -Syyu
sleep 1
clear
echo "| Instalando Yaourt... |"

yaourt -S riseup-vpn
clear

echo "| Instalando Yaourt... |"
yaourt -S protonvpn-cli-ng
clear
echo "| Instalando Yaourt... |"
protonvpn init

# Notificador 
yaourt -S undistract-me-git
echo -e "source /usr/share/undistract-me/long-running.bash\notify_when_long_running_commands_finish_install" >> ~/.bashrc
source ~/.bashrc
sudo echo -ne "if [ -z “$IGNORE_WINDOW_CHECK” ]; then\n   IGNORE_WINDOW_CHECK=0\nfi" >> /usr/share/undistract-me/long-running.bash
echo "Adicione o som e mude o Timeout, este ultimo se quiser"
sudo vim /usr/share/undistract-me/long-running.bash


echo "| Configs finais... |"
# Finalizando as configuraoes e reiniciando
systemctl enable lxdm
clear

echo "| Configs finais... |"
echo -ne "set nocompatible\nset nu\nsyntax on\nset encoding=utf-8\nset showcmd\nfiletype plugin indent on\n\nset tabstop=2 shiftwidth=2\nset expandtab\nset backspace=indent,eol,start\n\nset hlsearch\nset incsearch\nsetignorecase\nset smartcase" > .vimrc
clear

echo -e "\033[1;34mTerminamos a instalacao completa :D!!"
echo -e "\033[1;5;36mSeja Muito Bem-Vindo ao Universo ArchLinux"
sleep 10
reboot
