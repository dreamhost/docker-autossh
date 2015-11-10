# Teensy autossh tunnel maintenance
#
# By default, we create the local port as a gatewayport (as it'd be fairly
# difficult to use otherwise).
#
# You should do a bind-mount to get ssh configuration, public-keys, etc, into
# the running container.
#
#   -v dotssh:/root/.ssh:ro

FROM ubuntu:trusty
MAINTAINER Chris Weyl <chris.weyl@dreamhost.com>

RUN \
	apt-get update && \
	DEBIAN_FRONTEND=noninteractive \
		apt-get -y install autossh && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

RUN rm -f /etc/ssh/ssh_known_hosts ; \
    mkdir -vp /root/.ssh/ ; \
    chmod go-rwx /root/.ssh/

VOLUME /root/.ssh

ENTRYPOINT [ "autossh", "-vgN" ]
