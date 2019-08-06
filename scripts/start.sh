#!/bin/sh
# configure the vmware modules
/usr/bin/vmware-modconfig --console --install-all || true

# start all vmware services
/etc/init.d/vmware start || true
/etc/init.d/vmware-workstation-server start
