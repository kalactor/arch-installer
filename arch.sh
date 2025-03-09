#!/bin/bash

set -e

echo "Welcomoe to the Arch Linux Installer!"
echo "                created by Amit Kumar"

# Sync and install necessary packages
pacman -Sy archlinux-keyring --noconfirm

read -s -p "Enter root password: " root_password

read -p "Enter username: " username
read -s -p "Enter password for user $username: " user_password

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
#arch-chroot /mnt /bin/bash -c "/post.sh"
arch-chroot /mnt /bin/bash <<EOF
    # Passing variables to post-install script
    export root_password="$root_password"
    export username="$username"
    export user_password="$user_password"
    /mnt/post.sh
EOF
# Unmount all partitions
umount -lR /mnt
