Vagrant.configure("2") do |config|
  config.vm.define "VM2" do |vm2|
    vm2.vm.box = "ubuntu/focal64"
    vm2.vm.network "private_network", ip: "192.168.33.11"
    vm2.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--nic1", "nat"]
      vb.gui = true
      vb.memory = "1024"
    end
    vm2.vm.boot_timeout = 60
  end

  config.vm.define "VM1" do |vm1|
    vm1.vm.box = "ubuntu/focal64"
    vm1.vm.network "private_network", ip: "192.168.33.10"
    vm1.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--nic1", "nat"]
      vb.gui = true
      vb.memory = "2048"
    end
    vm1.vm.provision "shell", path: "setup.sh"
    vm1.vm.provision "shell", path: "wireshark_install.sh"
    vm1.vm.boot_timeout = 60
  end
end
