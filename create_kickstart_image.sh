#!/bin/bash
export PACKER_LOG=1
packer validate -var-file=vars/rhel75_ks_vars.json packer_rhel7_kickstart.json
test $? -eq 0 && packer build -var-file=vars/rhel75_ks_vars.json packer_rhel7_kickstart.json || echo "Error validating json file"
