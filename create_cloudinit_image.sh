#!/bin/bash
export PACKER_LOG=1
packer validate -var-file=vars/rhel75_cloud_vars.json packer_rhel7_cloudinit.json
test $? -eq 0 && packer build -var-file=vars/rhel75_cloud_vars.json packer_rhel7_cloudinit.json || echo "Error validating json file"
