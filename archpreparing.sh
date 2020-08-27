#!/bin/bash
# particionar e formatar as partições
# montar o ponto do sistema em /mnt
# timedatectl set-ntp true
# pacstrap /mnt base base-devel linux linux-firmware nano git man info
# genfstab -U /mnt >> /mnt/etc/fstab
# arch-chroot /mnt
ln -sf /usr/share/zoneinfo/America/Phoenix /etc/localtime
hwclock --systohc
echo "en_US.UTF8" >> /etc/locale.gen
locale-gen
echo LANG=pt_BR.UTF-8 >> /etc/locale.conf
read -p "Digite o hostname: " Hostname;
echo $Hostname >> /etc/hostname
echo -e "127.0.0.1 localhost.localdomain localhost\n::1 localhost.localdomain localhost\n127.0.1.1 $Hostname.localdomain $Hostname" >> /etc/hosts
clear
passwd
read -p "Digite o nome do usuário: " Usuario;
useradd -m $Usuario
gpasswd -a $Usuario sys
gpasswd -a $Usuario lp
gpasswd -a $Usuario network
gpasswd -a $Usuario video
gpasswd -a $Usuario optical
gpasswd -a $Usuario storage
gpasswd -a $Usuario scanner8
gpasswd -a $Usuario power
mkinitcpio -P
pacman -Syyu reflector bash-completion networkmanager network-manager-applet dhcpcd pacman-contrib pkgfile wireless_tools wpa_supplicant mesa dialog sudo
echo "$Usuario ALL=(ALL) ALL" >> /etc/sudoers
pacman -S grub os-prober
read -p "Digite a unidade: " Unidade;
grub-install --target=i386-pc --recheck $Unidade
cp /usr/share/locale/en@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo
systemctl enable dhcpcd
exit
# umount -a
