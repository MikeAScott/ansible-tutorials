# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_API_VERSION = "2"
CONTROL_IP = "192.168.35.10"
WEB1_IP = "192.168.35.20"

Vagrant.configure(VAGRANT_API_VERSION) do |config|

  config.vm.define "web1" do |web1|
    web1.vm.box = "centos/7"
    web1.vm.hostname = 'web1'
    web1.vm.network :private_network, ip: WEB1_IP
    web1.vm.network "forwarded_port",id: "tomcat", guest: 8080, host: 8080

    web1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 256]
    end

    web1.vm.provision "shell", inline: <<-SCRIPT
      cat /vagrant/keys/ansible_key.pub >> /home/vagrant/.ssh/authorized_keys
    SCRIPT
  end

  config.vm.define "control" do |control|
    control.vm.box = "ubuntu/bionic64"
    control.vm.hostname = 'control'
    control.vm.network :private_network, ip: CONTROL_IP

    control.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
      v.customize ["modifyvm", :id, "--name", "control"]
    end

    control.vm.provision "shell", path: "scripts/install_ansible.sh"
    control.vm.provision "shell", inline: <<-SCRIPT
      echo "#{WEB1_IP} web1" >> /etc/hosts
      ssh-keyscan -H web1 >> /home/vagrant/.ssh/known_hosts
    SCRIPT
    control.vm.provision "shell", inline: <<-SCRIPT
      runuser -l vagrant -c 'ansible-playbook /vagrant/playbooks/web-server.yml'
    SCRIPT
  end

end 

