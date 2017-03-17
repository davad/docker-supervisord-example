FROM krallin/ubuntu-tini
MAINTAINER David Landry <david@dmwl.net>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# install packages
RUN apt-get update && \
    apt-get install -y \
      supervisor \
      bash \
    && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD docker-entrypoint.sh /docker-entrypoint.sh

# start supervisor
ENTRYPOINT ["/usr/local/bin/tini", "--", "/docker-entrypoint.sh"]
CMD ["/bin/bash"]
