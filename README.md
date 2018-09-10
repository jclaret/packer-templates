# Packer/Ansible  - Create a RHEL 7.5 image and upload it to RHEV Manager

This example create a qcow2 RHEL7.5 image with packer and ansible and upload it to your RHV Engine in order to create a new template. 

The image could be created based on a packer / cloud init or packer / kickstart configuration and you can apply any ansible roles/playbooks 
that it could be useful for you, this example use a simple ansible role to register a RHEL box, update all packages and configure a simple motd
file.

## Paternity

This repo is a shamelessly fork from [Tinsjourney](https://github.com/tinsjourney), modified to create a Red Hat Enterprise Linux qemu box based on 
cloud-init or ks configuration.
So all gratitude should go to him, and all criticism to myself.

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build the Vagrant box file:

  - [Packer](http://www.packer.io/)
  - [Ansible](http://docs.ansible.com/intro_installation.html)
  - [Red Hat Subcription] If you don't, [create an account](https://developers.redhat.com) 

## Usage

  - Make sure all the required software is installed.
  - cd to the packer-rhel-7 directory
  - Copy RHEL's ISO images in iso/ directory iso's [rhel-server-7.5-x86_64-dvd.iso](https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.5/x86_64/product-software)  [rhel-server-7.5-x86_64-kvm.qcow2](https://access.redhat.com/downloads/content/69/ver=/rhel---7/7.5/x86_64/product-software)  .
  - Edit vars/rhel75_cloud_vars.json (based on cloud init) or vars/rhel75_ks_vars.json (based on kickstart) file, check if `iso_urls` and `iso_checksum` match your RHEL iso.
  - Create ansible variables file variables.yml, with your RHSM and RHV Engine informations
```
---
rhn_pool: "pool_id"
rhn_username: "username"
rhn_password: "changeme"
rhn_repos: [
        "rhel-7-server-rpms"
        "rhel-7-server-ansible-2.6-rpms",
        "rhel-7-server-common-rpms"
]
rhn_register: present

engine_url: https://engine.local.net/ovirt-engine/api
engine_user: admin@internal
engine_password: changeme
engine_cafile: /etc/pki/ovirt-engine/ca.pem

qcow_url: http://127.0.0.1/images/packer-rhel-7-x86_64.qcow2
template_cluster: emmett
image_base_hostname: packer.local.net
template_name: packer_template
template_memory: 4GiB
template_cpu: 1
template_disk_storage: vmstore01
```

- Run create_cloudinit_image.sh script for a cloud-init based image (modify cloud-init/user-data.txt if you desired) :

```
    $ create_cloudinit_image.sh
```

- or a create_kickstart_image.sh script for a kisckstart based image (modify http/ks.cfg if you desired) :
```
    $ create_kickstart_image.sh
```

- Finally, install the ansible role and run the ansible playbook to upload the new qcow2 file to RHEV
```
    $ ansible-galaxy install -r requirements.yml
    $ ansible-playbook ansible/rhv_create_template.yml
```

## License

Apache License 2.0
