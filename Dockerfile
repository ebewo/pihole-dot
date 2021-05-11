FROM pihole/pihole:latest

# COPY install.sh pihole-updatelists.* /tmp/pihole-updatelists/

RUN apt-get update && \
    apt-get install -Vy php-cli php-sqlite3 php-intl php-curl stubby && \
    apt-get clean && \
    rm -fr /var/cache/apt/* /var/lib/apt/lists/*.lz4

#RUN chmod +x /tmp/pihole-updatelists/install.sh && \
#    bash /tmp/pihole-updatelists/install.sh && \
#    rm -fr /tmp/pihole-updatelists

RUN wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash

RUN mkdir -p /etc/stubby && \
    rm -f /etc/stubby/stubby.yml

ADD stuff /temp

RUN /bin/bash /temp/install.sh && \
    rm -f /temp/install.sh
#force
