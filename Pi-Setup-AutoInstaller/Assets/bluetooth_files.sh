#!/bin/bash
#Create Bluetooth Conf Files
make_bluetoothfiles () {
	bluetooth_netconf_path=/etc/systemd/network
#Network files setup
echo "[NetDev]
Name=pan0
Kind=bridge" >> $bluetooth_netconf_path/pan0.netdev

echo "[Match]
Name=pan0
[Network]
Address=172.20.1.1/24
DHCPServer=yes" >>  $bluetooth_netconf_path/pan0.network

	bluetooth_service_path=/etc/systemd/system
#Network services setup
echo "[Unit]
Description=Bluetooth Auth Agent
[Service]
ExecStart=/usr/bin/bt-agent -c NoInputNoOutput
Type=simple
[Install]
WantedBy=multi-user.target" >> $bluetooth_service_path/bt-agent.service

echo "[Unit]
Description=Bluetooth NEP PAN
After=pan0.network
[Service]
ExecStart=/usr/bin/bt-network -s nap pan0
Type=simple
[Install]
WantedBy=multi-user.target" >> $bluetooth_service_path/bt-network.service
}
make_bluetoothfiles

