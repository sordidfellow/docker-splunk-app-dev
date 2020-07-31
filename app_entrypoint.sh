#!/bin/bash

echo Contents of /
ls -l /
echo Contents of /opt/splunk/etc
ls -l /opt/splunk/etc

# Create a symlink
sudo ln -s /host_app /opt/splunk-etc/apps/host_app || exit 1
sudo chown -R splunk:splunk /opt/splunk-etc/apps/host_app || exit 1
sudo chown -R splunk:splunk /host_app || exit 1

# Call out to the original entrypoint
/sbin/entrypoint.sh start-service 
