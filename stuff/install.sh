#!/bin/bash

## Piggy-backing on Pihole service ##
#(/i insert above, /a insert below)
# Insert run lines below the call capsh comment
sed -i "/^capsh /i cp -n \/temp\/stubby.yml \/config/" /etc/s6-overlay/s6-rc.d/pihole-FTL/run
sed -i "/^capsh /i cp -n \/temp\/cloudflared.yml \/config/" /etc/s6-overlay/s6-rc.d/pihole-FTL/run
sed -i "/^capsh /i stubby -g -C \/config\/stubby.yml" /etc/s6-overlay/s6-rc.d/pihole-FTL/run
sed -i "/^capsh /i start-stop-daemon --start --background --name cloudflared --chdir \/config --exec \/usr\/local\/bin\/cloudflared -- --config \/config\/cloudflared.yml" /etc/s6-overlay/s6-rc.d/pihole-FTL/run

# Insert finish lines above kill pihole - temporary disable due to some strange issues
#sed -i "/^killall -15 pihole-FTL/i killall -15 cloudflared" /etc/s6-overlay/s6-rc.d/pihole-FTL/finish
#sed -i "/^killall -15 pihole-FTL/i killall -15 stubby" /etc/s6-overlay/s6-rc.d/pihole-FTL/finish
