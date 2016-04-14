#!/usr/bin/bash

function configure_locale {
         nano /etc/locale.gen
         locale-gen

         echo LANG=en_US.UTF-8 > /etc/locale.conf

         TZ=$(tzselect)
         ln -s /usr/share/zoneinfo/$TZ /etc/localtime

         hwclock --systohc --utc
}


function EFI_boot_loader {
         bootctl install --path /boot/efi > systemd-boot_results.txt
         # Explain what it should contain :
         nano /boot/efi/loader/arch.conf
}
