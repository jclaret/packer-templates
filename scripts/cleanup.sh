#!/bin/bash -eux
# Steps to make a clean VM for use as a template or clone
# https://access.redhat.com/solutions/198693

subscription-manager unsubscribe --all
subscription-manager unregister
subscription-manager clean

rm -f /etc/udev/rules.d/70-persistent-net.rules
rm -rf /var/log/rhsm/*
rm -rf /tmp/*
rm -rf /var/cache/yum/*
rm -rf /etc/ssh/ssh_host_*
rm -rf /home/packer/setup
touch /.unconfigured
