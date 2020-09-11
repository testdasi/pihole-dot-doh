#!/bin/bash

# install stubby config
cd /tmp \
    && mkdir -p /config/stubby \
    && cp -n ./stubby.yml /config/stubby/ \
    && rm -f ./stubby.yml

# install cloudflared config
cd /tmp \
    && mkdir -p /config/cloudflared \
    && cp -n ./cloudflared.yml /config/cloudflared/ \
    && rm -f ./cloudflared.yml

if [ "$DOT" = "yes" ]
then
    # run stubby as service
    mkdir -p /etc/services.d/stubby \
        && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/stubby/run \
        && echo 's6-echo "Starting stubby"' >> /etc/services.d/stubby/run \
        && echo 'stubby -C /config/stubby/stubby.yml' >> /etc/services.d/stubby/run \
        && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/stubby/finish \
        && echo 's6-echo "Stopping stubby"' >> /etc/services.d/stubby/finish \
        && echo 'killall -9 stubby' >> /etc/services.d/stubby/finish
else
    rm -f /etc/services.d/stubby/run
    rm -f /etc/services.d/stubby/finish
fi

if [ "$DOH" = "yes" ]
then
    # run cloudflared as service
    mkdir -p /etc/services.d/cloudflared \
        && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/cloudflared/run \
        && echo 's6-echo "Starting cloudflared"' >> /etc/services.d/cloudflared/run \
        && echo '/usr/local/bin/cloudflared --config /etc/cloudflared/cloudflared.yml' >> /etc/services.d/cloudflared/run \
        && echo '#!/usr/bin/with-contenv bash' > /etc/services.d/cloudflared/finish \
        && echo 's6-echo "Stopping cloudflared"' >> /etc/services.d/cloudflared/finish \
        && echo 'killall -9 cloudflared' >> /etc/services.d/cloudflared/finish
else
    rm -f /etc/services.d/cloudflared/run
    rm -f /etc/services.d/cloudflared/finish
fi
