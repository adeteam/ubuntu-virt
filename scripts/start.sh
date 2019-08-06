#!/bin/bash
# configure the vmware modules
/usr/bin/vmware-modconfig --console --install-all || true

sleep 1

# start all vmware services
/etc/init.d/vmware start || true
sleep 1

/etc/init.d/vmware-workstation-server start || true
