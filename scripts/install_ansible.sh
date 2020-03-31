#! /bin/bash
ANSIBLE_USER=vagrant
ANSIBLE_SSH_KEY=/home/$ANSIBLE_USER/.ssh/ansible_key

apt-get update
apt-get install -y ansible
cp /vagrant/keys/ansible_key $ANSIBLE_SSH_KEY
chown $ANSIBLE_USER:$ANSIBLE_USER $ANSIBLE_SSH_KEY
chmod 400 $ANSIBLE_SSH_KEY
touch /home/$ANSIBLE_USER/.ssh/known_hosts
chown $ANSIBLE_USER:$ANSIBLE_USER /home/$ANSIBLE_USER/.ssh/known_hosts
