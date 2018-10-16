FROM openshift/origin-ansible:v3.11.0

COPY ./provision_from_scratch.yml playbooks/aws/openshift-cluster/provision_from_scratch.yml
