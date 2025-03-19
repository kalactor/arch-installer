#!/bin/bash

root_password="$1"
username="$2"
user_password="$3"
hostname="$4"

# Set root password
echo "root:$root_password" | chpasswd

# Add user $username and set password
useradd -m -g users -G wheel,storage,video,audio -s /bin/bash $username
echo "$username:$user_password" | chpasswd

# Grant sudo permissions to amit
echo "Editing the sudoers file."
sed -i "/^# %wheel ALL=(ALL:ALL) ALL/c\%wheel ALL=(ALL:ALL) ALL" /etc/sudoers
if ! visudo -c; then
    echo "Error: Invalid syntax in /etc/sudoers. Aborting!"
    exit 1
fi

# setting automatic time upate
timedatectl set-ntp true

# Set timezone
ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
hwclock --systohc

# Configure locale
#echo "en_IN.UTF-8 UTF-8" >> /etc/locale.gen
sed -i "/^#en_IN UTF-8/c\en_IN UTF-8" /etc/locale.gen
locale-gen
echo "LANG=en_IN" > /etc/locale.conf

# Set hostname
echo $hostname > /etc/hostname

# echo "127.0.0.1    localhost" >> /etc/hosts
# echo "::1	   localhost" >> /etc/hosts
# echo "127.0.1.1    ${hostname}.localdomain   $hostname" >> /etc/hosts

# Update /etc/hosts with necessary entries using a here document
cat <<EOF >> /etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.1.1    ${hostname}.localdomain   $hostname
EOF

# Install and configure GRUB
pacman -S --noconfirm grub efibootmgr dosfstools mtools
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Enable NetworkManager
systemctl enable NetworkManager

systemctl start dhcpcd
systemctl enable dhcpcd
