# -*- mode: ruby -*-
# vi: set ft=ruby :
VAGRANT_API_VERSION = "2"

CONTROL_IP = "192.168.35.10"
WEB1_IP    = "192.168.35.20"
DB1_IP     = "192.168.35.30"
DB2_IP     = "192.168.35.31"

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

  config.vm.define "db1" do |db1|
    db1.vm.box = "centos/7"
    db1.vm.hostname = 'db1'
    db1.vm.network :private_network, ip: DB1_IP

    db1.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    db1.vm.provision "shell", inline: <<-SCRIPT
      cat /vagrant/keys/ansible_key.pub >> /home/vagrant/.ssh/authorized_keys
    SCRIPT
  end

  config.vm.define "db2" do |db2|
    db2.vm.box = "ubuntu/bionic64"
    db2.vm.hostname = 'db2'
    db2.vm.network :private_network, ip: DB2_IP

    db2.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--memory", 512]
    end

    db2.vm.provision "shell", inline: <<-SCRIPT
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

    control.vm.synced_folder ".", "/vagrant",  :mount_options => ["dmode=750,fmode=750"]
    control.vm.provision "shell", path: "scripts/install_ansible.sh"
    control.vm.provision "shell", inline: <<-SCRIPT
      echo "#{WEB1_IP} web1" >> /etc/hosts
      ssh-keyscan -H web1 >> /home/vagrant/.ssh/known_hosts
      echo "#{DB1_IP} db1" >> /etc/hosts
      ssh-keyscan -H db1 >> /home/vagrant/.ssh/known_hosts
      echo "#{DB2_IP} db1" >> /etc/hosts
      ssh-keyscan -H db1 >> /home/vagrant/.ssh/known_hosts
    SCRIPT
    control.vm.provision "shell", inline: <<-SCRIPT
      runuser -l vagrant -c 'cd /vagrant/playbooks && ansible-playbook web-stack.yml'
    SCRIPT
  end

end 

