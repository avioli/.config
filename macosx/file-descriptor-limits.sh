#!/usr/bin/env bash

### Increase Mac OS X File Descriptor Limits:

# The following will raise the limits to allow 10 million files total,
# with 1 million files per process until your next reboot.

sudo sysctl -w kern.maxfiles=10485760
# kern.maxfiles: 12288 -> 10485760

sudo sysctl -w kern.maxfilesperproc=1048576
# kern.maxfilesperproc: 10240 -> 1048576

# Putting the following into a file named /etc/sysctl.conf on OS X will
# cause these values to persist across reboots:

if test -e /etc/sysctl.conf; then
	sudo echo "# `date`: Backed up sysctl.conf" >> /etc/sysctl.conf.bak
	sudo cat /etc/sysctl.conf >> /etc/sysctl.conf.bak
fi

sudo cat <<-EOF > /etc/sysctl.conf 
kern.maxfiles=10485760
kern.maxfilesperproc=1048576
EOF
