#!/bin/bash

installation_steps+=(install_base)
function install_base {
         cd /mnt/gentoo
         tar xvjpf ~/stage3-*.tar.bz2 --xattrs
}

installation_steps+=(install_base)
function configure_base {

         alias nano="nano --syntax=sh"
         nano /mnt/gentoo/etc/fstab
         nano /mnt/gentoo/etc/hosts
         nano /mnt/gentoo/etc/conf.d/hostname
         nano /mnt/gentoo/etc/conf.d/keymaps
         nano /mnt/gentoo/etc/conf.d/hwclock
         nano /mnt/gentoo/etc/rc.conf
         unalias nano
}
