FROM splunk/splunk:latest

# Create mount point in image
USER root
RUN mkdir /host_app
RUN sudo chown splunk:splunk /host_app

# Create symlink for apps folder - ansible pulls from /opt/splunk-etc and installs in /opt/splunk/etc
USER splunk:splunk
RUN ln -s /host_app /opt/splunk-etc/apps/host_app
VOLUME ["/host_app"]

# Back to usual...
WORKDIR /opt/splunk

# Need to end up as ansible for splunk to work
USER ansible:ansible

# Set up the new entrypoint
COPY app_entrypoint.sh /opt/

# Hijack previous entrypoint to echo parameters
#USER root:root
#COPY echo_entrypoint.sh /sbin/entrypoint.sh
#RUN chmod 755 /sbin/entrypoint.sh
#USER ansible:ansible

# Hook into a new entrypoint that sets up bind mount
# ENTRYPOINT ["/opt/app_entrypoint.sh"]
