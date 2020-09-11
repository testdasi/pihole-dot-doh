FROM testdasi/pihole-base-buster-plus:latest-amd64

ARG DOH=yes
ARG DOT=yes

ADD stuff /tmp

RUN /bin/bash /tmp/install.sh \
    && rm -f /tmp/install.sh
