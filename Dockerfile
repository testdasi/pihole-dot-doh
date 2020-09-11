FROM testdasi/pihole-base-buster-plus:latest-amd64

ADD stuff /temp

RUN /bin/bash /temp/install.sh \
    && rm -f /temp/install.sh

VOLUME ["/config"]
