#!/bin/bash
#apt-get -y update
#apt-get install -y awscli

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

generate_post_data_user()
{
cat <<EOF
{"username":"${tl_username}",
 "password":"${tl_password}"}
EOF
}

echo "set -o vi" >> /home/ubuntu/.profile
echo "PS1=\"\[\033[36m\]\$${USER:0:7}\[\033[m\]@\[\033[32m\]\$${HOSTNAME:0:23}:\[\033[33;1m\]\w\[\033[m\]$ \" " >> /home/ubuntu/.profile


export TOKEN=$(curl -s -k -H "Content-Type: application/json" -d "$(generate_post_data_user)" ${tl_console}/api/v1/authenticate | python3 -c 'import sys, json; print(json.load(sys.stdin)["token"])')

echo "TOKEN: $TOKEN"

curl -sSL  --header "authorization: Bearer $TOKEN" -X POST ${tl_console}/api/v1/scripts/defender.sh -o defender.sh
chmod u+x defender.sh


sudo ./defender.sh -s -- -c "us-west1.cloud.twistlock.com" -d "none" -v -m -u 

#'AKIAZZZZZZZZZZZZZZZZ'
#'AKIAJSIE27KKMHXI3BJQ'

sudo echo "AKIAZZZZZZZZZZZZZZZZ" >> /opt/secrets
sudo echo "AKIAJSIE27KKMHXI3BJQ" >> /opt/secrets