#!/bin/bash

AWS_ACCESS_KEY_ID=$(./get-aws-profile.sh --key)
AWS_SECRET_ACCESS_KEY=$(./get-aws-profile.sh --secret)
INVENTORY_PATH=/home/nshneor/workspace/openshift-ansible-scripts/inventory.yml

docker run -tu `id -u` \
       -v $HOME/.ssh/id_rsa:/opt/app-root/src/.ssh/id_rsa:Z,ro \
       -v $HOME/workspace/openshift-ansible-scripts/tmp-provisioning-vars.yml:/usr/share/ansible/provisioning_vars.yml:Z,ro \
       -v /etc/ansible/hosts:$INVENTORY_PATH \
       -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
       -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
       -e PLAYBOOK_FILE=playbooks/aws/openshift-cluster/provision_install.yml \
       -e INVENTORY_FILE=$INVENTORY_PATH \
       -e OPTS="-vvv -e @/usr/share/ansible/provisioning_vars.yml" -t \
       docker.io/openshift/origin-ansible:latest
