#!/bin/bash

source /etc/profile
export PS1="(CHROOT) $PS1"

function pre_emerge {
         emerge-webrsync
         eselect news list
         eselect news read
         eselect profile list
}
