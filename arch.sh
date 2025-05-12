#!/bin/bash

set -e

# Define color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BOLD_WHITE='\033[1;37m'
NC='\033[0m'  # No Color

main() {
    # Display banner
    echo -e "${RED}**************************************************${NC}"
    echo -e "${RED}*                                                *${NC}"
    echo -e "${RED}*       ${BOLD_WHITE}WELCOME TO THE ARCH LINUX INSTALLER!${RED}       *${NC}"
    echo -e "${RED}*                                                *${NC}"
    echo -e "${RED}**************************************************${NC}"
    echo -e "${RED}*              ${GREEN}created by Amit Kumar${RED}              *${NC}"
    echo -e "${RED}**************************************************${NC}"

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

    # determine cpu (intel/amd)
    vendor=$(awk -F': ' '/vendor_id/ {print $2; exit}' /proc/cpuinfo)

    case "$vendor" in
        GenuineIntel) microcode_pkg=intel-ucode ;;
        AuthenticAMD)   =amd-ucode ;;
        *) microcode_pkg=intel-ucode ;;
    esac

    # Install base system and necessary packages
    pacstrap /mnt base base-devel linux linux-headers linux-firmware $microcode_pkg sudo git vim cmake networkmanager ntfs-3g

    # Generate fstab
    genfstab -U /mnt >> /mnt/etc/fstab

    echo -e "${YELLOW}Entering chroot ##################################################${NC}"

    # Change root to the new system and run post-install
    arch-chroot /mnt /bin/bash -c "/post.sh '$root_password' '$username' '$user_password' '$hostname' && rm -f /post.sh"

    # Unmount if successful
    umount -lR /mnt
}

main
status=$?

if [ $status -ne 0 ]; then
    echo -e "${RED}Script failed. Cleaning up...${NC}"
    umount -lR /mnt 2>/dev/null || true
    exit $status
fi
