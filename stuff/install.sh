#!/bin/bash

## Piggy-backing on lighttpd service ##
# (/i insert above, /a insert below) #
# Avoid pihole service due to the need to restart for every config change #
# Insert run lines above the call lighttpd comment
sed -i "/^lighttpd /i cp -n \/temp\/stubby.yml \/config/" /etc/s6-overlay/s6-rc.d/lighttpd/run
sed -i "/^lighttpd /i cp -n \/temp\/cloudflared.yml \/config/" /etc/s6-overlay/s6-rc.d/lighttpd/run
sed -i "/^lighttpd /i stubby -g -C \/config\/stubby.yml" /etc/s6-overlay/s6-rc.d/lighttpd/run
sed -i "/^lighttpd /i start-stop-daemon --start --background --name cloudflared --chdir \/config --exec \/usr\/local\/bin\/cloudflared -- --config \/config\/cloudflared.yml" /etc/s6-overlay/s6-rc.d/lighttpd/run

# Insert finish lines above kill
sed -i "/^killall -9 lighttpd/i killall cloudflared" /etc/s6-overlay/s6-rc.d/lighttpd/finish
sed -i "/^killall -9 lighttpd/i killall stubby" /etc/s6-overlay/s6-rc.d/lighttpd/finish
