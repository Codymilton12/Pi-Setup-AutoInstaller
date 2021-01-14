#!/bin/bash

#Opening
python Assets/install_opening-message.py
#Install updates
update_pi () {
	apt-get update
	apt upgrade
}

#Install recommended programs
install_tools () {
	until [[ ${Install_recommended,,} =~ [y/n] ]]; do
		read -rp "Install recommended programs? [y/N]: " Install_recommended
	done 

	if [[ ${Install_recommended,,} == "y" ]]; then
		apt install net-tools
		apt install htop
		apt install screenfetch
		python Assets/install_tools-message
	fi
}

#Install wifi for ssh
install_wifi () {
	until [[ ${Install_wifi,,} =~ [y/n] ]]; do
		read -rp "Connect to wireless? [y/n]: " Install_wifi
	done

	if [[ ${Install_wifi,,} == "y" ]]; then
                #Make Wifi config file
                wifi_file_path=/boot/wpa_supplicant.conf
                echo "country=US" > $wifi_file_path
                echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" >> $wifi_file_path
                echo "update_config=1" >> $wifi_file_path
                echo "" >> $wifi_file_path
                echo "network={" >> $wifi_file_path
                read -p "Network SSID: " network_SSID
                read -p "Network Password: " network_password
                echo "  "ssid='"'$network_SSID'"' >> $wifi_file_path
                echo "  "psk='"'$network_password'"' >> $wifi_file_path
                echo "  "key_mgmt=WPA-PSK >> $wifi_file_path
                echo } >> $wifi_file_path
                touch /boot/ssh
			
	fi
}

#Install bluetooth for ssh
install_bluetooth () {
	until [[ ${Install_bluetooth,,} =~ [y/n] ]]; do
		read -rp "Install bluetooth? [y/N]: " Install_bluetooth
	done

	if [[ ${Install_bluetooth,,} == "y" ]]; then
		apt-get install bluez-tools
		bash Assets/bluetooth_files.sh
		systemctl enable systemd-networkd
		systemctl enable bt-agent
		systemctl enable bt-network
		systemctl start systemd-networkd
		systemctl start bt-agent
		systemctl start bt-network
		bt-adapter -s Discoverable 1
		python Assets/install_bluetooth-message.py
	fi
}
update_pi
install_tools
install_wifi
install_bluetooth
