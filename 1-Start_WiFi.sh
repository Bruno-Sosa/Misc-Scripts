function choose_wifi {
         wpa_cli scan_results
         echo "Choose a WiFi:"
         read WiFi_name
}

installation_steps+=(start_wifi)
function start_wifi {
         killall wpa_supplicant # Prevent already running errors
         killall dhcpcd         # Prevent already running errors

         WPA_config_file='/etc/wpa_supplicant/wpa_supplicant.conf'

         wpa_supplicant -B -i "${net_if}" -c "${WPA_config_file}"

         wpa_cli scan; echo "Scanning..."; sleep 3s
         choose_wifi

         echo "This file should ONLY contain ${WiFi_name}'s password" >> WiFi_password.txt
         nano WiFi_password.txt
         
         ( wpa_passphrase ${WiFi_name} < WiFi_password.txt ) >> ${WPA_config_file}
         
         # Need to reload with new configuration
         wpa_cli reconfigure

         dhcpcd
}
