#!/bin/bash

echo " Actualizar el sistema "
sudo apt-get update

echo " Instalar herramientas de red "
sudo apt-get install -y net-tools

echo " Instalar herramientas para interfaz Netlink "
sudo apt-get install -y libnl-3-dev

echo "1. Instalar Wireshark "
sudo apt-get install -y wireshark

echo "2. Crear un usuario con contraseña 'wireshark' y agregarlo al grupo 'sudo' "
sudo usermod -aG wireshark vagrant

ls -l /usr/bin/dumpcap
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 777 /usr/bin/dumpcap

sudo dpkg-reconfigure wireshark-common -y
sudo usermod -a -G wireshark vagrant

echo "3. Iniciamos wireshark "
#sudo wireshark