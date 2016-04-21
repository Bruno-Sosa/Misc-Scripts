#!/bin/bash

function choose_network_interface {
         iwconfig
         echo "Choose a network interface: "
         read Network_interface
}

function choose_wifi {
         wpa_cli scan_results
         echo "Choose a WiFi: "
         read WiFi_name
}

installation_steps+=(start_wifi)
function start_wifi {
         killall wpa_supplicant # Prevent already running errors
         killall dhcpcd         # Prevent already running errors

         choose_network_infertace
         
         WPA_config_file='/etc/wpa_supplicant/wpa_supplicant.conf'

         echo 'ctrl_interface=/var/run/wpa_supplicant' \
            > "${WPA_config_file}"

         wpa_supplicant -B           \
           -i "${Network_interface}" \
           -c "${WPA_config_file}"

         wpa_cli scan
         echo "Scanning..."
         sleep 3s
         choose_wifi

         echo "This file should ONLY contain ${WiFi_name}'s password" \
         >>   WiFi_password.txt
         nano WiFi_password.txt
         
         wpa_passphrase "${WiFi_name}" < WiFi_password.txt \
         >> "${WPA_config_file}"
         
         wpa_cli reconfigure    # Need to reload with new configuration
         dhcpcd
}
