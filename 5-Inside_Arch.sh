#!/usr/bin/bash

function configure_locale {
         # /etc/vconsole.conf :
         # KEYMAP=sv-latin1
         nano /etc/locale.gen
         locale-gen

         ### Could replace with something like:
         #echo Lang= $( grep ^[^#] /etc/locale.gen ) > /etc/locale.conf
         # But what about multiple uncomments?
         echo LANG=en_US.UTF-8 > /etc/locale.conf


         # But what about multiple uncomments?
         #echo Up to you to assign to ENV-VARs >> /etc/locale.conf
         #grep '^[^#]' /etc/locale.gen >> /etc/locale.conf
         #nano /etc/locale.conf

         TZ=$(tzselect)
         ln -s /usr/share/zoneinfo/$TZ /etc/localtime

         hwclock --systohc --utc
}

function create_user {
         printf "Choose a user name: "
         read Chosen_name
         useradd -s /bin/bash -m $Chosen_name
         passwd $Chosen_name

         pacman -S sudo
         ## Should I override /etc/sudoers with most often
         ## used config? ie user host=(root) ALL
         EDITOR=nano visudo
         passwd #-l for root
}

function install_packages {
         pacman -S wpa_supplicant 
         pacman -S xorg-server xorg-xinit xorg-server-utils
         pacman -S xf86-input-synaptics

         pacman -S gnome
         pacman -S networkmanager
         systemctl enable NetworkManager.service
}

function EFI_boot_loader {
         bootctl --path /boot/efi install > systemd-boot_results.txt
         if [[ $? -ne 0 ]]; then
            pacman -S efibootmgr # pretty sure bootctl requires efibootmgr
            pacman -S grub
            grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck
            grub-mkconfig -o /boot/grub/grub.cfg
         else
            # Explain what it should contain :
            # /boot/loader/entries/arch.conf
            nano /boot/efi/loader/loader.conf
            #    /boot/loader/loader.conf :
            #timeout 3
            #default arch
         fi
}
