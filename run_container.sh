#!/usr/bin/env bash

docker run -tu `id -u` \
       -e PLAYBOOK_FILE=playbooks/aws/openshift-cluster/provision_install.yml \
       -e OPTS="-v" \
       docker.io/openshift/origin-ansible:v3.11
