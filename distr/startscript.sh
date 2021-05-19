#!/bin/bash
echo "HelloWorld. The following software must be correctly installed on local machine: Vagrant, Oracle VirtualBox, Ancible (inventory in ansible.cfg must be equal ./hosts.txt), Jenkins, Maven, Git. Is it done? (Y/N)"
read answer
case $answer in
         Y|y|Yes|yes)
                  echo "Ok. Let's go"
                   ;;
         N|n|No|no)
                  echo "Sorry... Install all you need and start again. Hasta la vista!!!"
                  exit 
                  ;;
         *)
                  echo "I don't understand what do you mean, but... Hasta la vista!!!"
                  exit
                  ;;


esac


#------------------------ Resetting the variables:)----------------------
rm ./Vagrantfile
chmod 777 ./private_key
rm ./private_key
rm ./hosts.txt
rm ./group_vars/ -r
rm jSudoku-src-1.3.tar.gz
rm Sudoku-src/ -r 
rm src -r
rm playbook1.yml
sudo ssh-keygen -f "/root/.ssh/known_hosts" -R "[127.0.0.1]:2222"

#-----------------------Let's make CM preparation---------------------------------------
cat << EOF > playbook1.yml
---
- name: Install SW
  hosts: Virtual
  become: yes
  tasks:
  - name: Test
    debug: var=ansible_os_family


  - block: #-----For RedHat-------
    - name: Soft_install_RedHat
      yum: name=httpd state=latest
    - name: Start Apache
      service: name=httpd state=started enabled=yes

    when: ansible_os_family == "RedHat"



  - block: #-----For Debian-------
    - name: Soft_install_Debian
      apt: name=apache2 state=latest

    when: ansible_os_family == "Debian"

  - name: Access dir correction
    file: dest=/var/www/html/ mode=777
  - name: Access file correction
    file: dest=/var/www/html/index.html mode=777
    ignore_errors: yes

EOF

cat << EOF > hosts.txt
[Virtual]
VagrantVBoxVMhostname ansible_host=127.0.0.1
EOF

mkdir group_vars
cat << EOF > ./group_vars/Virtual
---
ansible_port : 2222
ansible_user : vagrant
ansible_ssh_private_key_file : ./private_key
EOF



#----------------------- Virtual environment creation-----------------------
vagrant init

               # Customising the box name according to user input
echo "Enter the existing Vagrant box name(examples: ubuntu/xenial64, centos/7 e.t.c):"
read vagrantboxname 

               # Varantfile creation
cat << EOF > Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "$vagrantboxname"
  config.vm.box_check_update = false

  config.vm.define "VagrantVBoxVMhostname" 

  config.vm.hostname = "VMhostname"
  config.vm.network "forwarded_port", guest: 80, host: 3333, host_ip: "127.0.0.1"
  config.vm.provider "virtualbox" do |vb|
  vb.name = "VBoxVMhostname"
                                  end
config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "./hosts.txt"
#    ansible.limit = "all"
    ansible.playbook = "playbook1.yml"
                              end
end
EOF

vagrant up



cp ./.vagrant/machines/VagrantVBoxVMhostname/virtualbox/private_key ./
chmod 444 ./private_key
vagrant status

#sudo ansible-playbook playbook1.yml -i ./hosts.txt


