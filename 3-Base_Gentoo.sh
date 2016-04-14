#!/bin/bash

installation_steps+=(install_base)
function install_base {
         cd /mnt/gentoo
         tar xvjpf ~/stage3-*.tar.bz2 --xattrs
}

installation_steps+=(install_base)
function configure_base {

         alias nano="nano --operatingdir=/mnt/gentoo/etc --syntax=sh"
         nano fstab
         nano hosts
         nano conf.d/hostname
         nano conf.d/keymaps
         nano conf.d/hwclock
         nano rc.conf
         unalias nano
}
