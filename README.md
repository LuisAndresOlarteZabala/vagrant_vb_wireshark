#

## Actividad 1

1.	Instala dos máquinas virtuales usando vagrant Ubuntu con VirtualBox. La VM1 debe tener entorno de escritorio y en ella instalarás Wireshark. La VM2 puede no tener entorno gráfico, como prefieras.

    Para instalar dos máquinas virtuales usando Vagrant con VirtualBox, sigue los siguientes pasos:

    * Instala VirtualBox en tu sistema operativo.
    * Instala Vagrant en tu sistema operativo.
    * Crea un directorio para tu proyecto de Vagrant.
    * En ese directorio, crea un archivo llamado "Vagrantfile" y ábrelo con un editor de texto.
    * Dentro del archivo Vagrantfile, configura la primera máquina virtual (VM1) con un entorno de escritorio y la instalación de Wireshark. Aquí tienes un ejemplo de cómo se vería la configuración:
  
    ``` shell
    Vagrant.configure("2") do |config|
    config.vm.define "VM1" do |vm1|
        vm1.vm.box = "ubuntu/focal64"
        vm1.vm.network "private_network", ip: "192.168.33.10"
        vm1.vm.provider "virtualbox" do |vb|
        vb.gui = true
        vb.memory = "2048"
        end
    vm1.vm.provision "shell", inline: <<-SHELL
        # " Actualizar el sistema "
        sudo apt-get update
        sudo apt-get upgrade -y

        # " Instalar el entorno de escritorio "
        sudo apt-get install -y ubuntu-desktop

        # " Crear un usuario con contraseña 'vagrant' y agregarlo al grupo 'sudo' "
        sudo useradd -m -p $(openssl passwd -1 vagrant) -s /bin/bash vagrant
        sudo usermod -aG sudo vagrant
        echo " Instalar Wireshark "
        sudo apt-get install -y wireshark

        # " Crear un usuario con contraseña 'wireshark' y agregarlo al grupo 'sudo' "
        sudo usermod -aG wireshark $(whoami)

        ls -l /usr/bin/dumpcap
        sudo chgrp wireshark /usr/bin/dumpcap
        sudo chmod 750 /usr/bin/dumpcap
        sudo pkg-reconfigure wireshark-common
        SHELL
    end

    config.vm.define "VM2" do |vm2|
        vm2.vm.box = "ubuntu/focal64"
        vm2.vm.network "private_network", ip: "192.168.33.11"
        vm2.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        end
    end
    end
    ```

    * Guarda y cierra el archivo Vagrantfile.
    * Abre una terminal y navega hasta el directorio del proyecto Vagrant.
    * Ejecuta el comando vagrant up para crear y provisionar las máquinas virtuales según la configuración del archivo Vagrantfile.
    * Espera a que las máquinas virtuales se creen y se configuren correctamente.
    * Para acceder a la VM1 con entorno de escritorio, ejecuta el comando vagrant ssh VM1. Esto abrirá una conexión SSH a la máquina virtual.
    * Para acceder a la VM2 sin entorno gráfico, ejecuta el comando vagrant ssh VM2.
    * Ahora tienes dos máquinas virtuales creadas utilizando Vagrant y VirtualBox. La VM1 tiene un entorno de escritorio y Wireshark instalado, mientras que la VM2 no tiene entorno gráfico.

2.	Anota las direcciones IP de ambas máquinas. Deben estar en la misma subred, así que asegúrate de que la configuración de red de VirtualBox es la misma.

    Para anotar las direcciones IP de ambas máquinas virtuales en la misma subred, puedes seguir estos pasos:

    * Asegúrate de que las máquinas virtuales están encendidas y ejecutándose.
    * Abre una terminal y navega hasta el directorio de tu proyecto Vagrant.
    * Ejecuta el comando vagrant status para verificar el estado de las máquinas virtuales y obtener sus nombres.
    * Ejecuta el comando para obtener la configuración SSH de cada máquina virtual. 

    ``` shell
    vagrant ssh-config <nombre_de_la_maquina>
    ```

    Reemplaza <nombre_de_la_maquina> con el nombre real de cada una de las máquinas virtuales que definiste en el archivo Vagrantfile.

    Por ejemplo, para obtener la dirección IP de la VM1, ejecuta el siguiente comando:

    ``` shell
    vagrant ssh-config VM1
    ```

    Esto mostrará la configuración SSH de la VM1, incluyendo la dirección IP asignada por Vagrant.

    Repite el mismo proceso para obtener la dirección IP de la VM2:

    ``` shell
    vagrant ssh-config VM2
    ``` 

    Anota las direcciones IP de ambas máquinas virtuales y asegúrate de que pertenezcan a la misma subred. Si es necesario, verifica la configuración de red de VirtualBox para asegurarte de que las máquinas virtuales están utilizando la misma red.

