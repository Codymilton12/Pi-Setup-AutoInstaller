#!/bin/bash
#Connect to new Wifi networks on the Pi

Wifi_connection () {
	until [[ ${State_of_wifi,,} =~ [y/n] ]]; do
	       read -rp "Are you sure you want to connect to a new network [y/N]: " State_of_wifi
	done

	if [[ ${State_of_wifi,,} == "y" ]]; then
		#Make Wifi config file
		wifi_file_path=/boot/wpa_supplicant.conf
		        echo "country=US" > $wifi_file_path
			echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" >> $wifi_file_path
			echo "update_config=1" >> $wifi_file_path
			echo "" >> $wifi_file_path
			echo "network={" >> $wifi_file_path 
			read -p "Network SSID: " network_SSID
			read -p "Network Password: " network_password
			echo "	"ssid='"'$network_SSID'"' >> $wifi_file_path
		       	echo "	"psk='"'$network_password'"' >> $wifi_file_path
			echo "	"key_mgmt=WPA-PSK >> $wifi_file_path
			echo } >> $wifi_file_path
			touch /boot/ssh
	fi

}
Wifi_connection
