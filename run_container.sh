#!/bin/bash

aws_access_key_id=$(./get-aws-profile.sh --key)
aws_secret_access_key=$(./get-aws-profile.sh --secret)
aws_profile=opstest-c42b

INVENTORY_PATH=/home/nshneor/workspace/openshift-ansible-scripts/inventory.yml

docker run -tu `id -u` \
       -v $HOME/.ssh/id_rsa:/opt/app-root/src/.ssh/id_rsa:Z,ro \
       -v /etc/ansible/hosts:$INVENTORY_PATH \
       -e PLAYBOOK_FILE=playbooks/aws/openshift-cluster/provision_install.yml \
       -e INVENTORY_FILE=$INVENTORY_PATH \
       -e AWS_ACCESS_KEY_ID=$aws_access_key_id \
       -e AWS_SECRET_ACCESS_KEY=$aws_secret_access_key \
       -e OPTS="-v" -t \
       docker.io/openshift/origin-ansible:v3.11
