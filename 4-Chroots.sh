#!/bin/bash

function chroot_and_extra {
         cp ./*.sh   "${mount_point}"/

    if [[ -x /bin/arch-chroot ]]; then
         arch-chroot /mnt /bin/bash
    else
         # Copy the DNS configuration to the new system
         # With the option to follow links turned on.
         cp -L /etc/resolv.conf "${mount_point}"/etc

         mount -t proc  proc    "${mount_point}"/proc
         mount --rbind  /sys    "${mount_point}"/sys
         mount --rbind  /dev    "${mount_point}"/dev
         mount --make-rslave    "${mount_point}"/sys
         mount --make-rslave    "${mount_point}"/dev

         chroot "${mount_point}" /bin/bash
    fi

}
