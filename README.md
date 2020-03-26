# Learning Ansible Lab01 
Create a simple control and web network to get Ansible bootstrapped

## How to set up
* Install Virtualbox 
* Install Vagrant
* create a keys folder
* Generate ansible ssh keys
```
ssh-keygen -t ed25519 -f keys/ansible_key
```
* run vagrant
```
vagrant up
```
* ssh to control box and run ansible ping
```
vagrant ssh control
ansible web -m ping
```
If you get a pong its working :)
