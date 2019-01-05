#!/bin/bash
ip=`cat /etc/hosts | grep 'K8s\|Ansible'|awk '{print $1}'`
pass="root"
port="1804"
yum install -y expect
for i in ${ip[@]}
do
expect -c " 
spawn ssh-copy-id -p${port} -i /root/.ssh/id_rsa.pub root@${i}
expect { 
\"*yes/no*\" {send \"yes\r\"; exp_continue} 
\"*password*\" {send \"${pass}\r\"; exp_continue} 
\"*Password*\" {send \"${pass}\r\";} 
} "
done
