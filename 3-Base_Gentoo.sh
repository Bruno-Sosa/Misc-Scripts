#!/bin/bash

installation_steps+=(install_base)
function install_base {
         cd /mnt/gentoo
         tar xvjpf ~/stage3-*.tar.bz2 --xattrs
}

installation_steps+=(install_base)
function configure_base {

         alias nano="nano --operatingdir=/mnt/gentoo/ --syntax=sh"
         nano ./etc/fstab
         nano ./etc/hosts
         nano ./etc/conf.d/hostname
         nano ./etc/conf.d/keymaps
         nano ./etc/conf.d/hwclock
         nano ./etc/rc.conf
         unalias nano
}
