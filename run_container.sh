#!/bin/bash

AWS_ACCESS_KEY_ID=$(./get-aws-profile.sh --key)
AWS_SECRET_ACCESS_KEY=$(./get-aws-profile.sh --secret)
INVENTORY_PATH=/home/nshneor/workspace/openshift-ansible-scripts/inventory.yml

docker run -tu `id -u` \
       -v $HOME/.ssh/id_rsa:/opt/app-root/src/.ssh/id_rsa:Z,ro \
       -v $HOME/workspace/openshift-ansible-scripts/provisioning_vars.yml.j2:/usr/share/ansible/provisioning_vars.yml.j2:Z,ro \
       -v $HOME/workspace/openshift-ansible-scripts/vars.yaml:/usr/share/ansible/vars.yaml:Z,ro \
       -v $INVENTORY_PATH:/usr/share/ansible/inventory.yml:Z,ro \
       -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
       -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
       -e PLAYBOOK_FILE=playbooks/aws/openshift-cluster/provision_from_scratch.yml \
       -e INVENTORY_FILE=/usr/share/ansible/inventory.yml \
       -e OPTS="-vvv -e @/usr/share/ansible/vars.yaml" -t \
       clusters_service/openshift-ansible-test:latest
