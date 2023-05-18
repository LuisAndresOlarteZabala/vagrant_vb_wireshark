#!/bin/bash

echo "*********************** Actualizar el sistema ***********************"
sudo apt-get update

echo "*********************** Instalar Wireshark ***********************"
sudo apt-get install -y wireshark

echo "*********************** Crear un usuario con contraseña 'wireshark' y agregarlo al grupo 'sudo' ***********************"
sudo usermod -aG wireshark $(whoami)

ls -l /usr/bin/dumpcap
sudo chgrp wireshark /usr/bin/dumpcap
sudo chmod 750 /usr/bin/dumpcap