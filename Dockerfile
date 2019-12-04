<<<<<<< HEAD
FROM phusion/baseimage:0.10.1
MAINTAINER The x4trade decentralized organisation
=======
FROM phusion/baseimage:0.11
MAINTAINER The bitshares decentralized organisation
>>>>>>> e3e2ceed594585572f7566195e831c84456f5f94

ENV LANG=en_US.UTF-8
RUN \
    apt-get update -y && \
    apt-get install -y \
      g++ \
      autoconf \
      cmake \
      git \
      libbz2-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      libncurses-dev \
      libboost-thread-dev \
      libboost-iostreams-dev \
      libboost-date-time-dev \
      libboost-system-dev \
      libboost-filesystem-dev \
      libboost-program-options-dev \
      libboost-chrono-dev \
      libboost-test-dev \
      libboost-context-dev \
      libboost-regex-dev \
      libboost-coroutine-dev \
      libtool \
      doxygen \
      ca-certificates \
      fish \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD . /x4trade-core
WORKDIR /x4trade-core

# Compile
RUN \
    ( git submodule sync --recursive || \
      find `pwd`  -type f -name .git | \
	while read f; do \
	  rel="$(echo "${f#$PWD/}" | sed 's=[^/]*/=../=g')"; \
	  sed -i "s=: .*/.git/=: $rel/=" "$f"; \
	done && \
      git submodule sync --recursive ) && \
    git submodule update --init --recursive && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
	-DGRAPHENE_DISABLE_UNITY_BUILD=ON \
        . && \
    make witness_node cli_wallet get_dev_key && \
    install -s programs/witness_node/witness_node programs/genesis_util/get_dev_key programs/cli_wallet/cli_wallet /usr/local/bin && \
    #
    # Obtain version
    mkdir /etc/x4trade && \
    git rev-parse --short HEAD > /etc/x4trade/version && \
    cd / && \
    rm -rf /x4trade-core

# Home directory $HOME
WORKDIR /
RUN useradd -s /bin/bash -m -d /var/lib/x4trade x4trade
ENV HOME /var/lib/x4trade
RUN chown x4trade:x4trade -R /var/lib/x4trade

# Volume
VOLUME ["/var/lib/x4trade", "/etc/x4trade"]

# rpc service:
EXPOSE 8090
# p2p service:
EXPOSE 1776

# default exec/config files
ADD docker/default_config.ini /etc/x4trade/config.ini
ADD docker/x4tradeentry.sh /usr/local/bin/x4tradeentry.sh
RUN chmod a+x /usr/local/bin/x4tradeentry.sh

# Make Docker send SIGINT instead of SIGTERM to the daemon
STOPSIGNAL SIGINT

# default execute entry
CMD ["/usr/local/bin/x4tradeentry.sh"]
