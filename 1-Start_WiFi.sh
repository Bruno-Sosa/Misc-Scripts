#!/bin/bash
# Usage: bash <filename>
source Settings.sh

killall wpa_supplicant # Prevent already running errors
killall dhcpcd         # Prevent already running errors

wpa_supplicant -B -i "${Network_interface}" -c "${WPA_config_file}"
sleep 3s
dhcpcd -4 "${Network_interface}"
