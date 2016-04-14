#!/bin/bash

source /etc/profile
export PS1="(CHROOT) $PS1"

function pre_emerge {
         emerge-webrsync
         eselect news list
         eselect news read
         eselect profile list
}

function use_flags {
         # Defaults
         less /usr/portage/profiles/use.desc
         # User Defined
         echo 'CFLAGS="-march=native -O2 -pipe"' >> /etc/portage/make.conf
         echo 'CXXFLAGS="${CFLAGS}"'             >> /etc/portage/make.conf

         num=$(nproc); let num++
         printf 'MAKEOPTS="-j %s" \n' "${num}"      >> /etc/portage/make.conf
         nano /etc/portage/make.conf
}

function kernel {
         emerge --ask sys-kernel/gentoo-sources
         # So that you can use `lspci`:
         emerge --ask sys-apps/pciutils

         cd /usr/src/linux
         make menuconfig
         num=$(nproc); let num++
         make                 -j $num #; halt
         make modules_install -j $num

         make install
         cp /boot/vmlinuz-*-gentoo /boot/efi/EFI/bootx64.efi

         emerge --ask sys-kernel/linux-firmware
         emerge --ask app-admin/mcelog
}
