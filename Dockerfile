FROM ubuntu:eoan

RUN apt-get update \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y --no-install-recommends \
        gosu \
        xfce4 \
        xfce4-goodies \
        xorg \
        dbus-x11 \
        x11-xserver-utils \
        xrdp \
        xorgxrdp \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1020 ubuntu \
    && useradd --shell /bin/bash --uid 1020 --gid 1020 --password $(openssl passwd ubuntu) \
        --create-home --home-dir /home/ubuntu ubuntu

RUN echo xfce4-session >/home/ubuntu/.xsession \
    && chown -R ubuntu:ubuntu /home/ubuntu

COPY entrypoint.sh /usr/bin/entrypoint
WORKDIR /home/ubuntu
EXPOSE 3389/tcp
ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/bash"]
