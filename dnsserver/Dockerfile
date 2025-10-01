FROM debian:13

RUN apt update  && apt install -y \
    procps \
    iproute2 \
    iputils-ping \
    bind9 \
    bind9utils \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# COPY named.conf.options /etc/bind/named.conf.options
COPY db.starwars.lan /etc/bind/db.starwars.lan
RUN mkdir -p /dns
COPY entrypoint.sh /dns
RUN chmod a+x /dns/entrypoint.sh
EXPOSE 53
# USER bind
WORKDIR /var/cache/bind

CMD ["-4"]

ENTRYPOINT ["/dns/entrypoint.sh"]

