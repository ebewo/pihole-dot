#!/bin/bash

# Creating pihole-dot-doh service
mkdir -p /etc/services.d/pihole-dot
# run file

echo '#!/usr/bin/with-contenv bash' > /etc/services.d/pihole-dot/run
# Copy config file if not exists
echo 'cp -n /temp/stubby.yml /config/' >> /etc/services.d/pihole-dot/run
# run stubby in background
echo 's6-echo "Starting stubby"' >> /etc/services.d/pihole-dot/run
echo 'stubby -v 5 -C /config/stubby.yml' >> /etc/services.d/pihole-dot/run

# finish file
echo '#!/usr/bin/with-contenv bash' > /etc/services.d/pihole-dot/finish
echo 's6-echo "Stopping stubby"' >> /etc/services.d/pihole-dot/finish
echo 'killall -9 stubby' >> /etc/services.d/pihole-dot/finish
