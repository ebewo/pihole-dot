FROM pihole/pihole:latest

# COPY install.sh pihole-updatelists.* /tmp/pihole-updatelists/
RUN apt-get -y update && \
    apt-get -y dist-upgrade && \
    apt-get -y install sudo bash nano
 
RUN apt-get update && \
    apt-get install -Vy php-cli php-sqlite3 php-intl php-curl stubby && \
    apt-get clean && \
    rm -fr /var/cache/apt/* /var/lib/apt/lists/*.lz4

#RUN chmod +x /tmp/pihole-updatelists/install.sh && \
#    bash /tmp/pihole-updatelists/install.sh && \
#    rm -fr /tmp/pihole-updatelists

#RUN [ "$(awk -F/ '$2 == "docker"' /proc/self/cgroup)" == "" ] && echo "Not Docker" || echo "This Docker"
RUN wget -O - https://raw.githubusercontent.com/jacklul/pihole-updatelists/master/install.sh | bash

RUN mkdir -p /etc/stubby && \
    rm -f /etc/stubby/stubby.yml

ADD stuff /temp

VOLUME ["/config"]

RUN /bin/bash /temp/install.sh && \
    rm -f /temp/install.sh
