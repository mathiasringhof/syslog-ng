FROM debian:bookworm-slim

# Install syslog-ng and any minimal dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends syslog-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy your custom syslog-ng configuration.
# Alternatively, this will be mounted from a ConfigMap in Kubernetes.
# If mounting, you might just ensure the default /etc/syslog-ng/syslog-ng.conf 
# is replaced or that syslog-ng is started pointing to the mounted config.
# COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf 

# Standard syslog UDP port
EXPOSE 1514/udp 

# Run syslog-ng in the foreground, do not drop capabilities immediately if binding to low port as root
# The exact command might vary slightly based on the syslog-ng version from Debian.
# Often, the package maintainer scripts handle running it correctly.
# If running as non-root and binding to >1024, this is simpler.
# For binding to 514 as root (common in containers for this):
# CMD ["/usr/sbin/syslog-ng", "-F", "--no-caps"]
CMD ["/usr/sbin/syslog-ng", "-F", "-d", "--no-caps"]
