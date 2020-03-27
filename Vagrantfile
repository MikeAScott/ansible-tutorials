# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_API_VERSION = "2"


Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.define "web1" do |web1|
    web1.vm.box = "centos/7"
    web1.vm.hostname = 'web1'

    web1.vm.network :private_network, ip: "192.168.35.101"

    web1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
      v.customize ["modifyvm", :id, "--name", "web1"]
    end
    web1.vm.provision "file", source: "keys/ansible_key.pub", destination: "~/.ssh/ansible_key.pub"
    web1.vm.provision "shell", inline: <<-SCRIPT
      cat /home/vagrant/.ssh/ansible_key.pub >> /home/vagrant/.ssh/authorized_keys
    SCRIPT
  end


  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/bionic64"
    control.vm.hostname = 'control'

    control.vm.network :private_network, ip: "192.168.35.10"

    control.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "control"]
    end
    control.vm.provision "file", source: "keys/ansible_key", destination: "~/.ssh/ansible_key"   
    control.vm.provision "shell", inline: <<-SCRIPT
      apt-get update
      apt-get install -y ansible
      chmod 400 /home/vagrant/.ssh/ansible_key
      echo "web ansible_host=192.168.35.101 ansible_connection=ssh ansible_ssh_private_key_file=/home/vagrant/.ssh/ansible_key" >> /etc/ansible/hosts
      ssh-keyscan -H 192.168.35.101 >> /home/vagrant/.ssh/known_hosts
    SCRIPT
  end

end

