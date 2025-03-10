#!/bin/bash

set -e

echo "Welcomoe to the Arch Linux Installer!"
echo -e "                created by Amit Kumar\n\n"

# Sync and install necessary packages
pacman -Sy archlinux-keyring --noconfirm

read -s -p "Enter root password: " root_password
echo
read -p "Enter username: " username
read -s -p "Enter password for user $username: " user_password
echo
read -p "Enter hostname: " hostname
echo

# Call to disk manager script
./disk_manager.sh

# Copy post install script
cp post.sh /mnt

# Install base system and necessary packages
pacstrap /mnt base base-devel linux linux-headers linux-firmware intel-ucode sudo git vim cmake make networkmanager dhcpcd cargo gcc

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

echo "Entering chroot ##################################################"

# Change root to the new system
arch-chroot /mnt /bin/bash -c "/post.sh '$root_password' '$username' '$user_password' '$hostname'"

# Unmount all partitions
umount -lR /mnt
