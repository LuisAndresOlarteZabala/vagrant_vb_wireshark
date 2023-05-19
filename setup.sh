#!/bin/bash

echo " Actualizar el sistema "
sudo apt-get update
sudo apt-get upgrade -y

echo " Instalar el entorno de escritorio "
sudo apt-get install -y ubuntu-desktop

echo " Crear un usuario con contraseña 'vagrant' y agregarlo al grupo 'sudo' "
sudo useradd -m -p $(openssl passwd -1 vagrant) -s /bin/bash vagrant
sudo usermod -aG sudo vagrant
