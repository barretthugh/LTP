FROM ubuntu:16.04

ENV TZ=Asia/Shanghai

#COPY pip.conf /root/.pip/pip.conf 				  for mirror in China
#COPY source.list /etc/apt/sources.list			for mirror in China

RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    ca-certificates \
    cmake \
    curl \
    g++ \
    git \
    make \
    unzip \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && git clone https://github.com/HIT-SCIR/ltp.git ltp \
    && cd ltp \
    && ./configure \
    && make -j "$(nproc)" \
    && mv bin/ltp_server / \
    && mv lib/libdynet.so /usr/lib/ \
    && cd / \
    && rm -fr ltp \
    && curl --silent -o ltp_data.zip http://ospm9rsnd.bkt.clouddn.com/model/ltp_data_v3.4.0.zip \
    && unzip ltp_data.zip \
    && mv ltp_data_v3.4.0 ltp_data \
    && rm -f ltp_data.zip

# TBD
