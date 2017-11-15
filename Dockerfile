ARG ALPINE_VER

FROM alpine:${ALPINE_VER}

RUN set -xe && \
    apk add --update alpine-sdk bash su-exec && \
    adduser -u 1000 -D -S -s /bin/bash -G abuild alpine && \
    echo "PS1='\w\$ '" >> /home/alpine/.bashrc && \
    echo "alpine ALL=(root) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /var/cache/distfiles && \
    chmod a+w /var/cache/distfiles && \
    chgrp abuild /var/cache/distfiles && \
    chmod g+w /var/cache/distfiles && \
    su-exec alpine git clone git://git.alpinelinux.org/aports /home/alpine/aports

USER alpine

COPY entrypoint.sh /

WORKDIR /home/alpine

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
