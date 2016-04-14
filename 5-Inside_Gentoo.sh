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
         echo MAKEOPTS=\"-j ${num}\"             >> /etc/portage/make.conf
         nano /etc/portage/make.conf
}
