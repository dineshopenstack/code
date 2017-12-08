#!/bin/bash
TOKEN=`cat token`
export OS_TOKEN=$TOKEN
export OS_URL="http://controller:35357/v3"
export OS_IDENTITY_API_VERSION=3
openstack service list | grep -i identity
if [ $? -eq 0 ]; then
   echo "service already exists"
else
   openstack service create \
  --name keystone --description "OpenStack Identity" identity
  
   openstack endpoint create --region RegionOne \
  identity public http://controller:5000/v3
  
   openstack endpoint create --region RegionOne \
  identity internal http://controller:5000/v3

   openstack endpoint create --region RegionOne \
  identity admin http://controller:35357/v3

fi
