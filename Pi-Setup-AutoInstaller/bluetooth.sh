#!/bin/bash
#Turn Bluetooth Discovery on Pi on or off

Bluetooth_discovery () {
	until [[ ${State_of_bluetooth,,} =~ [on/off] ]]; do
		read -rp "Bluetooth Discovery [on/off]: " State_of_bluetooth
	done

	if [[ ${State_of_bluetooth,,} == "on" ]]
	then
		bt-adapter -s Discoverable 1
	else [[ ${State_of_bluetooth,,} == "off" ]]
		bt-adapter -s Discoverable 0
	fi
}
Bluetooth_discovery
