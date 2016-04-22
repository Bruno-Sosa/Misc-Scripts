#!/bin/bash
# Usage: bash <filename>
source Settings.sh

function start_wifi {
         killall wpa_supplicant # Prevent already running errors
         killall dhcpcd         # Prevent already running errors

         Start_Wifi_Settings    # If successful, will exit 

         wpa_supplicant -B -i "${Network_interface}" -c "${WPA_config_file}"
         dhcpcd
	 exit
}

function Start_Wifi_Settings {

         if [[ -z "${Network_interface}" ]]; then
         choose_network_interface;           fi

         if [[ -z "${WPA_config_file}"   ]]; then
         create_network_configuration_1

            if [[ -z "${WiFi_name}" ]]; then
            choose_wifi               ; fi

         create_network_configuration_2;     fi

}

function choose_network_interface {

         echo "Choose a network interface: "
         ip link | grep wl
         read Network_interface
}

function create_network_configuration_1 {

         WPA_config_file='/etc/wpa_supplicant/wpa_supplicant.conf'

         echo 'ctrl_interface=/var/run/wpa_supplicant' > "${WPA_config_file}"

         wpa_supplicant -B -i "${Network_interface}" -c  "${WPA_config_file}"
}

function choose_wifi {

         wpa_cli scan
         echo "Scanning..."; sleep 3s
         echo "Choose a WiFi:"

         wpa_cli scan_results
         read WiFi_name
}

function create_network_configuration_2 {

         echo "The following file should ONLY contain ${WiFi_name}'s password"
         echo "Press any key to continue..."
         read
         nano WiFi_password.txt
         
         (wpa_passphrase "${WiFi_name}" < WiFi_password.txt) >> "${WPA_config_file}"

         wpa_cli reconfigure # Need to reload with new configuration

         dhcpcd
	 exit
}

start_wifi
