#!/bin/bash
# configure the vmware modules
/usr/bin/vmware-modconfig --console --install-all || true
# change port 443 to something different
sed -i 's|<httpsPort>443</httpsPort>|<httpsPort>11443</httpsPort>|' /etc/vmware/hostd/proxy.xml

sleep 1

# start all vmware services
/etc/init.d/vmware start || true
sleep 1

/etc/init.d/vmware-workstation-server start || true
