#!/bin/bash
set -e

# start all vmware services
/etc/init.d/vmware start || true

sleep 1

/etc/init.d/vmware-workstation-server start || true
