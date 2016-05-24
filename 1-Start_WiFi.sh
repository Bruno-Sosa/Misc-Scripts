#!/bin/bash
# Usage: bash <filename>
set -o errexit 
set -o noclobber
set -o xtrace 
source Settings/Network_interface.txt
source Settings/WPA_config_file.txt
set -o nounset

killall wpa_supplicant # Prevent already running errors
killall dhcpcd         # Prevent already running errors

wpa_supplicant -B -i "${Network_interface}" -c "${WPA_config_file}"
sleep 3s
dhcpcd -4 "${Network_interface}"
