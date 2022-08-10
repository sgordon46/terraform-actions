#!/bin/bash
apt-get -y update
apt-get install -y awscli
apt-get install -y jq
curl -fsSL https://get.docker.com -o /home/ubuntu/get-docker.sh
sh /home/ubuntu/get-docker.sh
usermod -aG docker ubuntu

generate_post_data_user()
{
cat <<EOF
{"username":"${tl_username}",
 "password":"${tl_password}"}
EOF
}


echo "set -o vi" >> /home/ubuntu/.profile
echo "PS1=\"\[\033[36m\]\$${USER:0:7}\[\033[m\]@\[\033[32m\]\$${HOSTNAME:0:23}:\[\033[33;1m\]\w\[\033[m\]$ \" " >> /home/ubuntu/.profile


export TOKEN=$(curl -s -k -H "Content-Type: application/json" -d "$(generate_post_data_user)" ${tl_console}/api/v1/authenticate | jq .token)

echo "TOKEN: $TOKEN"

