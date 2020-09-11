#!/bin/bash

# Creating pihole-dot-doh service
mkdir -p /etc/services.d/pihole-dot-doh

# run file
echo '#!/usr/bin/with-contenv bash' > /etc/services.d/pihole-dot-doh/run
# Copy config file if not exists
echo 'cp -n /temp/stubby.yml /config/' > /etc/services.d/pihole-dot-doh/run
echo 'cp -n /temp/cloudflared.yml /config/' > /etc/services.d/pihole-dot-doh/run
# run stubby as service
echo 's6-echo "Starting stubby"' >> /etc/services.d/pihole-dot-doh/run
echo 'stubby -C /config/stubby.yml' >> /etc/services.d/pihole-dot-doh/run
# run cloudflared as service
echo 's6-echo "Starting cloudflared"' >> /etc/services.d/pihole-dot-doh/run
echo '/usr/local/bin/cloudflared --config /config/cloudflared.yml' >> /etc/services.d/pihole-dot-doh/run

# finish file
echo '#!/usr/bin/with-contenv bash' > /etc/services.d/pihole-dot-doh/finish
echo 's6-echo "Stopping stubby"' >> /etc/services.d/pihole-dot-doh/finish
echo 'killall -9 stubby' >> /etc/services.d/pihole-dot-doh/finish
echo 's6-echo "Stopping cloudflared"' >> /etc/services.d/pihole-dot-doh/finish
echo 'killall -9 cloudflared' >> /etc/services.d/pihole-dot-doh/finish
