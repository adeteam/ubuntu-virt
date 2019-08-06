#!/bin/bash
# install build utils (NOTE: import that this is install during container startup and not during build)
apt-get install -y linux-headers-$(uname -r) linux-image-$(uname -r)

# configure the vmware modules
/usr/bin/vmware-modconfig --console --install-all || true

sleep 1

# start all vmware services
/etc/init.d/vmware start || true
sleep 1

/etc/init.d/vmware-workstation-server start || true
