#!/usr/bin/bash

installation_steps+=(install_base)
function install_base {
         pacstrap -i /mnt base
         pacstrap -i /mnt base-devel

}

installation_steps+=(configure_base)
function configure_base {
         genfstab -U /mnt >> /mnt/etc/fstab
         nano /mnt/etc/fstab

         printf "Choose a name for your computer: ";
         read Chosen_hostname
         echo $Chosen_hostname > /mnt/etc/hostname
}
