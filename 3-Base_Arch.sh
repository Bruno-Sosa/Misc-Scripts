#!/usr/bin/bash

function install_File-System {
         case $1 in 
         vFAT) pacstrap -i /mnt dosfstools  ;;
         btrfs) pacstrap -i /mnt btrfs-progs ;;
         esac
}

installation_steps+=(install_base)
function install_base {
         pacstrap -i /mnt base
         pacstrap -i /mnt base-devel

         select fs in "vFAT EFI" "btrfs"; do
         install_File-System $fs
         done
}

installation_steps+=(configure_base)
function configure_base {
         genfstab -U /mnt >> /mnt/etc/fstab
         nano /mnt/etc/fstab

         printf "Choose a name for your computer: ";
         read Chosen_hostname
         echo $Chosen_hostname > /mnt/etc/hostname
}
