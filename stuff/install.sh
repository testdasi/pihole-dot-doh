#!/bin/bash

# install stubby config
#cd /temp \
#    && mkdir -p /config/stubby \
#    && cp -n ./stubby.yml /config/stubby/ \
#    && rm -f ./stubby.yml

# install cloudflared config
#cd /temp \
#    && mkdir -p /config/cloudflared \
#    && cp -n ./cloudflared.yml /config/cloudflared/ \
#    && rm -f ./cloudflared.yml

# run stubby as service
mkdir -p /etc/services.d/stubby \
    && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/stubby/run \
    && echo 's6-echo "Starting stubby"' >> /etc/services.d/stubby/run \
    && echo 'stubby -C /config/stubby.yml' >> /etc/services.d/stubby/run \
    && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/stubby/finish \
    && echo 's6-echo "Stopping stubby"' >> /etc/services.d/stubby/finish \
    && echo 'killall -9 stubby' >> /etc/services.d/stubby/finish

# run cloudflared as service
mkdir -p /etc/services.d/cloudflared \
    && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/cloudflared/run \
    && echo 's6-echo "Starting cloudflared"' >> /etc/services.d/cloudflared/run \
    && echo '/usr/local/bin/cloudflared --config /config/cloudflared.yml' >> /etc/services.d/cloudflared/run \
    && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/cloudflared/finish \
    && echo 's6-echo "Stopping cloudflared"' >> /etc/services.d/cloudflared/finish \
    && echo 'killall -9 cloudflared' >> /etc/services.d/cloudflared/finish
