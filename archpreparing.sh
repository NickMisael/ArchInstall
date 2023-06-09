#!/bin/bash
# particionar e formatar as partições
# montar o ponto do sistema em /mnt
# timedatectl set-ntp true
# if ! Wifi
# /etc/wpa_supplicant.conf
# network={
#    ssid="ssid_name"
#    psk="password"
#}
# wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf -D wext
# ping google.com
# pacman -Sy
# pacman -S reflector
# reflector --verbose -l 10 --sort rate --save /etc/pacman.d/mirrorlist
# pacstrap /mnt base base-devel linux linux-firmware nano git man dhcpcd
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime
hwclock --systohc
echo -e "en_US.UTF-8" >> /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 >> /etc/locale.conf
read -p "Digite o hostname: " Hostname;
echo $Hostname >> /etc/hostname
echo -e "127.0.0.1 localhost.localdomain localhost\n::1 localhost.localdomain localhost\n127.0.1.1 $Hostname.localdomain $Hostname" >> /etc/hosts
clear
echo -e "\033[01;37;40mDigite a senha do root:"
passwd
read -p "Digite o nome do usuário: " Usuario;
useradd -m $Usuario
passwd $Usuario
gpasswd -a $Usuario sys
gpasswd -a $Usuario lp
gpasswd -a $Usuario log
gpasswd -a $Usuario lock
gpasswd -a $Usuario network
gpasswd -a $Usuario video
gpasswd -a $Usuario optical
gpasswd -a $Usuario storage
gpasswd -a $Usuario scanner
gpasswd -a $Usuario wheel
gpasswd -a $Usuario power
clear
pacman -Syyu reflector bash-completion dosfstools os-prober mtools networkmanager network-manager-applet dhcpcd pacman-contrib pkgfile wireless_tools wpa_supplicant mesa dialog sudo net-tools dnsutils --noconfirm
clear
echo "$Usuario ALL=(ALL) ALL" >> /etc/sudoers
pacman -S grub os-prober --noconfirm
clear
read -p "Digite a unidade: " Unidade;
grub-install --target=i386-pc --recheck $Unidade
sleep 2
clear
mkinitcpio -P
sleep 5
clear
cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
grub-mkconfig -o /boot/grub/grub.cfg
clear
systemctl enable dhcpcd
clear
exit
# umount -a