3.	Instala Wireshark en una de las máquinas virtuales (si sólo una tiene escritorio gráfico, hazlo en esta).

    Para instalar Wireshark en la máquina virtual con entorno gráfico (VM1), sigue estos pasos:

    Abre una conexión SSH a la máquina virtual VM1. Puedes hacerlo ejecutando el siguiente comando en la terminal:

    ``` shell
    vagrant ssh VM1
    ``` 

    Una vez dentro de la máquina virtual, ejecuta los siguientes comandos para actualizar los repositorios de paquetes e instalar Wireshark:

    ``` shell
    sudo apt update
    sudo apt install -y wireshark
    ```

    Durante la instalación de Wireshark, se te pedirá que elijas un usuario para agregar al grupo "wireshark" con el fin de tener acceso a la captura de paquetes. Selecciona tu usuario actual y continúa con la instalación.

    Una vez completada la instalación, puedes ejecutar Wireshark abriendo una ventana del terminal y escribiendo el siguiente comando:

    ``` shell
    wireshark
    ```

    Esto abrirá la interfaz gráfica de Wireshark en la máquina virtual VM1.

    Recuerda que para acceder a la máquina virtual con entorno gráfico, debes tener habilitada la opción "gui" en la configuración de la máquina virtual VM1 en el archivo Vagrantfile, como se mencionó en la respuesta anterior.

4.	Arranca una captura de prueba en Wireshark sin ningún filtro y haz un ping desde una de las máquinas a la otra. Da igual quien inicie el tráfico: deberías ver el tráfico en la ventana de Wireshark.

    Para realizar una captura de prueba en Wireshark y observar el tráfico generado por un ping entre las máquinas virtuales, sigue estos pasos:

    Asegúrate de que las máquinas virtuales están encendidas y ejecutándose.

    Accede a la máquina virtual en la que has instalado Wireshark (VM1 en este caso) a través de una conexión SSH. Ejecuta el siguiente comando en una terminal:

    ``` shell
    vagrant ssh VM1
    ```

    Una vez dentro de la máquina virtual VM1, ejecuta el siguiente comando para iniciar Wireshark en modo gráfico:

    ``` shell
    wireshark
    ```
    Esto abrirá la interfaz gráfica de Wireshark en la máquina virtual VM1.

    En la ventana principal de Wireshark, selecciona la interfaz de red en la que deseas capturar el tráfico. Puede haber múltiples opciones disponibles, por lo que debes elegir la interfaz correcta para tu configuración. La interfaz de red puede tener un nombre como "eth0" o "enp0s3".

    Haz clic en el botón "Start" o "Iniciar" (el ícono de un círculo rojo) en Wireshark para comenzar la captura de paquetes en la interfaz seleccionada.

    Desde otra terminal o ventana de conexión SSH, accede a la segunda máquina virtual (VM2) ejecutando el siguiente comando:

    ``` shell
    vagrant ssh VM2
    ```

    Una vez dentro de la máquina virtual VM2, realiza un ping a la dirección IP de la otra máquina virtual. Por ejemplo, si la dirección IP de la VM1 es "192.168.33.10", ejecuta el siguiente comando:

    ``` shell
    ping 192.168.33.10
    ```

    Esto generará tráfico de ping desde la máquina virtual VM2 hacia la máquina virtual VM1.

    En la ventana de Wireshark en la máquina virtual VM1, deberías ver el tráfico capturado correspondiente al ping que se realizó desde la máquina virtual VM2. Los paquetes de ping se mostrarán en la lista de paquetes capturados.

    De esta manera, podrás verificar que Wireshark está capturando el tráfico de red generado por el ping entre las máquinas virtuales.

## Vagrand Commands

Vagrant es una herramienta de línea de comandos que se utiliza para crear y administrar entornos de desarrollo portátiles. A continuación se presentan algunos comandos útiles que puede utilizar en Vagrant:

* vagrant init: Este comando inicializa un nuevo archivo de configuración Vagrant en el directorio actual. El archivo generado se llama Vagrantfile y es el archivo de configuración principal de Vagrant.
* vagrant up: Este comando inicia la máquina virtual de Vagrant según la configuración definida en el archivo Vagrantfile. Si la máquina virtual aún no está creada, Vagrant la creará automáticamente.
* vagrant ssh: Este comando se utiliza para conectarse a la máquina virtual de Vagrant a través de una conexión SSH. Una vez conectado, puede utilizar la máquina virtual como lo haría con cualquier otra máquina remota.
* vagrant halt: Este comando detiene la máquina virtual de Vagrant. El estado actual de la máquina se guardará y se podrá reanudar más tarde con el comando vagrant up.
* vagrant destroy: Este comando elimina completamente la máquina virtual de Vagrant. Todos los datos y configuraciones asociados se perderán. Este comando es útil si desea eliminar completamente una máquina virtual de Vagrant y comenzar desde cero.
* vagrant status: Este comando muestra el estado actual de la máquina virtual de Vagrant. Le permite saber si la máquina virtual está en ejecución, detenida o si aún no se ha creado.
* vagrant provision: Este comando se utiliza para volver a ejecutar la configuración de aprovisionamiento de la máquina virtual de Vagrant. Si ha actualizado el archivo de configuración Vagrantfile o si desea volver a ejecutar los scripts de aprovisionamiento, puede utilizar este comando.
* vagrant box: Este comando se utiliza para trabajar con cajas de Vagrant. Las cajas son archivos de imagen que contienen una configuración preconfigurada para la creación de máquinas virtuales. Este comando le permite agregar, eliminar y administrar cajas de Vagrant.

Estos son solo algunos de los comandos más útiles de Vagrant. Para obtener más información, puede consultar la documentación oficial de Vagrant.